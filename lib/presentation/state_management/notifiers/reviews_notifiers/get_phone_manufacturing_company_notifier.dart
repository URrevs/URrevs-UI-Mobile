import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_phone_manufacturing_company_state.dart';

class GetPhoneManufacturingCompanyNotifier
    extends StateNotifier<GetPhoneManufacturingCompanyState> {
  GetPhoneManufacturingCompanyNotifier()
      : super(GetPhoneManufacturingCompanyInitialState());

  void getPhoneManufacturingCompany(String phoneId) async {
    state = GetPhoneManufacturingCompanyLoadingState();
    final response =
        await GetIt.I<Repository>().getPhoneManufacturingCompany(phoneId);
    response.fold(
      (failure) =>
          state = GetPhoneManufacturingCompanyErrorState(failure: failure),
      (company) {
        state = GetPhoneManufacturingCompanyLoadedState(company: company);
      },
    );
  }

  void returnToInitialState() {
    state = GetPhoneManufacturingCompanyInitialState();
  }
}
