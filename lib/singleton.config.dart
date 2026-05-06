// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:b_selfcare/src/data/repositories/employee_repo.dart' as _i419;
import 'package:b_selfcare/src/data/repositories/group_repo.dart' as _i206;
import 'package:b_selfcare/src/data/repositories/reset_password_repo.dart'
    as _i991;
import 'package:b_selfcare/src/data/services/http_helper.dart' as _i330;
import 'package:b_selfcare/src/data/services/local_helper.dart' as _i749;
import 'package:b_selfcare/src/domain/usecases/employee_usecase.dart' as _i908;
import 'package:b_selfcare/src/domain/usecases/group_usecase.dart' as _i784;
import 'package:b_selfcare/src/domain/usecases/reset_password_usecase.dart'
    as _i322;
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart'
    as _i100;
import 'package:b_selfcare/src/views/pages/login/cubit/login_cubit.dart'
    as _i48;
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart'
    as _i37;
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart'
    as _i595;
import 'package:b_selfcare/src/views/pages/reset_password/cubit/reset_password_cubit.dart'
    as _i865;
import 'package:b_selfcare/src/views/widgets/filter_tab/cubit/filter_tab_cubit.dart'
    as _i222;
import 'package:b_selfcare/src/views/widgets/select_option/cubit/select_option_cubit.dart'
    as _i114;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i749.LocaHelper>(() => _i749.LocaHelper());
    gh.lazySingleton<_i100.LayoutCubit>(() => _i100.LayoutCubit());
    gh.lazySingleton<_i222.FilterTabCubit>(() => _i222.FilterTabCubit());
    gh.lazySingleton<_i114.SelectCubit>(() => _i114.SelectCubit());
    gh.factory<_i330.HttpHelper>(
      () => _i330.HttpHelper(gh<_i749.LocaHelper>()),
    );
    gh.lazySingleton<_i48.LoginCubit>(
      () => _i48.LoginCubit(gh<_i330.HttpHelper>(), gh<_i749.LocaHelper>()),
    );
    gh.singleton<_i419.EmployeeRepo>(
      () => _i419.EmployeeRepo(gh<_i749.LocaHelper>(), gh<_i330.HttpHelper>()),
    );
    gh.singleton<_i206.GroupRepo>(
      () => _i206.GroupRepo(gh<_i749.LocaHelper>(), gh<_i330.HttpHelper>()),
    );
    gh.singleton<_i991.ResetPasswordRepo>(
      () => _i991.ResetPasswordRepo(
        gh<_i749.LocaHelper>(),
        gh<_i330.HttpHelper>(),
      ),
    );
    gh.lazySingleton<_i322.ResetPasswordUsecase>(
      () => _i322.ResetPasswordUsecase(
        resetPasswordRepo: gh<_i991.ResetPasswordRepo>(),
      ),
    );
    gh.lazySingleton<_i784.GroupUsecase>(
      () => _i784.GroupUsecase(groupRepo: gh<_i206.GroupRepo>()),
    );
    gh.lazySingleton<_i37.GroupCubit>(
      () => _i37.GroupCubit(gh<_i784.GroupUsecase>()),
    );
    gh.lazySingleton<_i865.ResetPasswordCubit>(
      () => _i865.ResetPasswordCubit(gh<_i322.ResetPasswordUsecase>()),
    );
    gh.lazySingleton<_i908.EmployeeUsecase>(
      () => _i908.EmployeeUsecase(employeeRepo: gh<_i419.EmployeeRepo>()),
    );
    gh.lazySingleton<_i595.MyFlotteCubit>(
      () => _i595.MyFlotteCubit(gh<_i908.EmployeeUsecase>()),
    );
    return this;
  }
}
