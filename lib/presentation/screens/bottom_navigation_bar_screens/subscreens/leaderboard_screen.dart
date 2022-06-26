import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/competition.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/get_lastest_competition_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/get_my_rank_in_competition_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/get_top_users_in_competition_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/competition_banner.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/leaderboard_screen_banner.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/leaderboard_banner_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/my_rank_in_competition_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/leaderboard_entry_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class LeaderboardSubscreen extends ConsumerStatefulWidget {
  const LeaderboardSubscreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LeaderboardSubscreen> createState() =>
      _LeaderboardSubscreenState();
}

class _LeaderboardSubscreenState extends ConsumerState<LeaderboardSubscreen> {
  final GetLatestCompetitionProviderParams _competitionProvParams =
      GetLatestCompetitionProviderParams();
  final GetMyRankInCompetitionProviderParams _myRankProvParams =
      GetMyRankInCompetitionProviderParams();
  final GetTopUsersInCompetitionProviderParams _topUsersProvParams =
      GetTopUsersInCompetitionProviderParams();

  void _getLatestCompeition() {
    ref
        .read(getLatestCompetitionProvider(_competitionProvParams).notifier)
        .getLatestCompetition();
  }

  void _getMyRank() {
    ref
        .read(getMyRankInCompetitionProvider(_myRankProvParams).notifier)
        .getMyRankInCompetition();
  }

  void _getTopUsers() {
    ref
        .read(getTopUsersInCompetitionProvider(_topUsersProvParams).notifier)
        .getTopUsersInCompetition();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getLatestCompeition();
      _getMyRank();
      _getTopUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final compState =
        ref.watch(getLatestCompetitionProvider(_competitionProvParams));
    final myRankState =
        ref.watch(getMyRankInCompetitionProvider(_myRankProvParams));
    final topUsersState =
        ref.watch(getTopUsersInCompetitionProvider(_topUsersProvParams));
    final errWid = fullScreenErrorWidgetOrNull([
      StateAndRetry(state: compState, onRetry: _getLatestCompeition),
      StateAndRetry(state: myRankState, onRetry: _getMyRank),
      StateAndRetry(state: topUsersState, onRetry: _getTopUsers),
    ]);
    if (errWid != null) return errWid;

    return SingleChildScrollView(
      padding: AppEdgeInsets.screenPadding.copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBanner(),
          SizedBox(height: 10.h),
          Text(
            LocaleKeys.yourRanking.tr(),
            style: TextStyleManager.s18w700,
          ),
          _buildMyRank(),
          SizedBox(height: 10.h),
          Text(LocaleKeys.usersRanking.tr(), style: TextStyleManager.s18w700),
          // users ranking card
          _buildTopUsers(),
        ],
      ),
    );
  }

  Widget _buildTopUsers() {
    ref.addErrorListener(
      provider: getTopUsersInCompetitionProvider(_topUsersProvParams),
      context: context,
    );
    final topUsersState =
        ref.watch(getTopUsersInCompetitionProvider(_topUsersProvParams));
    Widget? loadOrErr = loadingOrErrorWidgetOrNull(
      state: topUsersState,
      loadingWidget: MyRankInCompetitionLoading(),
    );
    if (loadOrErr != null) return loadOrErr;

    final competitionState =
        ref.watch(getLatestCompetitionProvider(_competitionProvParams));
    loadOrErr = loadingOrErrorWidgetOrNull(
      state: competitionState,
      loadingWidget: MyRankInCompetitionLoading(),
    );
    if (loadOrErr != null) return loadOrErr;

    final users = (topUsersState as GetTopUsersInCompetitionLoadedState).users;
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Card(
        elevation: AppElevations.ev3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.updatedListTile,
          ),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(
            thickness: 0.5,
            color: ColorManager.dividerGrey,
            indent: 10.w,
            endIndent: 10.w,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            final user = users[index];
            Competition? competition;
            if (competitionState is GetLatestCompetitionLoadedState) {
              competition = competitionState.competition;
            }
            return LeaderboardEntryData(
              onTap: () {
                Navigator.of(context).pushNamed(
                  UserProfileScreen.routeName,
                  arguments: UserProfileScreenArgs(userId: user.id),
                );
              },
              rank: index + 1,
              userImageUrl: user.picture,
              name: user.name,
              isWinner:
                  competition != null && index + 1 <= competition.numWinners,
              starsCounter: user.points,
              prizeName: competition?.prize,
              prizeImageUrl: competition?.prizePic,
            );
          },
        ),
      ),
    );
  }

  Widget _buildMyRank() {
    ref.addErrorListener(
      provider: getMyRankInCompetitionProvider(_myRankProvParams),
      context: context,
    );
    final myRankState =
        ref.watch(getMyRankInCompetitionProvider(_myRankProvParams));
    Widget? loadOrErr = loadingOrErrorWidgetOrNull(
      state: myRankState,
      loadingWidget: MyRankInCompetitionLoading(),
    );
    if (loadOrErr != null) return loadOrErr;

    final competitionState =
        ref.watch(getLatestCompetitionProvider(_competitionProvParams));
    loadOrErr = loadingOrErrorWidgetOrNull(
      state: myRankState,
      loadingWidget: MyRankInCompetitionLoading(),
    );
    if (loadOrErr != null) return loadOrErr;

    final user = (myRankState as GetMyRankInCompetitionLoadedState).user;
    Competition? competition;
    if (competitionState is GetLatestCompetitionLoadedState) {
      competition = competitionState.competition;
    }
    return LeaderboardEntryTile(
      name: user.name,
      isWinner: competition != null && user.rank! <= competition.numWinners,
      userImageUrl: user.picture,
      rank: user.rank!,
      starsCounter: user.points,
      prizeName: competition?.prize,
      prizeImageUrl: competition?.prizePic,
    );
  }

  Widget _buildBanner() {
    ref.addErrorListener(
      provider: getLatestCompetitionProvider(_competitionProvParams),
      context: context,
    );
    final state =
        ref.watch(getLatestCompetitionProvider(_competitionProvParams));
    final loadOrErr = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: LeaderboardBannerLoading(),
    );
    if (loadOrErr != null) return loadOrErr;

    if (state is GetLatestCompetitionNoResultState) {
      return LeaderboardScreenBanner();
    }

    final competition = (state as GetLatestCompetitionLoadedState).competition;

    if (competition.deadline.isBefore(DateTime.now())) {
      return LeaderboardScreenBanner();
    }
    int remainingDays =
        competition.deadline.difference(DateTime.now()).inDays + 1;
    return CompetitionBanner(
      numberOfRemainingdays: remainingDays,
      prizeName: competition.prize,
      prizeUrl: competition.prizePic,
    );
  }
}
