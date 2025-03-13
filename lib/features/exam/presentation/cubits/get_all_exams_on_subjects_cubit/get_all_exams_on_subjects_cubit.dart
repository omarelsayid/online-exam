import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_exams_on_subject_repo.dart';
import 'package:online_exam/features/exam/presentation/cubits/get_all_exams_on_subjects_cubit/get_all_exams_on_subjects_state.dart';

@injectable
class GetAllExamsOnSubjectsCubit extends Cubit<GetAllExamsOnSubjectsState> {
  final GetAllExamsOnSubjectRepo getAllExamsOnSubjectRepo;
  GetAllExamsOnSubjectsCubit(this.getAllExamsOnSubjectRepo)
      : super(GetAllExamsOnSubjectsIdleState());

  void getAllExamsOnSubject({required String subjectId}) async {
    emit(GetAllExamsOnSubjectsLoadingState());
    final response = await getAllExamsOnSubjectRepo.getAllExamsOnSubject(
        subjectId: subjectId);
    response.fold(
      (failure) {
        emit(GetAllExamsOnSubjectsErrorState(failure.errorMessage));
      },
      (exams) {
        emit(GetAllExamsOnSubjectsSuccessState(exams));
      },
    );
  }
}
