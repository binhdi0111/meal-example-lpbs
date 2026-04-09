import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart';
import 'package:clean_architecture/features/list_meal/presentation/cubit/meal_list_cubit_use_cases.dart';
import 'package:clean_architecture/shared_ui/cubits/base/base_cubit.dart';
import 'package:injectable/injectable.dart';

part 'meal_list_state.dart';

@injectable
class MealListCubit extends BaseCubit<MealListState> {
  MealListCubit({required MealListCubitUseCases useCases})
    : _useCases = useCases,
      super(MealListState.initial());

  final MealListCubitUseCases _useCases;

  Future<void> initialize() async {
    await getMealList();
  }

  Future<void> getMealList() async {
    emit(state.copyWith(status: StateStatus.loading));

    final result = await _useCases.getMealList.call();
    if (result is SuccessState) {
      final meals = result.data?.meals ?? const <Meal>[];
      final featuredMeal = meals.isNotEmpty ? meals.first : null;
      final gridMeals = meals.length > 1 ? meals.sublist(1) : const <Meal>[];

      emit(
        state.copyWith(
          featuredMeal: featuredMeal,
          clearFeaturedMeal: featuredMeal == null,
          gridMeals: gridMeals,
          status: StateStatus.loaded,
        ),
      );
      return;
    }

    if (result is FailureState) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          message: result.message ?? result.error,
        ),
      );
    }
  }
}
