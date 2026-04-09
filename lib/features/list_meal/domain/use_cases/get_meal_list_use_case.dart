import 'package:clean_architecture/core/domain/use_cases/use_case.dart';
import 'package:clean_architecture/core/utils/type_defs.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal_list_entity.dart';
import 'package:clean_architecture/features/list_meal/domain/repositories/meal_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetMealListUseCase implements UseCaseNoParameter<MealList> {
  GetMealListUseCase({required MealRepository mealRepository})
    : _mealRepository = mealRepository;

  final MealRepository _mealRepository;

  @override
  FutureData<MealList> call() => _mealRepository.getMealList();
}
