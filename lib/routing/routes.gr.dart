// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart'
    as _i4;
import 'package:clean_architecture/features/list_meal/presentation/pages/meal_list_page.dart'
    as _i2;
import 'package:clean_architecture/features/meal_detail/presentation/pages/meal_detail_page.dart'
    as _i1;
import 'package:flutter/material.dart' as _i5;

/// generated route for
/// [_i1.MealDetailPage]
class MealDetailRoute extends _i3.PageRouteInfo<MealDetailRouteArgs> {
  MealDetailRoute({
    required _i4.Meal meal,
    _i5.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         MealDetailRoute.name,
         args: MealDetailRouteArgs(meal: meal, key: key),
         initialChildren: children,
       );

  static const String name = 'MealDetailRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealDetailRouteArgs>();
      return _i1.MealDetailPage(meal: args.meal, key: args.key);
    },
  );
}

class MealDetailRouteArgs {
  const MealDetailRouteArgs({required this.meal, this.key});

  final _i4.Meal meal;

  final _i5.Key? key;

  @override
  String toString() {
    return 'MealDetailRouteArgs{meal: $meal, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MealDetailRouteArgs) return false;
    return meal == other.meal && key == other.key;
  }

  @override
  int get hashCode => meal.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i2.MealListPage]
class MealListRoute extends _i3.PageRouteInfo<void> {
  const MealListRoute({List<_i3.PageRouteInfo>? children})
    : super(MealListRoute.name, initialChildren: children);

  static const String name = 'MealListRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.MealListPage();
    },
  );
}
