import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/auth/domain/repos/sigin_repo.dart';
import 'package:online_exam/features/auth/presentation/cubits/sigin_cubit/sigin_states.dart';

@injectable
class SiginCubit extends Cubit<SiginStates> {
  final SigninRepo signinRepo;

  SiginCubit(this.signinRepo) : super(SiginInitial());

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(SiginLoading());
    final result =
        await signinRepo.signInUser(email: email, password: password);
    result.fold(
      (failure) {
        emit(SiginFailure(failure.errorMessage));
      },
      (userEntity) => emit(SiginSuccess()),
    );
  }
}
