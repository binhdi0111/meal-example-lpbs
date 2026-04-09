import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart';
import 'package:clean_architecture/shared_ui/ui/paralleogram_clipper.dart';
import 'package:clean_architecture/shared_ui/utils/image_cache_manager.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class FeaturedMealCard extends StatefulWidget {
  const FeaturedMealCard({required this.meal, this.onTap, super.key});

  final Meal meal;
  final VoidCallback? onTap;

  @override
  State<FeaturedMealCard> createState() => _FeaturedMealCardState();
}

class _FeaturedMealCardState extends State<FeaturedMealCard>
    with SingleTickerProviderStateMixin {
  static const double _cardImageHeight = 240;
  static const double _parallelogramBase = 60;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;

    return Container(
      decoration: BoxDecoration(
        borderRadius: UIHelpers.radiusC16,
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            blurRadius: Space.small.value,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: UIHelpers.radiusC16,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                cacheManager: ImageCacheManager.instance,
                imageUrl: meal.strMealThumb,
                width: double.infinity,
                height: _cardImageHeight,
                fit: BoxFit.cover,
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final dx = -120 + (_controller.value * 420);
                  return Transform.translate(
                    offset: Offset(dx, 0),
                    child: child,
                  );
                },
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.diagonal3Values(-1, 1, 1),
                  child: Parallelogram(
                    base: _parallelogramBase,
                    height: _cardImageHeight,
                    angleDeg: 60,
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(Space.small.value),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF1E1E1E).withValues(alpha: 0),
                      const Color(0xFF1E1E1E).withValues(alpha: 0.5),
                      const Color(0xFF1E1E1E).withValues(alpha: 0.95),
                    ],
                    stops: const [0.35, 0.6, 1],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.strMeal,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    UIHelpers.spaceV4,
                    Text(
                      meal.strCategory,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
