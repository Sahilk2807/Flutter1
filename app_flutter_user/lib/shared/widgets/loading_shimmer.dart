import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';

class LoadingShimmer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Color? baseColor;
  final Color? highlightColor;

  const LoadingShimmer({
    super.key,
    required this.child,
    required this.isLoading,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Shimmer.fromColors(
      baseColor: baseColor ?? AppTheme.surfaceVariant,
      highlightColor: highlightColor ?? AppTheme.surface,
      child: child,
    );
  }
}

class ShimmerCard extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const ShimmerCard({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerText({
    super.key,
    required this.width,
    this.height = 16,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class ShimmerListTile extends StatelessWidget {
  final bool hasLeading;
  final bool hasTrailing;
  final int titleLines;
  final int subtitleLines;

  const ShimmerListTile({
    super.key,
    this.hasLeading = true,
    this.hasTrailing = false,
    this.titleLines = 1,
    this.subtitleLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (hasLeading) ...[
            const ShimmerCard(width: 48, height: 48, borderRadius: 24),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < titleLines; i++) ...[
                  ShimmerText(
                    width: i == titleLines - 1 ? 120 : double.infinity,
                  ),
                  if (i < titleLines - 1) const SizedBox(height: 4),
                ],
                if (subtitleLines > 0) const SizedBox(height: 8),
                for (int i = 0; i < subtitleLines; i++) ...[
                  ShimmerText(
                    width: i == subtitleLines - 1 ? 80 : double.infinity,
                    height: 12,
                  ),
                  if (i < subtitleLines - 1) const SizedBox(height: 4),
                ],
              ],
            ),
          ),
          if (hasTrailing) ...[
            const SizedBox(width: 16),
            const ShimmerCard(width: 24, height: 24, borderRadius: 12),
          ],
        ],
      ),
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const ShimmerGrid({
    super.key,
    this.itemCount = 6,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const ShimmerCard(height: 120);
      },
    );
  }
}

