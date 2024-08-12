import 'dart:convert';
import 'dart:typed_data';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../mock_event_bus.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late LocalAccountDTO account1;
  late Session session1;
  late LocalAccountDTO account2;
  late Session session2;
  late MockEventBus eventBus;

  setUpAll(() async {
    account1 = await runtime.accountServices.createAccount(name: 'messagesFacade Test 1');
    session1 = runtime.getSession(account1.id);
    account2 = await runtime.accountServices.createAccount(name: 'messagesFacade Test 2');
    session2 = runtime.getSession(account2.id);

    eventBus = runtime.eventBus as MockEventBus;

    await ensureActiveRelationship(session1, session2);
  });

  group('Messaging', () {
    late String session2Address;
    late String fileId;
    late String messageId;

    setUpAll(() async {
      final file = await session1.transportServices.files.uploadOwnFile(
        content: Uint8List.fromList(utf8.encode('a String')).toList(),
        filename: 'messages/test.txt',
        mimetype: 'plain',
        expiresAt: generateExpiryString(),
        title: 'aTitle',
        description: 'aDescription',
      );
      fileId = file.value.id;

      final relationship = await getRelationship(session1);
      session2Address = relationship.peer;
    });

    test('send a Message from session1 to session2', () async {
      final result = await session1.transportServices.messages.sendMessage(
        recipients: [session2Address],
        content: Mail(
          body: 'b',
          cc: const [],
          subject: 'a',
          to: [session2Address],
        ),
        attachments: [fileId],
      );

      expect(result, isSuccessful<MessageDTO>());

      final event = await eventBus.waitForEvent<MessageSentEvent>(eventTargetAddress: account1.address!);

      expect(event.data.id, result.value.id);

      messageId = result.value.id;
    });

    test('receive the message in a sync run', () async {
      final message = await syncUntilHasMessage(session2);

      expect(message.id, messageId);
      expect(message.content.toJson(), {
        '@type': 'Mail',
        'body': 'b',
        'cc': [],
        'subject': 'a',
        'to': [session2Address],
      });
    });

    test('receive the message on session2 in /Messages', () async {
      final responseResult = await session2.transportServices.messages.getMessages();

      expect(responseResult, isSuccessful<List<MessageDTO>>());

      final message = responseResult.value.first;

      expect(responseResult.value.length, 1);
      expect(message.id, messageId);
      expect(message.content.toJson(), {
        '@type': 'Mail',
        'body': 'b',
        'cc': [],
        'subject': 'a',
        'to': [session2Address],
      });
    });

    test('receive the message on session2 in /Messages/{id}', () async {
      final responseResult = await session2.transportServices.messages.getMessage(messageId);

      expect(responseResult, isSuccessful<MessageWithAttachmentsDTO>());
      expect(responseResult.value.id, messageId);
    });

    test('receive the message on session2 by querying the recipients address', () async {
      final responseResult = await session2.transportServices.messages.getMessages(query: {'recipients.address': QueryValue.string(session2Address)});

      expect(responseResult, isSuccessful<List<MessageDTO>>());

      final message = responseResult.value.first;

      expect(responseResult.value.length, 1);
      expect(message.id, messageId);
      expect(message.content.toJson(), {
        '@type': 'Mail',
        'body': 'b',
        'cc': [],
        'subject': 'a',
        'to': [session2Address],
      });
    });

    test('receives an empty list by querying something that does not exist', () async {
      final responseResult = await session2.transportServices.messages.getMessages(query: {'recipients.address': QueryValue.string('anAddress')});

      expect(responseResult, isSuccessful<List<MessageDTO>>());
      expect(responseResult.value, isEmpty);
    });

    test('download the attachment', () async {
      final attachmentResult = await session1.transportServices.messages.downloadAttachment(messageId: messageId, attachmentId: fileId);

      expect(attachmentResult, isSuccessful<DownloadFileResponse>());
      expect(utf8.decode(attachmentResult.value.content), 'a String');
      expect(attachmentResult.value.filename, 'messages/test.txt');
      expect(attachmentResult.value.mimeType, 'plain');
    });

    test('return the metadata of the attachment', () async {
      final attachmentResult = await session1.transportServices.messages.getAttachmentMetadata(messageId: messageId, attachmentId: fileId);

      expect(attachmentResult, isSuccessful<FileDTO>());
      expect(attachmentResult.value.id, fileId);
      expect(attachmentResult.value.filename, 'messages/test.txt');
      expect(attachmentResult.value.mimetype, 'plain');
      expect(attachmentResult.value.title, 'aTitle');
      expect(attachmentResult.value.description, 'aDescription');
    });

    group('Mark Message as', () {
      test('read', () async {
        final result = await session1.transportServices.messages.sendMessage(
          recipients: [session2Address],
          content: Mail(to: [session2Address], subject: 'subject', body: 'body'),
          attachments: [fileId],
        );
        final message = result.value;

        await syncUntilHasMessage(session2);

        final markAsReadResult = await session2.transportServices.messages.markMessageAsRead(message.id);

        expect(markAsReadResult, isSuccessful<MessageDTO>());
        expect(markAsReadResult.value.wasReadAt, isNotNull);
      });

      test('unread', () async {
        final result = await session1.transportServices.messages.sendMessage(
          recipients: [session2Address],
          content: Mail(to: [session2Address], subject: 'subject', body: 'body'),
          attachments: [fileId],
        );
        final message = result.value;

        await syncUntilHasMessage(session2);

        await session2.transportServices.messages.markMessageAsRead(message.id);
        final markAsReadResult = await session2.transportServices.messages.markMessageAsUnread(message.id);

        expect(markAsReadResult, isSuccessful<MessageDTO>());
        expect(markAsReadResult.value.wasReadAt, isNull);
      });
    });
  });

  group('Message errors', () {
    const fakeAddress = 'did:e:a-domain:dids:fef1992c5e529adc413288';
    test('should throw correct error for empty "to" in the Message', () async {
      final result = await session1.transportServices.messages.sendMessage(
        recipients: [fakeAddress],
        content: const Mail(
          subject: 'aSubject',
          to: [],
          body: 'aBody',
        ),
      );

      expect(result, isFailing('error.runtime.requestDeserialization'));
    });

    test('should throw correct error if file id does not match the pattern', () async {
      final result = await session2.transportServices.messages.getMessage('');

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('should throw correct error if id is not existing', () async {
      final result = await session2.transportServices.messages.getMessage('MSG1DXTESTym7S9olGxE');

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('Message query', () {
    test('query messages by relationship ids', () async {
      final recipient1account = await runtime.accountServices.createAccount(name: 'messagesFacade recipient 1');
      final recipient1 = runtime.getSession(recipient1account.id);
      final recipient2account = await runtime.accountServices.createAccount(name: 'messagesFacade recipient 2');
      final recipient2 = runtime.getSession(recipient2account.id);

      await ensureActiveRelationship(session1, recipient1);
      await ensureActiveRelationship(session1, recipient2);

      final addressRecipient1 = (await recipient1.transportServices.account.getIdentityInfo()).value.address;
      final addressRecipient2 = (await recipient2.transportServices.account.getIdentityInfo()).value.address;

      final relationshipToRecipient1 = await session1.transportServices.relationships.getRelationshipByAddress(address: addressRecipient1);
      final relationshipToRecipient2 = await session1.transportServices.relationships.getRelationshipByAddress(address: addressRecipient2);

      await session1.transportServices.messages.sendMessage(recipients: [addressRecipient1], content: emptyMessageContent);
      await session1.transportServices.messages.sendMessage(recipients: [addressRecipient2], content: emptyMessageContent);

      final messagesToRecipient1 = await session1.transportServices.messages.getMessages(query: {
        'recipients.relationshipId': QueryValue.string(relationshipToRecipient1.value.id),
      });

      final messagesToRecipient2 = await session1.transportServices.messages.getMessages(query: {
        'recipients.relationshipId': QueryValue.string(relationshipToRecipient2.value.id),
      });

      final messagesToRecipient1Or2 = await session1.transportServices.messages.getMessages(query: {
        'recipients.relationshipId': QueryValue.stringList([relationshipToRecipient1.value.id, relationshipToRecipient2.value.id]),
      });

      expect(messagesToRecipient1.value.length, 1);
      expect(messagesToRecipient2.value.length, 1);
      expect(messagesToRecipient1Or2.value.length, 2);
    });
  });
}
