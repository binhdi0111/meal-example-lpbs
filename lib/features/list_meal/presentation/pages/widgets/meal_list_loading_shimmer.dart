import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class MealListLoadingShimmer extends StatelessWidget {
  const MealListLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              Space.sMedium.value,
              Space.sMedium.value,
              Space.sMedium.value,
              Space.xSmall.value,
            ),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: UIHelpers.radiusC16,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: UIHelpers.paddingA16,
            sliver: SliverMasonryGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: Space.small.value,
              crossAxisSpacing: Space.small.value,
              childCount: 8,
              itemBuilder: (context, index) {
                final imageHeight = index.isEven ? 140.0 : 190.0;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: UIHelpers.radiusC12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: imageHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(Space.small.value),
                          ),
                        ),
                      ),
                      Padding(
                        padding: UIHelpers.paddingA12,
                        child: Container(
                          height: Space.small.value,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: UIHelpers.radiusC4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
