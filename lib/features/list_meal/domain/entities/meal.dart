import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  const Meal({
    required this.idMeal,
    required this.strMeal,
    this.strMealAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    required this.strYoutube,
    required this.allIngredients,
    required this.allMeasures,
    required this.ingredientsList,
    required this.measuresList,
    this.strSource,
    this.dateModified,
  });

  final String idMeal;
  final String strMeal;
  final String? strMealAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String? strTags;
  final String strYoutube;

  final Map<String, String> allIngredients;
  final Map<String, String> allMeasures;

  final List<String> ingredientsList;
  final List<String> measuresList;

  final String? strSource;
  final String? dateModified;

  @override
  List<Object?> get props => [idMeal, strMeal];
}