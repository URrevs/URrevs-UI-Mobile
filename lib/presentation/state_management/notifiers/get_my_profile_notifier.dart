import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_user_profile_state.dart';

class GetMyProfileNotifier extends StateNotifier<GetMyProfileState> {
  GetMyProfileNotifier() : super(GetMyProfileInitialState());

  void getMyProfile() async {
    state = GetMyProfileLoadingState();
    final response = await GetIt.I<Repository>().getMyProfile();
    response.fold(
      (failure) => state = GetMyProfileErrorState(failure: failure),
      (GetMyProfileResponse getMyProfileResponse) {
        final User user = getMyProfileResponse.userSubResponse.userModel;
        final String refCode = getMyProfileResponse.userSubResponse.refCode;
        state = GetMyProfileLoadedState(user: user, refCode: refCode);
      },
    );
  }
}
