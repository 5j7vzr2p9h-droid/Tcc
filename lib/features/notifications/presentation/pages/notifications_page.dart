import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/notification_type.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../domain/entities/notifications_group.dart';
import '../viewmodels/notifications_viewmodel/notifications_cubit.dart';
import '../viewmodels/notifications_viewmodel/notifications_state.dart';
import '../widgets/no_notifications_placeholder.dart';
import '../widgets/notifications_day_sliver.dart';
import '../widgets/notifications_filter_wrap.dart';

final class NotificationsTab extends StatefulWidget {
  final VoidCallback _onOrdersPressed;

  const new({
    super.key,
    required this._onOrdersPressed
  });

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

final class _NotificationsTabState extends State<NotificationsTab> {
  /// Distance from the end of the list at which the next page starts loading.
  static const double _loadMoreThreshold = 300.0;

  final ValueNotifier<NotificationType?> _selectedFilter = ValueNotifier<NotificationType?>(null);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedFilter.addListener(_reload);
    _scrollController.addListener(_loadMoreIfNearEnd);
  }

  @override
  void dispose() {
    _selectedFilter.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _reload() => context.read<NotificationsCubit>().init(type: _selectedFilter.value);

  void _loadMoreIfNearEnd(){
    if(_scrollController.hasClients && _scrollController.position.extentAfter < _loadMoreThreshold)
      context.read<NotificationsCubit>().loadMore();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(context.l10n.notifications),
      actions: <IconButton>[
        IconButton(
          onPressed: () => Navigator.pushNamed(context, Routes.notificationSettings),
          icon: const Icon(Icons.settings)
        )
      ],
    ),
    body: BlocConsumer<NotificationsCubit, NotificationsState>(
      // A page that doesn't fill the screen can't be scrolled, so check again after every page.
      listenWhen: (NotificationsState _, NotificationsState current)
      => current is NotificationsGetSuccessState && !current.isLoadingMore,
      listener: (BuildContext _, NotificationsState _)
      => WidgetsBinding.instance.addPostFrameCallback((Duration _){
        if(mounted)
          _loadMoreIfNearEnd();
      }),
      builder: (BuildContext context, NotificationsState state)
      => CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          if(!(state is NotificationsGetSuccessState && state.groups.isEmpty && _selectedFilter.value == null))
            SliverPadding(
              padding: const .all(pageContentPadding),
              sliver: SliverToBoxAdapter(
                child: NotificationsFilterWrap(
                  selectedFilter: _selectedFilter
                )
              )
            ),
          switch(state){
            NotificationsInitialState() => const SliverToBoxAdapter(),
            NotificationsLoadingState() => const SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: .only(bottom: bottomNavigationBarSpace),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            NotificationsGetFailureState(:final Failure failure) => SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const .fromLTRB(
                  pageContentPadding,
                  0.0,
                  pageContentPadding,
                  bottomNavigationBarSpace
                ),
                child: Center(
                  child: FailurePlaceHolder(
                    failure: failure,
                    onRetry: _reload,
                  ),
                ),
              ),
            ),
            NotificationsGetSuccessState(:final List<NotificationsGroupEntity> groups) when groups.isEmpty
            => SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const .fromLTRB(
                  pageContentPadding,
                  0.0,
                  pageContentPadding,
                  bottomNavigationBarSpace
                ),
                child: NoNotificationsPlaceholder(
                  onOrdersPressed: widget._onOrdersPressed,
                ),
              ),
            ),
            NotificationsGetSuccessState(
              :final List<NotificationsGroupEntity> groups,
              :final bool isLoadingMore,
              :final Failure? loadMoreFailure
            ) => SliverPadding(
              padding: const .fromLTRB(
                pageContentPadding,
                0.0,
                pageContentPadding,
                bottomNavigationBarSpace
              ),
              sliver: SliverMainAxisGroup(
                slivers: <Widget>[
                  for(final NotificationsGroupEntity group in groups)
                    NotificationsDaySliver(
                      title: DateFormatter.formatDate(context, group.date, isShort: true),
                      notifications: group.notifications,
                    ),
                  if(isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if(loadMoreFailure != null)
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          Text(
                            loadMoreFailure.mapFailureToMessage(context),
                            textAlign: .center,
                            style: TextStyles.font12Weight400.copyWith(
                              color: Colors.grey
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => context.read<NotificationsCubit>().loadMore(retry: true),
                            iconAlignment: .end,
                            icon: const Icon(Icons.refresh),
                            label: Text(context.l10n.retry),
                          )
                        ],
                      ),
                    )
                ],
              ),
            )
          }
        ],
      ),
    ),
  );
}
