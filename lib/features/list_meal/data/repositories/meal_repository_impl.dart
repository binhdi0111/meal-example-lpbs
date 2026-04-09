import 'package:clean_architecture/core/clients/remote/internet_client.dart';
import 'package:clean_architecture/core/data/handlers/repository_handler.dart';
import 'package:clean_architecture/core/utils/type_defs.dart';
import 'package:clean_architecture/features/list_meal/data/data_source/meal_remote_data_source.dart';
import 'package:clean_architecture/features/list_meal/data/model/meal_list_response.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal_list_entity.dart';
import 'package:clean_architecture/features/list_meal/domain/repositories/meal_repository.dart';
import 'package:injectable/injectable.dart';

/// A class that stores user data
@LazySingleton(as: MealRepository)
final class MealRepositoryImpl implements MealRepository {
  MealRepositoryImpl({
    required MealRemoteDataSource mealRemoteDataSource,
    required InternetClient internet,
  }) : _mealRemoteDataSource = mealRemoteDataSource,
       _internet = internet;

  final MealRemoteDataSource _mealRemoteDataSource;
  final InternetClient _internet;

  @override
  FutureData<MealList> getMealList() async {
    final responseState = await RepositoryHandler.fetchWithFallback<MealListResponse?>(
      isInternetConnected: _internet.isConnected,
      remoteCallback: _mealRemoteDataSource.getMealList,
    );

    return responseState.mapData(
      (response) => (response ?? const MealListResponse(meals: [])).toDomain(),
    );
  }
}
