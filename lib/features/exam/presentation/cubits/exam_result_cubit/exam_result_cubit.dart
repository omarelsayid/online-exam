import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:online_exam/features/exam/domain/repo/exam_result_repository.dart';

import '../../../domain/entites/exam_result_entity.dart';

part 'exam_result_state.dart';

@injectable
class ExamResultCubit extends Cubit<ExamResultState> {



  final ExamResultRepository repository;

  ExamResultCubit({required this.repository}) : super( ExamResultInitial());

  Future<void> getAllExamResults() async {
    emit( ExamResultLoading());
    try {
      final examResults = await repository.getAllExamResults();
      emit(ExamResultSuccess(examResults));
    } catch (e) {
      emit(ExamResultError(e.toString()));
    }
  }

  Future<void> addExamResult(ExamResultEntity  examResult) async {
    try {
      await repository.addExamResult(examResult);
      getAllExamResults();
    } catch (e) {
      emit(ExamResultError(e.toString()));
    }
  }

  Future<void> clearExamResults() async {
    try {
      await repository.clearExamResults();
      emit( ExamResultSuccess([]));
    } catch (e) {
      emit(ExamResultError(e.toString()));
    }
  }
}
