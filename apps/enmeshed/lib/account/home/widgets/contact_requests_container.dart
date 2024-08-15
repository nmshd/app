import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:i18n_translated_text/i18n_translated_text.dart';
import 'package:logger/logger.dart';
import 'package:renderers/renderers.dart';

import '/core/core.dart';
import 'info_container.dart';

class ContactRequestsContainer extends StatelessWidget {
  final String accountId;
  final List<LocalRequestDVO> relationshipRequests;

  const ContactRequestsContainer({
    required this.accountId,
    required this.relationshipRequests,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _ContactRequestsHeader(accountId: accountId, relationshipRequests: relationshipRequests),
          if (relationshipRequests.isNotEmpty)
            _ContactRequestsAvailable(requests: relationshipRequests, accountId: accountId)
          else
            EmptyListIndicator(icon: Icons.contact_page_outlined, text: context.l10n.home_noNewContactRequests),
        ],
      ),
    );
  }
}

class _ContactRequestsHeader extends StatelessWidget {
  final String accountId;
  final List<LocalRequestDVO> relationshipRequests;

  const _ContactRequestsHeader({
    required this.accountId,
    required this.relationshipRequests,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(context.l10n.home_contactRequests, style: Theme.of(context).textTheme.titleLarge),
            Gaps.w8,
            Visibility(
              visible: relationshipRequests.isNotEmpty,
              child: Badge(
                label: Text(relationshipRequests.length.toString()),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
        TextButton(
          // TODO(jkoenig134): when the contacts requests container is re-enabled this should go to the contacts page pre-filtered to show only requests
          onPressed: () => context.go('/account/$accountId/contacts'),
          child: Text(context.l10n.home_seeAll),
        ),
      ],
    );
  }
}

class _ContactRequestsAvailable extends StatelessWidget {
  final List<LocalRequestDVO> requests;
  final String accountId;

  const _ContactRequestsAvailable({required this.requests, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: requests.length,
        itemBuilder: (BuildContext context, int index) => _ContactRequestItem(requests[index], accountId),
        separatorBuilder: (_, __) => Gaps.w16,
      ),
    );
  }
}

class _ContactRequestItem extends StatelessWidget {
  final LocalRequestDVO request;
  final String accountId;

  const _ContactRequestItem(this.request, this.accountId);

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      width: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ContactCircleAvatar(radius: 20, contact: request.peer),
              Gaps.w16,
              Flexible(
                child: TranslatedText(
                  request.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  final controller = RequestRendererController(request: request);

                  unawaited(showLoadingDialog(context, context.l10n.request_rejecting));

                  final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

                  final canReject = await session.consumptionServices.incomingRequests.canReject(params: controller.rejectParams);
                  if (canReject.isError) {
                    // TODO(jkoenig134): show error to user

                    GetIt.I.get<Logger>().e('Can not reject request: ${canReject.error}');
                    if (context.mounted) context.pop();

                    return;
                  }

                  final rejectResult = await session.consumptionServices.incomingRequests.reject(params: controller.rejectParams);
                  if (rejectResult.isError) {
                    // TODO(jkoenig134): show error to user

                    GetIt.I.get<Logger>().e('Can not reject request: ${canReject.error}');
                    if (context.mounted) context.pop();

                    return;
                  }

                  if (context.mounted) context.pop();
                },
                child: Text(context.l10n.reject),
              ),
              Gaps.w8,
              OutlinedButton(
                onPressed: () => context.go('/account/$accountId/contacts/contact-request/${request.id}', extra: request),
                child: Text(context.l10n.edit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
