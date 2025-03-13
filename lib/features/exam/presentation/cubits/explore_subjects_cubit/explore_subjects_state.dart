import 'package:online_exam/features/exam/data/models/Subjects.dart';

abstract class ExploreSubjectsState {}

class ExploreSubjectsIdleState extends ExploreSubjectsState {}

class ExploreSubjectsLoadingState extends ExploreSubjectsState {}

class ExploreSubjectsSuccessState extends ExploreSubjectsState {
  List<Subjects> subjects;
  ExploreSubjectsSuccessState(this.subjects);
}

class ExploreSubjectsErrorState extends ExploreSubjectsState {
  final String errorMessage;
  ExploreSubjectsErrorState(this.errorMessage);
}
