import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:clean_architecture/features/list_meal/data/model/meal_response.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal_list_entity.dart';
import 'package:equatable/equatable.dart';

class MealListResponse extends Equatable
    implements DomainConvertible<MealList> {
  const MealListResponse({required this.meals});

  factory MealListResponse.fromJson(Map<String, dynamic> json) {
    return MealListResponse(
      meals:
          (json['meals'] as List<dynamic>?)
              ?.map((e) => MealResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
  final List<MealResponse> meals;

  @override
  List<Object?> get props => [meals];

  @override
  MealList toDomain() {
    return MealList(meals: meals.map((e) => e.toDomain()).toList());
  }
}
