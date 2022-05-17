import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_owned_phones_state.dart';

class GetOwnedPhonesNotifier extends StateNotifier<GetOwnedPhonesState> {
  GetOwnedPhonesNotifier({required this.userId})
      : super(GetOwnedPhonesInitialState());

  int _round = 1;
  String? userId;

  void getOwnedProducts() async {
    List<Phone> currentPhones = [];
    final currentState = state;
    if (currentState is GetOwnedPhonesLoadedState) {
      currentPhones = currentState.phones;
    }
    state = GetOwnedPhonesLoadingState();
    late Either<Failure, List<Phone>> response;
    if (userId == null) {
      response = await GetIt.I<Repository>().getMyOwnedPhones(_round);
    } else {
      response = await GetIt.I<Repository>()
          .getTheOwnedPhonesOfAnotherUser(userId!, _round);
    }
    response.fold(
      (failure) => state = GetOwnedPhonesErrorState(failure: failure),
      (phones) {
        bool roundsEnded = phones.isEmpty;
        List<Phone> newPhones = [...currentPhones, ...phones];
        state = GetOwnedPhonesLoadedState(
          phones: newPhones,
          roundsEnded: roundsEnded,
        );
      },
    );
    _round++;
  }
}
