import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_qusetions_on_exam_repo.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_qusetions_on_exam_cubit/get_all_qusetions_on_exam_states.dart';

@injectable
class GetAllQusetionsOnExamCubit extends Cubit<GetAllQusetionsOnExamStates> {
  GetAllQusetionsOnExamRepo getAllQusetionsOnExamRepo;
  GetAllQusetionsOnExamCubit(this.getAllQusetionsOnExamRepo)
      : super(GetAllQusetionsOnExamInitialState());

  void getAllQuestionsOnExam({required String examId}) async {
    emit(GetAllQusetionsOnExamLoadingState());
    final response =
        await getAllQusetionsOnExamRepo.getAllQuestionsOnExam(examId: examId);
    response.fold(
      (failure) {
        emit(GetAllQusetionsOnExamErrorState(failure.errorMessage));
      },
      (questions) {
        emit(GetAllQusetionsOnExamSuccessState(questions));
      },
    );
  }
}
