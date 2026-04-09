import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart';
import 'package:equatable/equatable.dart';

class MealList extends Equatable {
  const MealList({
    required this.meals,
  });

  final List<Meal> meals;

  @override
  List<Object?> get props => [meals];
}