import 'package:clean_architecture/core/utils/type_defs.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal_list_entity.dart';

abstract interface class MealRepository {
  FutureData<MealList> getMealList();
}
