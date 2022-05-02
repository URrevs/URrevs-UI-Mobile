import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_owned_phones_state.dart';

class GetMyOwnedPhonesNotifier extends StateNotifier<GetMyOwnedPhonesState> {
  GetMyOwnedPhonesNotifier() : super(GetMyOwnedPhonesInitialState());

  int _round = 1;

  void _getOwnedProducts({String? userId}) async {
    List<Phone> currentPhones = [];
    final currentState = state;
    if (currentState is GetMyOwnedPhonesLoadedState) {
      currentPhones = currentState.phones;
    }
    state = GetMyOwnedPhonesLoadingState();
    late Either<Failure, List<Phone>> response;
    if (userId == null) {
      response = await GetIt.I<Repository>().getMyOwnedPhones(_round);
    } else {
      response = await GetIt.I<Repository>()
          .getTheOwnedPhonesOfAnotherUser(userId, _round);
    }
    response.fold(
      (failure) => state = GetMyOwnedPhonesErrorState(failure: failure),
      (phones) {
        bool roundsEnded = phones.isEmpty;
        List<Phone> newPhones = [...currentPhones, ...phones];
        state = GetMyOwnedPhonesLoadedState(
          phones: newPhones,
          roundsEnded: roundsEnded,
        );
      },
    );
    _round++;
  }

  void getMyOwnedPhones() => _getOwnedProducts();

  void getTheOwnedPhonesOfAnotherUser(String userId) =>
      _getOwnedProducts(userId: userId);
}
