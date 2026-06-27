import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/dashboard_data.dart';

/// Reusable white rounded card used across the dashboard.
class DashCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;

  const DashCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color = AppColors.cardBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class CardHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onMore;
  final Color textColor;
  const CardHeader({
    super.key,
    required this.title,
    this.onMore,
    this.textColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        InkWell(
          onTap: onMore,
          child: Icon(Icons.more_horiz, color: textColor.withValues(alpha: 0.5)),
        ),
      ],
    );
  }
}

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    return DashCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardHeader(title: 'All Projects'),
          const SizedBox(height: 14),
          for (final p in DashboardData.projects)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ProjectTile(item: p),
            ),
        ],
      ),
    );
  }
}

class _ProjectTile extends StatelessWidget {
  final ProjectItem item;
  const _ProjectTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final bg = item.highlighted
        ? AppColors.brandPurple
        : AppColors.scaffold;
    final fg = item.highlighted ? Colors.white : AppColors.textPrimary;
    final subFg = item.highlighted
        ? Colors.white.withValues(alpha: 0.75)
        : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: item.highlighted
                  ? Colors.white.withValues(alpha: 0.15)
                  : AppColors.brandPurple.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.link_rounded,
              color: item.highlighted ? Colors.white : AppColors.brandPurple,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                    color: fg,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  style: TextStyle(fontSize: 11.5, color: subFg),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
