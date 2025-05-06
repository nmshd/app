import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_runtime_bridge/src/data_view_expander.dart';
import 'package:enmeshed_runtime_bridge/src/services/services.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../setup.dart';
import '../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  group('[MessageDVO]', () {
    late TransportServices transportServices1;
    late DataViewExpander expander1;
    late TransportServices transportServices2;
    late DataViewExpander expander2;

    late String transportService2Address;
    late String fileId;
    late String messageId;
    late String mailId;

    setUpAll(() async {
      final account1 = await runtime.accountServices.createAccount(name: 'expander-messagedvo-1');
      final session1 = runtime.getSession(account1.id);
      transportServices1 = session1.transportServices;
      expander1 = session1.expander;

      final account2 = await runtime.accountServices.createAccount(name: 'expander-messagedvo-2');
      final session2 = runtime.getSession(account2.id);
      transportServices2 = session2.transportServices;
      expander2 = session2.expander;

      await ensureActiveRelationship(session1, session2);

      final file = await uploadFile(session1);
      fileId = file.id;

      transportService2Address = (await transportServices2.account.getIdentityInfo()).value.address;

      final result = await transportServices1.messages.sendMessage(recipients: [transportService2Address], content: emptyMessageContent);
      messageId = result.value.id;

      final mailResult = await transportServices1.messages.sendMessage(
        recipients: [transportService2Address],
        content: Mail(
          body: 'This is a Mail.',
          cc: const [],
          subject: 'Mail Subject',
          to: [transportService2Address],
        ),
        attachments: [fileId],
      );
      mailId = mailResult.value.id;

      final messages = await syncUntilHasMessages(session2, expectedNumberOfMessages: 2);
      expect(messages.length, 2);
    });

    test('check the message dvo for the sender', () async {
      final dto = (await transportServices1.messages.getMessage(messageId)).value;
      final dvo = await expander1.expandMessageDTO(dto);
      expect(dvo.id, messageId);
      expect(dvo.name, 'i18n://dvo.message.name');
      expect(dvo.description, null);
      expect(dvo.type, 'MessageDVO');
      expect(dvo.date, dto.createdAt);
      expect(dvo.createdAt, dto.createdAt);
      expect(dvo.createdByDevice, dto.createdByDevice);
      expect(dvo.id, dto.id);
      expect(dvo.isOwn, true);
      expect(dvo.createdBy.type, 'IdentityDVO');
      expect(dvo.createdBy.id, dto.createdBy);
      expect(dvo.createdBy.name, 'i18n://dvo.identity.self.name');
      expect(dvo.createdBy.isSelf, true);
      final recipient = dvo.recipients[0];
      expect(recipient.type, 'RecipientDVO');
      expect(recipient.id, dto.recipients[0].address);
      expect(recipient.name, 'i18n://dvo.identity.unknown');
      expect(recipient.isSelf, false);
      expect(dvo.status, MessageStatus.Delivering);
    });

    test('check the message dvo for the recipient', () async {
      final dto = (await transportServices2.messages.getMessage(messageId)).value;
      final dvo = await expander2.expandMessageDTO(dto);
      expect(dvo.id, messageId);
      expect(dvo.name, 'i18n://dvo.message.name');
      expect(dvo.description, null);
      expect(dvo.type, 'MessageDVO');
      expect(dvo.date, dto.createdAt);
      expect(dvo.createdAt, dto.createdAt);
      expect(dvo.createdByDevice, dto.createdByDevice);
      expect(dvo.id, dto.id);
      expect(dvo.isOwn, false);
      expect(dvo.createdBy.type, 'IdentityDVO');
      expect(dvo.createdBy.id, dto.createdBy);
      expect(dvo.createdBy.name, 'i18n://dvo.identity.unknown');
      expect(dvo.createdBy.isSelf, false);
      final recipient = dvo.recipients[0];
      expect(recipient.type, 'RecipientDVO');
      expect(recipient.id, dto.recipients[0].address);
      expect(recipient.name, 'i18n://dvo.identity.self.name');
      expect(recipient.isSelf, true);
      expect(dvo.status, MessageStatus.Received);
    });

    test('check the mail dvo for the sender', () async {
      final dto = (await transportServices1.messages.getMessage(mailId)).value;
      final dvo = (await expander1.expandMessageDTO(dto)) as MailDVO;
      expect(dto.content, isA<Mail>());

      final mail = dto.content as Mail;
      expect(dvo.id, mailId);
      expect(dvo.name, 'Mail Subject');
      expect(dvo.description, null);
      expect(dvo.type, 'MailDVO');
      expect(dvo.date, dto.createdAt);
      expect(dvo.createdAt, dto.createdAt);
      expect(dvo.createdByDevice, dto.createdByDevice);
      expect(dvo.id, dto.id);
      expect(dvo.isOwn, true);
      expect(dvo.createdBy.type, 'IdentityDVO');
      expect(dvo.createdBy.id, dto.createdBy);
      expect(dvo.createdBy.name, 'i18n://dvo.identity.self.name');
      expect(dvo.createdBy.description, 'i18n://dvo.identity.self.description');
      expect(dvo.createdBy.initials, 'i18n://dvo.identity.self.initials');
      expect(dvo.createdBy.isSelf, true);

      expect(dvo.recipients, hasLength(1));
      final recipient = dvo.recipients[0];
      expect(recipient.type, 'RecipientDVO');
      expect(recipient.id, dto.recipients[0].address);
      expect(recipient.name, 'i18n://dvo.identity.unknown');
      expect(recipient.isSelf, false);

      expect(dvo.to, hasLength(1));
      final to = dvo.to[0];
      expect(to.type, 'RecipientDVO');
      expect(to.id, mail.to[0]);
      expect(to.name, 'i18n://dvo.identity.unknown');
      expect(to.isSelf, false);
      expect(dvo.toCount, mail.to.length);
      expect(dvo.ccCount, mail.cc!.length);
      expect(dvo.subject, mail.subject);
      expect(dvo.body, mail.body);
    });

    test('check the mail dvo for the recipient', () async {
      final dto = (await transportServices2.messages.getMessage(mailId)).value;
      final dvo = (await expander2.expandMessageDTO(dto)) as MailDVO;
      expect(dto.content, isA<Mail>());
      final mail = dto.content as Mail;

      expect(dvo.id, mailId);
      expect(dvo.name, 'Mail Subject');
      expect(dvo.description, null);
      expect(dvo.type, 'MailDVO');
      expect(dvo.date, dto.createdAt);
      expect(dvo.createdAt, dto.createdAt);
      expect(dvo.createdByDevice, dto.createdByDevice);
      expect(dvo.id, dto.id);
      expect(dvo.isOwn, false);
      expect(dvo.createdBy.type, 'IdentityDVO');
      expect(dvo.createdBy.id, dto.createdBy);
      expect(dvo.createdBy.name, 'i18n://dvo.identity.unknown');
      expect(dvo.createdBy.isSelf, false);
      final recipient = dvo.recipients[0];
      expect(recipient.type, 'RecipientDVO');
      expect(recipient.id, dto.recipients[0].address);
      expect(recipient.name, 'i18n://dvo.identity.self.name');
      expect(recipient.description, 'i18n://dvo.identity.self.description');
      expect(recipient.initials, 'i18n://dvo.identity.self.initials');
      expect(recipient.isSelf, true);

      expect(dvo.to, hasLength(1));
      final to = dvo.to[0];
      expect(to.type, 'RecipientDVO');
      expect(to.id, mail.to[0]);
      expect(to.name, 'i18n://dvo.identity.self.name');
      expect(to.isSelf, true);
      expect(dvo.toCount, mail.to.length);
      expect(dvo.ccCount, mail.cc!.length);
      expect(dvo.subject, mail.subject);
      expect(dvo.body, mail.body);
    });
  });
}
