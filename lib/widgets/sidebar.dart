import 'package:flutter/material.dart';
import '../core/colors.dart';

class NavItem {
  final IconData icon;
  final String label;
  const NavItem(this.icon, this.label);
}

const List<NavItem> _navItems = [
  NavItem(Icons.dashboard_rounded, 'Home'),
  NavItem(Icons.campaign_rounded, 'Campaigns'),
  NavItem(Icons.groups_rounded, 'Employees'),
  NavItem(Icons.checklist_rounded, 'Attendance'),
  NavItem(Icons.summarize_rounded, 'Summary'),
  NavItem(Icons.info_outline_rounded, 'Information'),
];

/// Adstacks Media logo mark — small branded touch used across the app
/// (sidebar header, login, splash, etc).
class AdstacksLogo extends StatelessWidget {
  final double size;
  final bool showWordmark;
  const AdstacksLogo({super.key, this.size = 36, this.showWordmark = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(size * 0.3),
          ),
          alignment: Alignment.center,
          child: Text(
            'AS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: size * 0.4,
              letterSpacing: -0.5,
            ),
          ),
        ),
        if (showWordmark) ...[
          const SizedBox(width: 10),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Adstacks',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: ' Media',
                  style: TextStyle(
                    color: AppColors.brandPurple,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final bool collapsed;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
    this.collapsed = false,
  });

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.brandPurple,
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to sign in again to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandPink,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      _showFeedback(context, 'Logged out');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: collapsed ? 84 : 240,
      color: AppColors.sidebarBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Fixed header: logo + profile (never scrolls) ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: AdstacksLogo(showWordmark: !collapsed),
            ),
          ),
          const SizedBox(height: 28),
          if (!collapsed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _ProfileCard(),
            ),

          // --- Scrollable middle: nav items + workspaces ---
          // This is the actual fix for the overflow: on shorter screens
          // (or once "Campaigns" was added), the fixed-height content no
          // longer fit above the pinned Setting/Logout row, and a bare
          // Spacer can't shrink past zero — hence "overflowed by 12 pixels".
          // Wrapping this section in Expanded + SingleChildScrollView lets
          // it scroll instead of overflowing, on any screen size.
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < _navItems.length; i++)
                    _NavTile(
                      item: _navItems[i],
                      selected: selectedIndex == i,
                      collapsed: collapsed,
                      onTap: () => onSelect(i),
                    ),
                  const SizedBox(height: 18),
                  if (!collapsed)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'WORKSPACES',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.brandPurple,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  if (!collapsed) ...[
                    _WorkspaceTile(label: 'Adstacks'),
                    _WorkspaceTile(label: 'Finance'),
                  ],
                ],
              ),
            ),
          ),

          // --- Fixed footer: Setting + Logout (always visible, never pushed off) ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 1),
                const SizedBox(height: 8),
                _NavTile(
                  item: const NavItem(Icons.settings_outlined, 'Setting'),
                  selected: false,
                  collapsed: collapsed,
                  onTap: () => _showFeedback(context, 'Opening settings…'),
                ),
                _NavTile(
                  item: const NavItem(Icons.logout_rounded, 'Logout'),
                  selected: false,
                  collapsed: collapsed,
                  onTap: () => _confirmLogout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.brandPurpleLight,
          child: Icon(Icons.person, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        const Text(
          'Pooja Mishra',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.brandPurple.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Admin',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.brandPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _NavTile extends StatelessWidget {
  final NavItem item;
  final bool selected;
  final bool collapsed;
  final VoidCallback onTap;

  const _NavTile({
    required this.item,
    required this.selected,
    required this.collapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: selected ? AppColors.brandPurple.withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment:
            collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Icon(
            item.icon,
            size: 20,
            color: selected ? AppColors.brandPurple : AppColors.textSecondary,
          ),
          if (!collapsed) ...[
            const SizedBox(width: 12),
            Text(
              item.label,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected
                    ? AppColors.brandPurple
                    : AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: content,
    );
  }
}

class _WorkspaceTile extends StatelessWidget {
  final String label;
  const _WorkspaceTile({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.brandPurpleLight,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
