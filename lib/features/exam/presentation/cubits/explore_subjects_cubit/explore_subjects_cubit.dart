import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/exam/domain/repo/get_all_subjects_repo.dart';
import 'package:online_exam/features/exam/presentation/cubits/explore_subjects_cubit/explore_subjects_state.dart';

@injectable
class ExploreSubjectsCubit extends Cubit<ExploreSubjectsState> {
  final GetAllSubjectsRepo getAllSubjectsRepo;
  ExploreSubjectsCubit(this.getAllSubjectsRepo)
      : super(ExploreSubjectsIdleState());

  void getAllSubjects() async {
    emit(ExploreSubjectsLoadingState());
    final response = await getAllSubjectsRepo.getAllSubjects();

    if(!isClosed)
      {
        response.fold(
              (failure) {
            emit(ExploreSubjectsErrorState(failure.errorMessage));
          },
              (subjects) {
            emit(ExploreSubjectsSuccessState(subjects));
          },
        );
      }

  }
}
