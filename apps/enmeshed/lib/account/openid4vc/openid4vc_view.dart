import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenId4VcView extends StatefulWidget {
  const OpenId4VcView({required this.accountId, super.key});

  final String accountId;

  @override
  State<OpenId4VcView> createState() => _OpenId4VcViewState();
}

class _OpenId4VcViewState extends State<OpenId4VcView> {
  late List<Map<String, dynamic>> _claims = [];

  @override
  void initState() {
    super.initState();
    _loadStoredClaims();
  }

  Future<void> _loadStoredClaims() async {
    final preferences = await SharedPreferences.getInstance();
    final storedClaims = preferences.getStringList('storedClaims') ?? [];
    _claims = [];
    for (final raw in storedClaims) {
      try {
        final map = json.decode(raw);
        _claims.add(map as Map<String, dynamic>);
      } catch (_) {
        print('Error decoding stored claim: $raw');
      }
    }

    // reverse the order of the claims to show the most recent first
    _claims = _claims.reversed.toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stored Claims')),
      body: _claims.isEmpty
          ? const Center(child: Text('No stored claims'))
          : RefreshIndicator(
              onRefresh: _loadStoredClaims,
              displacement: 40, // how far the spinner appears from top
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(), // required so RefreshIndicator works even if list is short
                padding: const EdgeInsets.all(16),
                itemCount: _claims.length,
                itemBuilder: (context, index) {
                  final claim = _claims[index];

                  return Card(
                    color: Color(int.parse((claim['offerBackgroundColor'] as String).replaceFirst('#', '0xff'))),
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  claim['title'] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Color(int.parse((claim['offerTextColor'] as String).replaceFirst('#', '0xff'))),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Issued at: ${claim['issuedAt'] ?? 'N/A'}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(int.parse((claim['offerTextColor'] as String).replaceFirst('#', '0xff'))).withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (claim['offerLogo'] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                claim['offerLogo'] as String,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, size: 40),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
