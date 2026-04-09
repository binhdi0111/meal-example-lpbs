import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart';
import 'package:clean_architecture/features/meal_detail/presentation/cubit/meal_detail_cubit.dart';
import 'package:clean_architecture/shared_ui/ui/expandable_text.dart';
import 'package:clean_architecture/shared_ui/utils/image_cache_manager.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class MealDetailPage extends StatelessWidget {
  const MealDetailPage({required this.meal, super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<MealDetailCubit>()..initialize(meal: meal),
      child: const _MealDetailView(),
    );
  }
}

class _MealDetailView extends StatefulWidget {
  const _MealDetailView();

  @override
  State<_MealDetailView> createState() => _MealDetailViewState();
}

class _MealDetailViewState extends State<_MealDetailView> {
  static const double _expandedHeight = 360;
  late final ScrollController _scrollController;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    final collapsed = _scrollController.hasClients &&
        _scrollController.offset > (_expandedHeight - kToolbarHeight - 24);
    if (collapsed != _isCollapsed) {
      setState(() {
        _isCollapsed = collapsed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.scaffoldBackgroundColor;
    final appBarForeground = _isCollapsed ? Colors.black : Colors.white;

    return BlocBuilder<MealDetailCubit, MealDetailState>(
      builder: (context, state) {
        final meal = state.meal;
        if (meal == null) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: surfaceColor,
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                expandedHeight: _expandedHeight,
                backgroundColor: surfaceColor,
                surfaceTintColor: Colors.transparent,
                elevation: _isCollapsed ? Space.xxSmall.value : 0,
                scrolledUnderElevation: Space.xxSmall.value,
                shadowColor: Colors.black.withValues(alpha: 0.18),
                foregroundColor: appBarForeground,
                iconTheme: IconThemeData(color: appBarForeground),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        cacheManager: ImageCacheManager.instance,
                        imageUrl: meal.strMealThumb,
                        fit: BoxFit.cover,
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x66000000), Color(0x00000000)],
                            stops: [0, 0.3],
                          ),
                        ),
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x00000000), Color(0xCC000000)],
                            stops: [0.45, 1],
                          ),
                        ),
                      ),
                      Positioned(
                        left: Space.sMedium.value,
                        right: Space.sMedium.value,
                        bottom: Space.large.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meal.strMeal,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            UIHelpers.spaceV8,
                            Container(
                              padding: UIHelpers.paddingH16V8,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.18),
                                borderRadius: UIHelpers.radiusC24,
                              ),
                              child: Text(
                                meal.strCategory,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: SingleChildScrollView(
              child: DecoratedBox(
                decoration: BoxDecoration(color: surfaceColor),
                child: Container(
                  padding: UIHelpers.paddingA16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Instructions',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      UIHelpers.spaceV12,
                    ExpandableTextInlineEllipsis(
                      text: meal.strInstructions,
                      maxLines: 5,
                      linkColor: theme.colorScheme.primary,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
