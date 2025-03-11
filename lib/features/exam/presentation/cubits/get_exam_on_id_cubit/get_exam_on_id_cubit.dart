import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/domain/repo/get_exam_on_id_repo.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_exam_on_id_cubit/get_exam_on_id_state.dart';

@injectable
class GetExamOnIdCubit extends Cubit<GetExamOnIdState> {
  final GetExamOnIdRepo getExamOnIdRepo;
  GetExamOnIdCubit(this.getExamOnIdRepo) : super(GetExamOnIdIdleState());

  getExamOnId({required String examId}) async {
    emit(GetExamOnIdLoadingState());
    final response = await getExamOnIdRepo.getExamOnId(examId: examId);
    response.fold(
      (failure) {
        emit(GetExamOnIdErrorState(failure.errorMessage));
      },
      (exam) {
        emit(GetExamOnIdSuccessState(exam));
      },
    );
  }
}
