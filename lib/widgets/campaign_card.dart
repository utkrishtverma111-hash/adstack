import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/colors.dart';
import '../models/campaign_data.dart';

class CampaignCard extends StatelessWidget {
  final ClientCampaign campaign;
  const CampaignCard({super.key, required this.campaign});

  Color get _statusColor {
    switch (campaign.status) {
      case CampaignStatus.active:
        return AppColors.success;
      case CampaignStatus.review:
        return AppColors.warning;
      case CampaignStatus.completed:
        return AppColors.textSecondary;
    }
  }

  String get _statusLabel {
    switch (campaign.status) {
      case CampaignStatus.active:
        return 'Active';
      case CampaignStatus.review:
        return 'In Review';
      case CampaignStatus.completed:
        return 'Completed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.brandPurple.withValues(alpha: 0.12),
                child: Text(
                  campaign.clientName[0],
                  style: const TextStyle(
                    color: AppColors.brandPurple,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.clientName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.5,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    _ChannelBadge(label: campaign.channel.label),
                  ],
                ),
              ),
              _StatusDot(color: _statusColor, label: _statusLabel),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  label: 'ROI',
                  value: '${campaign.roiPercent.toStringAsFixed(0)}%',
                  valueColor: campaign.roiPercent >= 100
                      ? AppColors.success
                      : AppColors.danger,
                ),
              ),
              Expanded(
                child: _MiniStat(
                  label: 'Leads',
                  value: '${campaign.leadsGenerated}',
                ),
              ),
              SizedBox(
                width: 60,
                height: 32,
                child: _Sparkline(values: campaign.trend),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Budget used',
                  style:
                      TextStyle(fontSize: 11.5, color: AppColors.textSecondary)),
              Text(
                '₹${(campaign.budgetSpent / 1000).toStringAsFixed(0)}K / ₹${(campaign.budgetTotal / 1000).toStringAsFixed(0)}K',
                style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: campaign.spendProgress,
              minHeight: 6,
              backgroundColor: AppColors.scaffold,
              color: AppColors.brandPurple,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChannelBadge extends StatelessWidget {
  final String label;
  const _ChannelBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.brandPink.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: AppColors.brandPink,
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final Color color;
  final String label;
  const _StatusDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _MiniStat({
    required this.label,
    required this.value,
    this.valueColor = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: valueColor)),
        Text(label,
            style: const TextStyle(
                fontSize: 10.5, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _Sparkline extends StatelessWidget {
  final List<double> values;
  const _Sparkline({required this.values});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineTouchData: const LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < values.length; i++)
                FlSpot(i.toDouble(), values[i]),
            ],
            isCurved: true,
            color: AppColors.brandPurple,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.brandPurple.withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}
