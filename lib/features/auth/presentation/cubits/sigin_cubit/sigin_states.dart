sealed class SiginStates {}

class SiginInitial extends SiginStates {}

class SiginLoading extends SiginStates {}

class SiginSuccess extends SiginStates {}

class SiginFailure extends SiginStates {
  final String message;

  SiginFailure(this.message);
}
