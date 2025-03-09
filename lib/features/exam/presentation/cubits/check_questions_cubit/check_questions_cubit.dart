import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/domain/repo/check_questions_repo.dart';
import 'package:online_exam/features/exam/presentation/cubits/check_questions_cubit/check_questions_state.dart';

@injectable
class CheckQuestionsCubit extends Cubit<CheckQuestionsState> {
  final CheckQuestionsRepo checkQuestionsRepo;
  CheckQuestionsCubit(this.checkQuestionsRepo)
      : super(CheckQuestionsIdleState());

  void checkQuestions({required List<Map<String, dynamic>> answers}) async {
    emit(CheckQuestionsLoadingState());
    final response = await checkQuestionsRepo.checkQuestions(answers: answers);
    response.fold(
      (failure) {
        emit(CheckQuestionsErrorState(failure.errorMessage));
      },
      (checkQuestionsResponse) {
        emit(CheckQuestionsSuccessState(checkQuestionsResponse));
      },
    );
  }
}
