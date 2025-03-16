// exam_result_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/domain/entites/exam_result_entity.dart';
import 'package:online_exam/features/exam/domain/repo/exam_result_repository.dart';

part 'exam_result_state.dart';

@injectable
class ExamResultCubit extends Cubit<ExamResultState> {
  final ExamResultRepository repository;

  ExamResultCubit({required this.repository}) : super(ExamResultInitial());

  Future<void> getAllExamResults() async {
    emit(ExamResultLoading());
    try {
      final examResults = await repository.getAllExamResults();

      print("============================DAta From sql");
      print(examResults);
      emit(ExamResultSuccess(examResults));
    } catch (e) {
      print(e.toString());
      emit(ExamResultError(e.toString()));
    }
  }

  Future<void> addExamResult(ExamResultEntity examResult) async {
    try {
      await repository.addExamResult(examResult);
     // getAllExamResults();
    } catch (e) {
      print("==================================");
      print(e.toString());
      emit(ExamResultError(e.toString()));
    }
  }

  Future<void> clearExamResults() async {
    try {
      await repository.clearExamResults();
      emit(ExamResultSuccess([]));
    } catch (e) {
      emit(ExamResultError(e.toString()));
    }
  }
}
