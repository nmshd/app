import 'dart:io';

import 'package:collection/collection.dart';
import 'package:connector_sdk/connector_sdk.dart';
import 'package:enmeshed_types/enmeshed_types.dart' as enmeshed_types;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:window_size/window_size.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<enmeshed_types.RelationshipDTO> relationships = [];

  @override
  void initState() {
    super.initState();

    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final client = GetIt.I.get<ConnectorClient>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _reload),
          IconButton(onPressed: _showInfoDialog, icon: const Icon(Icons.info)),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) => ExpansionTile(
            leading: relationships[index].status == enmeshed_types.RelationshipStatus.Active
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                  )
                : null,
            title: FutureBuilder(
              future: renderRelationship(relationships[index]),
              builder: (context, snapshot) => snapshot.hasData ? Text(snapshot.data.toString()) : Text(relationships[index].peer),
            ),
            children: [
              Text('ID: ${relationships[index].id}'),
              Text('Peer: ${relationships[index].peer}'),
              Text('Status: ${relationships[index].status.name}'),
              ExpansionTile(
                title: const Text('Attributes'),
                children: [
                  FutureBuilder(
                    future: client.relationships.getAttributesForRelationship(relationships[index].id),
                    builder: (context, snapshot) => snapshot.hasData
                        ? Column(children: snapshot.data!.data.map((e) => Text(e.content.toString())).toList())
                        : const Text('Loading...'),
                  ),
                ],
              ),
            ],
          ),
          itemCount: relationships.length,
        ),
      ),
    );
  }

  Future<void> _showInfoDialog() async {
    final client = GetIt.I.get<ConnectorClient>();
    final identityInfoResponse = await client.account.getIdentityInfo();
    final identityInfo = identityInfoResponse.data;

    if (context.mounted) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Connector Info'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'Connector BaseURL: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(client.baseUrl),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => Clipboard.setData(ClipboardData(text: client.baseUrl)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Connector Address: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(identityInfo.address),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => Clipboard.setData(ClipboardData(text: identityInfo.address)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Connector Public Key: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(identityInfo.publicKey),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => Clipboard.setData(ClipboardData(text: identityInfo.publicKey)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  void _reload() async {
    final client = GetIt.I.get<ConnectorClient>();

    await client.account.sync();

    final relationships = (await client.relationships.getRelationships()).data;
    setState(() {
      this.relationships = relationships;
    });
  }

  void _logout() {
    GetIt.I.unregister<ConnectorClient>();

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('Connector Management UI');
    }

    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future<String> renderRelationship(enmeshed_types.RelationshipDTO relationship) async {
    final client = GetIt.I.get<ConnectorClient>();

    final response = await client.relationships.getAttributesForRelationship(relationship.id);
    final relationshipAttributes = response.data.where((a) => a.content.owner == relationship.peer);

    final displayName = relationshipAttributes
        .where(
          (a) => a.content is enmeshed_types.IdentityAttribute && (a.content as enmeshed_types.IdentityAttribute).value is enmeshed_types.DisplayName,
        )
        .firstOrNull;
    if (displayName != null) {
      return '${relationship.peer} (${((displayName.content as enmeshed_types.IdentityAttribute).value as enmeshed_types.DisplayName).value})';
    }

    final surname = relationshipAttributes
        .where(
          (a) => a.content is enmeshed_types.IdentityAttribute && (a.content as enmeshed_types.IdentityAttribute).value is enmeshed_types.Surname,
        )
        .firstOrNull;
    final givenName = relationshipAttributes
        .where(
          (a) => a.content is enmeshed_types.IdentityAttribute && (a.content as enmeshed_types.IdentityAttribute).value is enmeshed_types.GivenName,
        )
        .firstOrNull;
    if (surname != null || givenName != null) {
      final name =
          '${((surname!.content as enmeshed_types.IdentityAttribute).value as enmeshed_types.Surname).value} ${((givenName!.content as enmeshed_types.IdentityAttribute).value as enmeshed_types.GivenName).value}'
              .trim();
      return '${relationship.peer} ($name)';
    }

    return relationship.peer;
  }
}
