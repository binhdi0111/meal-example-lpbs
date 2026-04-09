import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart';
import 'package:clean_architecture/features/meal_detail/presentation/cubit/meal_detail_cubit_use_cases.dart';
import 'package:clean_architecture/shared_ui/cubits/base/base_cubit.dart';
import 'package:injectable/injectable.dart';

part 'meal_detail_state.dart';

@injectable
class MealDetailCubit extends BaseCubit<MealDetailState> {
  MealDetailCubit({required MealDetailCubitUseCases useCases})
    : _useCases = useCases,
      super(MealDetailState.initial());

  final MealDetailCubitUseCases _useCases;

  void initialize({required Meal meal}) {
    // Keep use cases injected and ready for future detail business logic.
    final _ = _useCases;
    emit(state.copyWith(meal: meal, status: StateStatus.loaded));
  }
}
