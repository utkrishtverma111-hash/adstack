import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/responsive.dart';
import '../models/campaign_data.dart';
import '../widgets/campaign_stats_row.dart';
import '../widgets/campaign_card.dart';

class CampaignsScreen extends StatelessWidget {
  const CampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = Responsive.value(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    ).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Client campaign performance across all active accounts',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 18),
        const CampaignStatsRow(),
        const SizedBox(height: 22),
        const Text(
          'All Campaigns',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: CampaignData.campaigns.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.35,
          ),
          itemBuilder: (context, i) =>
              CampaignCard(campaign: CampaignData.campaigns[i]),
        ),
      ],
    );
  }
}
