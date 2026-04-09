import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart';
import 'package:clean_architecture/features/list_meal/presentation/cubit/meal_list_cubit.dart';
import 'package:clean_architecture/features/list_meal/presentation/pages/widgets/featured_meal_card.dart';
import 'package:clean_architecture/features/list_meal/presentation/pages/widgets/meal_grid_item.dart';
import 'package:clean_architecture/features/list_meal/presentation/pages/widgets/meal_list_loading_shimmer.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/shared_ui/cubits/base/base_cubit.dart';
import 'package:clean_architecture/shared_ui/ui/base/app_bar/base_app_bar.dart';
import 'package:clean_architecture/shared_ui/ui/base/base_scaffold.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class MealListPage extends StatelessWidget {
  const MealListPage({super.key});

  static Future<void> _precacheMealAssets(
    BuildContext context,
    Meal meal,
  ) async {
    final imageUrl = meal.strMealThumb;
    if (imageUrl.isEmpty) {
      return;
    }

    final provider = CachedNetworkImageProvider(imageUrl);
    try {
      await precacheImage(provider, context);
    } catch (e) {
      debugPrint('Failed to precache meal image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => GetIt.I<MealListCubit>()..initialize(),
      child: BaseScaffold(
        onRefresh: () async {
          await context.read<MealListCubit>().getMealList();
        },
        appBar: const BaseAppBar(
          showLeading: false,
          title: 'Meal list Page',
          titleFontWeight: FontWeight.w600,
        ),
        isScrollable: false,
        body: BlocBuilder<MealListCubit, MealListState>(
          builder: (context, state) {
            if (state.status == StateStatus.loading) {
              return const MealListLoadingShimmer();
            }

            if (state.status == StateStatus.error ||
                state.status == StateStatus.noInternet) {
              final message =
                  state.message ??
                  (state.status == StateStatus.noInternet
                      ? kNoInternet
                      : kErrorMessage);
              return Center(
                child: Padding(
                  padding: UIHelpers.paddingA16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 40),
                      UIHelpers.spaceV12,
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      UIHelpers.spaceV16,
                      FilledButton(
                        onPressed: () =>
                            context.read<MealListCubit>().getMealList(),
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final hasFeaturedMeal = state.featuredMeal != null;
            final hasGridMeals = state.gridMeals.isNotEmpty;
            if (!hasFeaturedMeal && !hasGridMeals) {
              return const Center(child: Text('No meals found'));
            }

            return CustomScrollView(
              slivers: [
                if (state.featuredMeal case final meal?)
                  SliverToBoxAdapter(
                    child: FeaturedMealCard(
                      meal: meal,
                      onTap: () async {
                        await _precacheMealAssets(context, meal);
                        if (!context.mounted) {
                          return;
                        }
                        await context.router.push(MealDetailRoute(meal: meal));
                      },
                    ),
                  ),
                SliverToBoxAdapter(child: SizedBox(height: Space.small.value)),
                SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: Space.small.value,
                  crossAxisSpacing: Space.small.value,
                  childCount: state.gridMeals.length,
                  itemBuilder: (context, index) {
                    final meal = state.gridMeals[index];
                    return MealGridItem(
                      meal: meal,
                      index: index,
                      onTap: () async {
                        await _precacheMealAssets(context, meal);
                        if (!context.mounted) {
                          return;
                        }
                        await context.router.push(MealDetailRoute(meal: meal));
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
