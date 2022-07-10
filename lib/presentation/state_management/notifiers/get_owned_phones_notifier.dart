import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_owned_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/verify_state.dart';

class GetOwnedPhonesNotifier extends StateNotifier<GetOwnedPhonesState> {
  GetOwnedPhonesNotifier({
    required this.userId,
    required this.ref,
  }) : super(GetOwnedPhonesInitialState());

  final AutoDisposeStateNotifierProviderRef ref;

  int _round = 1;
  String? userId;

  void getOwnedProducts() async {
    List<Phone> currentPhones = [];
    final currentState = state;
    if (currentState is GetOwnedPhonesLoadedState) {
      currentPhones = currentState.infiniteScrollingItems;
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
          infiniteScrollingItems: newPhones,
          roundsEnded: roundsEnded,
        );
        _round++;
        _addVerifyListenersToPhones(phones);
      },
    );
  }

  void _addVerifyListenersToPhones(List<Phone> fetchedPhones) {
    print('adding listeners');
    final authState =
        ref.watch(authenticationProvider) as AuthenticationLoadedState;
    String userId = authState.user.id;
    for (Phone phone in fetchedPhones) {
      final params = VerifyProviderParams(phoneId: phone.id, userId: userId);
      ref.listen(verifyProvider(params), (previous, next) {
        print('${phone.name} is verified');
        final currentState = state;
        if (currentState is GetOwnedPhonesLoadedState &&
            next is VerifyLoadedState) {
          List<Phone> phones = [...currentState.infiniteScrollingItems];
          int index = phones.indexWhere((p) => p.id == phone.id);
          Phone changedPhone = phones[index];
          changedPhone =
              changedPhone.copyWith(verificationRatio: next.verificationRatio);
          phones.removeAt(index);
          phones.insert(index, changedPhone);
          for (var phone in phones) {
            print('${phone.name} - ${phone.verificationRatio}');
          }
          state = GetOwnedPhonesLoadedState(
            infiniteScrollingItems: phones,
            roundsEnded: currentState.roundsEnded,
          );
        }
      });
    }
  }
}
