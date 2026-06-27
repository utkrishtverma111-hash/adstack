import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/responsive.dart';

class TopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onMenuTap;

  const TopBar({super.key, required this.title, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Row(
      children: [
        if (isMobile)
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: onMenuTap,
          ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 24),
        if (!isMobile)
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          const Spacer(),
        const SizedBox(width: 12),
        _IconButtonRounded(icon: Icons.grid_view_rounded),
        const SizedBox(width: 10),
        _IconButtonRounded(icon: Icons.notifications_none_rounded, badge: true),
        const SizedBox(width: 10),
        _IconButtonRounded(icon: Icons.power_settings_new_rounded),
        const SizedBox(width: 12),
        const CircleAvatar(
          radius: 19,
          backgroundColor: AppColors.brandPurpleLight,
          child: Icon(Icons.person, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}

class _IconButtonRounded extends StatelessWidget {
  final IconData icon;
  final bool badge;
  const _IconButtonRounded({required this.icon, this.badge = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 20, color: AppColors.textSecondary),
        ),
        if (badge)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.brandPink,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
