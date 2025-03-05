// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

import '../../features/auth/data/data_source.dart/data_source_imp.dart'
    as _i661;
import '../../features/auth/data/data_source.dart/data_source_repo.dart'
    as _i62;
import '../../features/auth/data/repos/forget_password_repo_imp.dart' as _i599;
import '../../features/auth/data/repos/reset_password_repo_imp.dart' as _i1027;
import '../../features/auth/data/repos/signin_repo_imp.dart' as _i739;
import '../../features/auth/data/repos/signup_repo_imp.dart' as _i71;
import '../../features/auth/data/repos/verify_reset_code_repo_imp.dart'
    as _i898;
import '../../features/auth/domain/repos/forget_password_repo.dart' as _i558;
import '../../features/auth/domain/repos/reset_password_repo.dart' as _i160;
import '../../features/auth/domain/repos/sigin_repo.dart' as _i364;
import '../../features/auth/domain/repos/signup_repo.dart' as _i459;
import '../../features/auth/domain/repos/verify_reset_code_repo.dart' as _i375;
import '../../features/auth/presentation/cubits/forget_password_cubit/forget_password_view_model.dart'
    as _i457;
import '../../features/auth/presentation/cubits/reset_password_cubit/reset_password_view_model.dart'
    as _i261;
import '../../features/auth/presentation/cubits/sigin_cubit/sigin_cubit.dart'
    as _i895;
import '../../features/auth/presentation/cubits/signup_cubit/signup_cubit.dart'
    as _i112;
import '../../features/auth/presentation/cubits/verify_code_cubit/verify_reset_code_view_model.dart'
    as _i16;
import '../../features/exam/data/data_source/exam_data_source.dart' as _i831;
import '../../features/exam/data/data_source/exam_data_source_impl.dart'
    as _i160;
import '../../features/exam/data/repo/get_all_exam_on_subject_repo_impl.dart'
    as _i482;
import '../../features/exam/data/repo/get_all_qusetions_on_exam_repo_imp.dart'
    as _i870;
import '../../features/exam/data/repo/get_all_subjects_repo_impl.dart' as _i679;
import '../../features/exam/data/repo/get_exam_on_id_repo_impl.dart' as _i61;
import '../../features/exam/domain/repo/get_all_exams_on_subject_repo.dart'
    as _i979;
import '../../features/exam/domain/repo/get_all_qusetions_on_exam_repo.dart'
    as _i1072;
import '../../features/exam/domain/repo/get_all_subjects_repo.dart' as _i155;
import '../../features/exam/domain/repo/get_exam_on_id_repo.dart' as _i423;
import '../../features/exam/presentation/cubits/all_qusetions_on_exam_cubit/all_qusetions_on_exam_cubit.dart'
    as _i70;
import '../../features/exam/presentation/cubits/explore_subjects_cubit/explore_subjects_cubit.dart'
    as _i103;
import '../../features/exam/presentation/cubits/get_all_exams_on_subjects_cubit/get_all_exams_on_subjects_cubit.dart'
    as _i309;
import '../../features/exam/presentation/cubits/get_exam_on_id_cubit/get_exam_on_id_cubit.dart'
    as _i304;
import '../../features/user_profile/data/data_source/user_profile_data_source_repo.dart'
    as _i185;
import '../../features/user_profile/data/data_source/user_profile_data_source_repo_imp.dart'
    as _i852;
import '../../features/user_profile/data/repo/chage_password_repo_imp.dart'
    as _i626;
import '../../features/user_profile/data/repo/get_user_profile_repo_imp.dart'
    as _i601;
import '../../features/user_profile/data/repo/logout_repo_imp.dart' as _i552;
import '../../features/user_profile/data/repo/update_profile_repo_imp.dart'
    as _i471;
import '../../features/user_profile/domain/repo/change_password_repo.dart'
    as _i822;
import '../../features/user_profile/domain/repo/get_user_profile_repo.dart'
    as _i972;
import '../../features/user_profile/domain/repo/logout_repo.dart' as _i485;
import '../../features/user_profile/domain/repo/update_profile_repo.dart'
    as _i970;
import '../../features/user_profile/presentation/cubits/change_password_cubit/change_password_cubit.dart'
    as _i82;
import '../../features/user_profile/presentation/cubits/update_profile_cubit/update_profile_cubit.dart'
    as _i90;
import '../../features/user_profile/presentation/cubits/user_profile_cubit/user_profile_cubit.dart'
    as _i1061;
import 'auth_service.dart' as _i184;
import 'exam_service.dart' as _i406;
import 'internet_connection_check.dart' as _i746;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dataModule = _$DataModule();
    gh.singleton<_i184.AuthService>(() => _i184.AuthService());
    gh.singleton<_i406.ExamService>(() => _i406.ExamService());
    gh.singleton<_i973.InternetConnectionChecker>(
        () => dataModule.getInternetConnectionCheck());
    gh.factory<_i185.UserProfileDataSourceRepo>(
        () => _i852.UserPofileDataSourceRepoImp(gh<_i184.AuthService>()));
    gh.factory<_i822.ChangePasswordRepo>(() => _i626.ChangePasswordRepoImp(
          gh<_i185.UserProfileDataSourceRepo>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i62.DataSourceRepo>(
        () => _i661.DataSourceImp(gh<_i184.AuthService>()));
    gh.factory<_i831.ExamDataSource>(
        () => _i160.ExamDataSourceImpl(gh<_i406.ExamService>()));
    gh.factory<_i970.UpdateProfileRepo>(() => _i471.UpdateProfileRepoImp(
          gh<_i185.UserProfileDataSourceRepo>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i972.GetUserProfileRepo>(() =>
        _i601.GetUserProfileRepoImp(gh<_i185.UserProfileDataSourceRepo>()));
    gh.factory<_i979.GetAllExamsOnSubjectRepo>(
        () => _i482.GetAllExamOnSubjectRepoImpl(
              gh<_i831.ExamDataSource>(),
              gh<_i973.InternetConnectionChecker>(),
            ));
    gh.factory<_i1061.UserProfileCubit>(
        () => _i1061.UserProfileCubit(gh<_i972.GetUserProfileRepo>()));
    gh.factory<_i558.ForgetPasswordRepo>(() => _i599.ForgetPasswordRepoImp(
          gh<_i62.DataSourceRepo>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i364.SigninRepo>(
        () => _i739.SigninRepoImp(gh<_i62.DataSourceRepo>()));
    gh.factory<_i423.GetExamOnIdRepo>(() => _i61.GetExamOnIdRepoImpl(
          gh<_i831.ExamDataSource>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i459.SignUpRepo>(
        () => _i71.SignUpRepoImp(gh<_i62.DataSourceRepo>()));
    gh.factory<_i457.ForgetPasswordViewModel>(
        () => _i457.ForgetPasswordViewModel(gh<_i558.ForgetPasswordRepo>()));
    gh.factory<_i160.ResetPasswordRepo>(() => _i1027.ResetPasswordRepoImp(
          gh<_i62.DataSourceRepo>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i485.LogoutRepo>(() =>
        _i552.LogoutRepoImp(dataSource: gh<_i185.UserProfileDataSourceRepo>()));
    gh.factory<_i375.VerifyResetCodeRepo>(() => _i898.VerifyResetCodeRepoImp(
          gh<_i62.DataSourceRepo>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i155.GetAllSubjectsRepo>(() => _i679.GetAllSubjectsRepoImpl(
          gh<_i831.ExamDataSource>(),
          gh<_i973.InternetConnectionChecker>(),
        ));
    gh.factory<_i1072.GetAllQusetionsOnExamRepo>(() =>
        _i870.GetAllQusetionsOnExamRepoImp(
            examDataSource: gh<_i831.ExamDataSource>()));
    gh.factory<_i70.AllQusetionsOnExamCubit>(() =>
        _i70.AllQusetionsOnExamCubit(gh<_i1072.GetAllQusetionsOnExamRepo>()));
    gh.factory<_i82.ChangePasswordCubit>(() => _i82.ChangePasswordCubit(
          gh<_i822.ChangePasswordRepo>(),
          gh<_i485.LogoutRepo>(),
        ));
    gh.factory<_i90.UpdateProfileCubit>(
        () => _i90.UpdateProfileCubit(gh<_i970.UpdateProfileRepo>()));
    gh.factory<_i103.ExploreSubjectsCubit>(
        () => _i103.ExploreSubjectsCubit(gh<_i155.GetAllSubjectsRepo>()));
    gh.factory<_i16.VerifyResetCodeViewModel>(
        () => _i16.VerifyResetCodeViewModel(gh<_i375.VerifyResetCodeRepo>()));
    gh.factory<_i304.GetExamOnIdCubit>(
        () => _i304.GetExamOnIdCubit(gh<_i423.GetExamOnIdRepo>()));
    gh.factory<_i895.SiginCubit>(
        () => _i895.SiginCubit(gh<_i364.SigninRepo>()));
    gh.factory<_i309.GetAllExamsOnSubjectsCubit>(() =>
        _i309.GetAllExamsOnSubjectsCubit(gh<_i979.GetAllExamsOnSubjectRepo>()));
    gh.factory<_i112.SignupCubit>(
        () => _i112.SignupCubit(gh<_i459.SignUpRepo>()));
    gh.factory<_i261.ResetPasswordViewModel>(
        () => _i261.ResetPasswordViewModel(gh<_i160.ResetPasswordRepo>()));
    return this;
  }
}

class _$DataModule extends _i746.DataModule {}
