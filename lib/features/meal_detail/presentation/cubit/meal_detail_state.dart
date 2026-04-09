part of 'meal_detail_cubit.dart';

class MealDetailState extends BaseState {
  const MealDetailState({this.meal, super.status = StateStatus.initial});

  factory MealDetailState.initial() => const MealDetailState();

  final Meal? meal;

  MealDetailState copyWith({Meal? meal, StateStatus? status}) =>
      MealDetailState(meal: meal ?? this.meal, status: status ?? this.status);

  @override
  List<Object?> get props => [...super.props, meal];
}
