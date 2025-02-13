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

import '../../features/auth/data/data_source.dart/data_source_imp.dart'
    as _i661;
import '../../features/auth/data/data_source.dart/data_source_repo.dart'
    as _i62;
import '../../features/auth/data/repos/signin_repo_imp.dart' as _i739;
import '../../features/auth/data/repos/signup_repo_imp.dart' as _i71;
import '../../features/auth/domain/repos/sigin_repo.dart' as _i364;
import '../../features/auth/domain/repos/signup_repo.dart' as _i459;
import '../../features/auth/presentation/cubits/sigin_cubit/sigin_cubit.dart'
    as _i895;
import 'auth_service.dart' as _i184;

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
    gh.singleton<_i184.AuthService>(() => _i184.AuthService());
    gh.factory<_i62.DataSourceRepo>(
        () => _i661.DataSourceImp(gh<_i184.AuthService>()));
    gh.factory<_i364.SigninRepo>(
        () => _i739.SigninRepoImp(gh<_i62.DataSourceRepo>()));
    gh.factory<_i459.SignUpRepo>(
        () => _i71.SignUpRepoImp(gh<_i62.DataSourceRepo>()));
    gh.factory<_i895.SiginCubit>(
        () => _i895.SiginCubit(gh<_i364.SigninRepo>()));
    return this;
  }
}
