import 'package:clean_architecture/features/list_meal/domain/use_cases/get_meal_list_use_case.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class MealListCubitUseCases {
  const MealListCubitUseCases({required this.getMealList});

  final GetMealListUseCase getMealList;
}
