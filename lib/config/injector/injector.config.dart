// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_architecture/config/app_config.dart' as _i37;
import 'package:clean_architecture/core/clients/local/local_storage_client.dart'
    as _i1009;
import 'package:clean_architecture/core/clients/remote/http/http_client.dart'
    as _i244;
import 'package:clean_architecture/core/clients/remote/internet_client.dart'
    as _i9;
import 'package:clean_architecture/features/list_meal/data/data_source/meal_remote_data_source.dart'
    as _i802;
import 'package:clean_architecture/features/list_meal/data/repositories/meal_repository_impl.dart'
    as _i724;
import 'package:clean_architecture/features/list_meal/domain/repositories/meal_repository.dart'
    as _i516;
import 'package:clean_architecture/features/list_meal/domain/use_cases/get_meal_list_use_case.dart'
    as _i102;
import 'package:clean_architecture/features/list_meal/presentation/cubit/meal_list_cubit.dart'
    as _i210;
import 'package:clean_architecture/features/list_meal/presentation/cubit/meal_list_cubit_use_cases.dart'
    as _i558;
import 'package:clean_architecture/features/meal_detail/presentation/cubit/meal_detail_cubit.dart'
    as _i603;
import 'package:clean_architecture/features/meal_detail/presentation/cubit/meal_detail_cubit_use_cases.dart'
    as _i205;
import 'package:clean_architecture/routing/helper/navigation_client.dart'
    as _i389;
import 'package:clean_architecture/routing/routes.dart' as _i671;
import 'package:clean_architecture/shared_ui/cubits/screen_observer/screen_observer_cubit.dart'
    as _i640;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

const String _staging = 'staging';
const String _development = 'development';
const String _production = 'production';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> initialize({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localStorageClientModule = _$LocalStorageClientModule();
    final httpClientModule = _$HttpClientModule();
    final internetClientModule = _$InternetClientModule();
    final navigationClientModule = _$NavigationClientModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => localStorageClientModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<bool>(() => httpClientModule.addInterceptors);
    gh.factory<_i640.ScreenObserverCubit>(() => _i640.ScreenObserverCubit());
    gh.lazySingleton<_i361.Dio>(() => httpClientModule.dio);
    gh.lazySingleton<_i244.HttpAuthInterceptor>(
      () => _i244.HttpAuthInterceptor(),
    );
    gh.lazySingleton<_i161.InternetConnection>(
      () => internetClientModule.internetConnection,
    );
    gh.lazySingleton<_i205.MealDetailCubitUseCases>(
      () => const _i205.MealDetailCubitUseCases(),
    );
    gh.lazySingleton<_i671.AppRouter>(() => navigationClientModule.appRouter);
    gh.lazySingleton<_i389.NavigationClient>(
      () => _i389.NavigationClientImpl(appRouter: gh<_i671.AppRouter>()),
    );
    gh.factory<_i603.MealDetailCubit>(
      () =>
          _i603.MealDetailCubit(useCases: gh<_i205.MealDetailCubitUseCases>()),
    );
    gh.lazySingleton<_i37.AppConfig>(
      () => _i37.AppConfigStg(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i37.AppConfig>(
      () => _i37.AppConfigDev(),
      registerFor: {_development},
    );
    gh.lazySingleton<_i1009.LocalStorageClient>(
      () => _i1009.LocalStorageClientImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.lazySingleton<_i37.AppConfig>(
      () => _i37.AppConfigProd(),
      registerFor: {_production},
    );
    gh.lazySingleton<_i9.InternetClient>(
      () => _i9.InternetClientImpl(
        internetConnection: gh<_i161.InternetConnection>(),
      ),
    );
    gh.lazySingleton<_i244.HttpClient>(
      () => _i244.HttpClientImpl(
        dio: gh<_i361.Dio>(),
        appConfig: gh<_i37.AppConfig>(),
        authInterceptor: gh<_i244.HttpAuthInterceptor>(),
        navigationClient: gh<_i389.NavigationClient>(),
        addInterceptors: gh<bool>(),
      ),
    );
    gh.lazySingleton<_i802.MealRemoteDataSource>(
      () => _i802.MealRemoteDataSourceImpl(dioClient: gh<_i244.HttpClient>()),
    );
    gh.lazySingleton<_i516.MealRepository>(
      () => _i724.MealRepositoryImpl(
        mealRemoteDataSource: gh<_i802.MealRemoteDataSource>(),
        internet: gh<_i9.InternetClient>(),
      ),
    );
    gh.lazySingleton<_i102.GetMealListUseCase>(
      () =>
          _i102.GetMealListUseCase(mealRepository: gh<_i516.MealRepository>()),
    );
    gh.lazySingleton<_i558.MealListCubitUseCases>(
      () => _i558.MealListCubitUseCases(
        getMealList: gh<_i102.GetMealListUseCase>(),
      ),
    );
    gh.factory<_i210.MealListCubit>(
      () => _i210.MealListCubit(useCases: gh<_i558.MealListCubitUseCases>()),
    );
    return this;
  }
}

class _$LocalStorageClientModule extends _i1009.LocalStorageClientModule {}

class _$HttpClientModule extends _i244.HttpClientModule {}

class _$InternetClientModule extends _i9.InternetClientModule {}

class _$NavigationClientModule extends _i389.NavigationClientModule {}
