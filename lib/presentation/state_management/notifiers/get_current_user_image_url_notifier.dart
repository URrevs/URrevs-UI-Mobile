import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_current_user_image_url_state.dart';

class GetCuttentUserImageUrlNotifier
    extends StateNotifier<GetCuttentUserImageUrlState> {
  GetCuttentUserImageUrlNotifier()
      : super(GetCuttentUserImageUrlInitialState());

  void getCurrentUserImageUrl() async {
    state = GetCuttentUserImageUrlLoadingState();
    final response = await GetIt.I<Repository>().getMyProfile();
    response.fold(
      (failure) => state = GetCuttentUserImageUrlErrorState(failure: failure),
      (getMyProfileResponse) {
        state = GetCuttentUserImageUrlLoadedState(
          imageUrl: getMyProfileResponse.userSubResponse.picture,
        );
      },
    );
  }
}
