import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam/features/auth/domain/repos/signup_repo.dart';
import 'package:online_exam/features/auth/presentation/cubits/signup_cubit/signup_states.dart';

@injectable
class SignupCubit extends Cubit<SignupStates> {
  final SignUpRepo signupRepo;

  SignupCubit(this.signupRepo) : super(SignupInitial());

  Future<void> signUpUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
  }) async {
    emit(SignupLoading());
    final result = await signupRepo.signUpUser(
      userName: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      phone: phone,
    );
    result.fold(
          (failure) => emit(SignupFailure(failure.errorMessage)),
          (userEntity) => emit(SignupSuccess(userEntity)),
    );
  }
}
