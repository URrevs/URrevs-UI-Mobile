import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/data/requests/questions_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/add_question_state.dart';

class AddQuestionNotifier extends StateNotifier<AddQuestionState> {
  AddQuestionNotifier() : super(AddQuestionInitialState());

  void addPhoneQuestion(AddPhoneQuestionRequest request) async {
    state = AddQuestionLoadingState();
    Either<Failure, Question> response;
    response = await GetIt.I<Repository>().addPhoneQuestion(request);
    response.fold(
      (failure) => state = AddQuestionErrorState(failure: failure),
      (question) {
        state = AddQuestionLoadedState(question: question);
      },
    );
  }

  void addCompanyQuestion(AddCompanyQuestionRequest request) async {
    state = AddQuestionLoadingState();
    Either<Failure, Question> response;
    response = await GetIt.I<Repository>().addCompanyQuestion(request);
    response.fold(
      (failure) => state = AddQuestionErrorState(failure: failure),
      (question) {
        state = AddQuestionLoadedState(question: question);
      },
    );
  }
}
