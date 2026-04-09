import 'package:clean_architecture/core/clients/remote/http/http_client.dart';
import 'package:clean_architecture/core/constants/api_endpoints.dart';
import 'package:clean_architecture/core/data/handlers/api_handler.dart';
import 'package:clean_architecture/core/utils/type_defs.dart';
import 'package:clean_architecture/features/list_meal/data/model/meal_list_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract interface class MealRemoteDataSource {
  FutureData<MealListResponse?> getMealList();
}

@LazySingleton(as: MealRemoteDataSource)
final class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  const MealRemoteDataSourceImpl({required HttpClient dioClient})
      : _dioClient = dioClient;
  final HttpClient _dioClient;

  @override
  FutureData<MealListResponse?> getMealList() {
    return ApiHandler.call(
      () => _dioClient.get(
        ApiEndpoints.meal,
        options: Options(
          validateStatus: (status) => status == 200 || status == 400,
        ),
      ),
      fromJson: MealListResponse.fromJson,
      isStandardResponse: false,
    );
  }
}
