import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/features/list_meal/domain/entities/meal.dart';
import 'package:clean_architecture/shared_ui/ui/animated_scale_button.dart';
import 'package:clean_architecture/shared_ui/ui/bounce_animation_button.dart';
import 'package:clean_architecture/shared_ui/utils/image_cache_manager.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class MealGridItem extends StatelessWidget {
  const MealGridItem({
    required this.meal,
    required this.index,
    this.onTap,
    super.key,
  });

  final Meal meal;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: UIHelpers.radiusC12,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: Space.xSmall.value,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.white,
          borderRadius: UIHelpers.radiusC12,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  cacheManager: ImageCacheManager.instance,
                  imageUrl: meal.strMealThumb,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: index.isEven ? 140 : 190,
                ),
                Padding(
                  padding: UIHelpers.paddingA12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.strMeal,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      UIHelpers.spaceV4,
                      Text(
                        meal.strCategory,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      UIHelpers.spaceV8,
                      Align(
                        alignment: Alignment.centerRight,
                        child: BounceLoopButton(
                          boxDecoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: UIHelpers.radiusC24,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withValues(alpha: 0.35),
                                offset: const Offset(-2, 2),
                              ),
                            ],
                          ),
                          offsetX: 2,
                          offsetY: 2,
                          scaleMax: 1.02,
                          child: GestureDetector(
                            onTap: onTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: UIHelpers.radiusC24,
                              ),
                              child: const Text(
                                'Detail',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
