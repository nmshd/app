import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers.dart';
import '../../../setup.dart';
import '../../../utils.dart';

void main() async => run(await setup());

void run(EnmeshedRuntime runtime) {
  late Session session1;
  late Session session2;
  late String addressSession2;

  setUpAll(() async {
    final account1 = await runtime.accountServices.createAccount(name: 'relationshipTemplateFacade Test 1');
    session1 = runtime.getSession(account1.id);

    final account2 = await runtime.accountServices.createAccount(name: 'relationshipTemplateFacade Test 2');
    session2 = runtime.getSession(account2.id);
    addressSession2 = (await session2.transportServices.account.getIdentityInfo()).value.address;
  });

  group('RelationshipTemplatesFacade: createOwnRelationshipTemplate', () {
    test('should create a template', () async {
      final expiresAt = generateExpiryString();
      final content = ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'});

      final templateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      expect(templateResult, isSuccessful<RelationshipTemplateDTO>());
      expect(templateResult.value.expiresAt, expiresAt);
      expect(templateResult.value.content, content);
    });

    test('should create a template with all properties', () async {
      final expiresAt = generateExpiryString();
      final content = ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'});

      const maxNumberOfAllocations = 1;

      final templateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
        maxNumberOfAllocations: maxNumberOfAllocations,
        forIdentity: addressSession2,
      );

      expect(templateResult, isSuccessful<RelationshipTemplateDTO>());
      expect(templateResult.value.expiresAt, expiresAt);
      expect(templateResult.value.content, content);
      expect(templateResult.value.maxNumberOfAllocations, maxNumberOfAllocations);
      expect(templateResult.value.forIdentity, addressSession2);
    });
  });

  group('RelationshipTemplatesFacade: loadPeerRelationshipTemplate', () {
    test('should allow to load template of peer by entering reference', () async {
      final expiresAt = generateExpiryString();
      final content = ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'});

      final responseTemplate = await session2.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final templateResult = await session1.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(
        reference: responseTemplate.value.truncatedReference,
      );

      expect(templateResult, isSuccessful<RelationshipTemplateDTO>());
      expect(templateResult.value.expiresAt, expiresAt);
      expect(templateResult.value.content, content);
      expect(templateResult.value.truncatedReference, responseTemplate.value.truncatedReference);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplates', () {
    late String expiryDate = generateExpiryString();

    setUpAll(() async {
      expiryDate = generateExpiryString();
      final templateContent = ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'});

      await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiryDate,
        content: templateContent,
        maxNumberOfAllocations: 1,
      );

      await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: generateExpiryString(),
        content: templateContent,
        maxNumberOfAllocations: 2,
      );

      final addressSession2 = (await session2.transportServices.account.getIdentityInfo()).value.address;
      await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: generateExpiryString(),
        content: templateContent,
        forIdentity: addressSession2,
      );
    });

    test('should return the correct amount of own relationship templates', () async {
      final currentTemplates = await session1.transportServices.relationshipTemplates.getRelationshipTemplates();
      expect(currentTemplates, isSuccessful<List<RelationshipTemplateDTO>>());

      await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: generateExpiryString(),
        content: ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'}),
        maxNumberOfAllocations: 1,
      );

      final allTemplates = await session1.transportServices.relationshipTemplates.getRelationshipTemplates();
      expect(allTemplates, isSuccessful<List<RelationshipTemplateDTO>>());

      expect(allTemplates.value.length, greaterThan(currentTemplates.value.length));
    });

    test('should return the correct amount of own relationship templates querying expiresAt', () async {
      final getRelationshipTemplatesResult = await session1.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'expiresAt': QueryValue.string(expiryDate)},
      );
      expect(getRelationshipTemplatesResult, isSuccessful<List<RelationshipTemplateDTO>>());
      expect(getRelationshipTemplatesResult.value.length, 1);
    });

    test('should return no relationship templates if the query does not match any', () async {
      final getRelationshipTemplatesResult = await session1.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'expiresAt': QueryValue.string('2023')},
      );
      expect(getRelationshipTemplatesResult, isSuccessful<List<RelationshipTemplateDTO>>());
      expect(getRelationshipTemplatesResult.value.length, 0);
    });

    test('should return the correct amount of own relationship templates querying maxNumberOfAllocations', () async {
      final getRelationshipTemplatesResult = await session1.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'maxNumberOfAllocations': QueryValue.string('1')},
      );
      expect(getRelationshipTemplatesResult, isSuccessful<List<RelationshipTemplateDTO>>());
      expect(getRelationshipTemplatesResult.value.where((e) => e.maxNumberOfAllocations != 1).length, 0);
    });

    test('should return the correct amount of own relationship templates querying forIdentity', () async {
      final getRelationshipTemplatesResult = await session1.transportServices.relationshipTemplates.getRelationshipTemplates(
        query: {'forIdentity': QueryValue.string(addressSession2)},
      );
      expect(getRelationshipTemplatesResult, isSuccessful<List<RelationshipTemplateDTO>>());
      expect(getRelationshipTemplatesResult.value.where((e) => e.forIdentity != addressSession2).length, 0);
    });
  });

  group('RelationshipTemplatesFacade: getRelationshipTemplate', () {
    test('should return a valid relationship template', () async {
      final expiresAt = generateExpiryString();
      final content = ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'});

      final createdTemplate = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final template = await session1.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: createdTemplate.value.id,
      );

      expect(template, isSuccessful<RelationshipTemplateDTO>());
      expect(template.value.expiresAt, expiresAt);
      expect(template.value.content, content);
    });

    test('throws an exception on empty template id', () async {
      final result = await session1.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: '',
      );

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception if template id do not match the pattern', () async {
      final result = await session1.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: 'RTLX123456789',
      );

      expect(result, isFailing('error.runtime.validation.invalidPropertyValue'));
    });

    test('throws an exception on not existing template id', () async {
      final result = await session1.transportServices.relationshipTemplates.getRelationshipTemplate(
        relationshipTemplateId: 'RLTXZKg9TestveduKiGs',
      );

      expect(result, isFailing('error.runtime.recordNotFound'));
    });
  });

  group('RelationshipTemplatesFacade: createTokenForOwnRelationshipTemplate', () {
    test('should return a valid TokenDTO', () async {
      final expiresAt = generateExpiryString();
      final content = ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'});

      final createdTemplate = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: content,
      );

      final tokenResult = await session1.transportServices.relationshipTemplates.createTokenForOwnRelationshipTemplate(
        templateId: createdTemplate.value.id,
      );

      expect(tokenResult, isSuccessful<TokenDTO>());
      expect(tokenResult.value.expiresAt, expiresAt);
    });

    test('should return a valid TokenDTO with all properties', () async {
      final expiresAt = generateExpiryString();
      final createdTemplateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
        expiresAt: expiresAt,
        content: ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'}),
      );

      final tokenResult = await session1.transportServices.relationshipTemplates.createTokenForOwnRelationshipTemplate(
        templateId: createdTemplateResult.value.id,
        expiresAt: expiresAt,
        ephemeral: true,
      );

      expect(tokenResult, isSuccessful<TokenDTO>());
      expect(tokenResult.value.expiresAt, expiresAt);
      expect(tokenResult.value.expiresAt, createdTemplateResult.value.expiresAt);
      expect(tokenResult.value.isEphemeral, true);
    });
  });

  group('RelationshipTemplatesFacade: Password Protection', () {
    final relationshipTemplateContent = ArbitraryRelationshipTemplateContent(const {'aKey': 'aValue'});

    final passwordProtections = [
      PasswordProtection(password: 'aPassword'),
      PasswordProtection(password: '1234', passwordIsPin: true),
    ];

    for (final passwordProtection in passwordProtections) {
      test(
          'should create a password protected template with password \'${passwordProtection.password}\' and passwordIsPin \'${passwordProtection.passwordIsPin}\'',
          () async {
        final templateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
          expiresAt: generateExpiryString(),
          content: relationshipTemplateContent,
          passwordProtection: passwordProtection,
        );

        expect(templateResult, isSuccessful<RelationshipTemplateDTO>());
        expect(templateResult.value.passwordProtection, passwordProtection);
      });

      test(
          'should exchange a password protected template with password \'${passwordProtection.password}\' and passwordIsPin \'${passwordProtection.passwordIsPin}\'',
          () async {
        final templateResult = await session1.transportServices.relationshipTemplates.createOwnRelationshipTemplate(
          expiresAt: generateExpiryString(),
          content: relationshipTemplateContent,
          passwordProtection: passwordProtection,
        );

        expect(templateResult, isSuccessful<RelationshipTemplateDTO>());

        final loadResult = await session1.transportServices.relationshipTemplates.loadPeerRelationshipTemplate(
          reference: templateResult.value.truncatedReference,
          password: passwordProtection.password,
        );

        expect(loadResult, isSuccessful<RelationshipTemplateDTO>());
        expect(loadResult.value.passwordProtection, passwordProtection);
      });
    }
  });
}
