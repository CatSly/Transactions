// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:transactions_app/app/routing/router.dart' as _i3;
import 'package:transactions_app/data/mapper/auth_mapper.dart' as _i4;
import 'package:transactions_app/data/repos/auth_repo_impl.dart' as _i6;
import 'package:transactions_app/domain/repo/auth_repo.dart' as _i5;
import 'package:transactions_app/presentation/auth/login/bloc/login_cubit.dart'
    as _i8;
import 'package:transactions_app/presentation/auth/new_password/bloc/new_password_cubit.dart'
    as _i7;
import 'package:transactions_app/presentation/auth/register/bloc/register_cubit.dart'
    as _i9;
import 'package:transactions_app/presentation/splash_screen/bloc/splash_cubit.dart'
    as _i10;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.AppRouter>(_i3.AppRouter());
  gh.lazySingleton<_i4.AuthMapper>(() => _i4.AuthMapper());
  gh.lazySingleton<_i5.AuthRepo>(() => _i6.AuthRepoImpl(gh<_i4.AuthMapper>()));
  gh.factory<_i7.LoginCubit>(() => _i7.LoginCubit(gh<_i5.AuthRepo>()));
  gh.factory<_i8.LoginCubit>(() => _i8.LoginCubit(gh<_i5.AuthRepo>()));
  gh.factory<_i9.RegisterCubit>(() => _i9.RegisterCubit(gh<_i5.AuthRepo>()));
  gh.factory<_i10.SplashCubit>(() => _i10.SplashCubit());
  return getIt;
}
