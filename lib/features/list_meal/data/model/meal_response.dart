import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart';
import 'package:equatable/equatable.dart';

class MealResponse extends Equatable implements DomainConvertible<Meal> {
  const MealResponse({
    required this.idMeal,
    required this.strMeal,
    this.strMealAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    required this.strYoutube,
    required this.data,
    this.strSource,
    this.dateModified,
  });

  factory MealResponse.fromJson(Map<String, dynamic> json) {
    return MealResponse(
      idMeal: json['idMeal'] as String? ?? '',
      strMeal: json['strMeal'] as String? ?? '',
      strMealAlternate: json['strMealAlternate'] as String?,
      strCategory: json['strCategory'] as String? ?? '',
      strArea: json['strArea'] as String? ?? '',
      strInstructions: json['strInstructions'] as String? ?? '',
      strMealThumb: json['strMealThumb'] as String? ?? '',
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String? ?? '',
      data: json,
      strSource: json['strSource'] as String?,
      dateModified: json['dateModified'] as String?,
    );
  }

  final String idMeal;
  final String strMeal;
  final String? strMealAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String? strTags;
  final String strYoutube;
  final Map<String, dynamic> data;
  final String? strSource;
  final String? dateModified;

  @override
  Meal toDomain() {
    final Map<String, String> ingredientsMap = {};
    final Map<String, String> measuresMap = {};
    final List<String> ingredientsList = [];
    final List<String> measuresList = [];

    for (var i = 1; i <= 20; i++) {
      final ingKey = 'strIngredient$i';
      final meaKey = 'strMeasure$i';

      final String ingValue = data[ingKey] as String? ?? '';
      final String meaValue = data[meaKey] as String? ?? '';

      ingredientsMap[ingKey] = ingValue;
      measuresMap[meaKey] = meaValue;

      if (ingValue.trim().isNotEmpty) {
        ingredientsList.add(ingValue);
      }
      if (meaValue.trim().isNotEmpty) {
        measuresList.add(meaValue);
      }
    }

    return Meal(
      idMeal: idMeal,
      strMeal: strMeal,
      strMealAlternate: strMealAlternate,
      strCategory: strCategory,
      strArea: strArea,
      strInstructions: strInstructions,
      strMealThumb: strMealThumb,
      strTags: strTags,
      strYoutube: strYoutube,
      allIngredients: ingredientsMap,
      allMeasures: measuresMap,
      ingredientsList: ingredientsList,
      measuresList: measuresList,
      strSource: strSource,
      dateModified: dateModified,
    );
  }

  @override
  List<Object?> get props => [idMeal, data];
}
