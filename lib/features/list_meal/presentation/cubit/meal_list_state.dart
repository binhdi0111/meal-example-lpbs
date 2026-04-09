part of 'meal_list_cubit.dart';

class MealListState extends BaseState {
  const MealListState({
    this.featuredMeal,
    required this.gridMeals,
    this.message,
    super.status = StateStatus.initial,
  });

  factory MealListState.initial() => const MealListState(gridMeals: []);
  final Meal? featuredMeal;
  final List<Meal> gridMeals;
  final String? message;

  MealListState copyWith({
    Meal? featuredMeal,
    bool clearFeaturedMeal = false,
    List<Meal>? gridMeals,
    String? message,
    StateStatus? status,
  }) => MealListState(
    featuredMeal:
        clearFeaturedMeal ? null : (featuredMeal ?? this.featuredMeal),
    gridMeals: gridMeals ?? this.gridMeals,
    message: message,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [...super.props, featuredMeal, gridMeals, message];
}
