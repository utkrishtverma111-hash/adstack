import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/responsive.dart';
import '../models/campaign_data.dart';

class CampaignStatsRow extends StatelessWidget {
  const CampaignStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _Stat('Active Campaigns', '${CampaignData.activeCount}',
          Icons.bolt_rounded, AppColors.brandPurple),
      _Stat('Avg. ROI', '${CampaignData.averageRoi.toStringAsFixed(0)}%',
          Icons.trending_up_rounded, AppColors.success),
      _Stat('Total Leads', '${CampaignData.totalLeads}',
          Icons.groups_2_rounded, AppColors.brandPink),
      _Stat(
          'Ad Spend',
          '₹${(CampaignData.totalSpend / 1000).toStringAsFixed(0)}K',
          Icons.account_balance_wallet_rounded,
          AppColors.warning),
    ];

    final isMobile = Responsive.isMobile(context);

    return GridView.count(
      crossAxisCount: isMobile ? 2 : 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: isMobile ? 1.6 : 1.9,
      children: [for (final s in stats) _StatCard(stat: s)],
    );
  }
}

class _Stat {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  _Stat(this.label, this.value, this.icon, this.color);
}

class _StatCard extends StatelessWidget {
  final _Stat stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: stat.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(stat.icon, color: stat.color, size: 18),
          ),
          const Spacer(),
          Text(
            stat.value,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: const TextStyle(
              fontSize: 11.5,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
