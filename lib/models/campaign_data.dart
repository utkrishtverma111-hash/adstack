enum Channel { seo, ppc, social, web, leadGen }

extension ChannelLabel on Channel {
  String get label {
    switch (this) {
      case Channel.seo:
        return 'SEO';
      case Channel.ppc:
        return 'PPC';
      case Channel.social:
        return 'Social';
      case Channel.web:
        return 'Web Dev';
      case Channel.leadGen:
        return 'Lead Gen';
    }
  }
}

enum CampaignStatus { active, review, completed }

class ClientCampaign {
  final String clientName;
  final Channel channel;
  final CampaignStatus status;
  final double budgetSpent; // in currency units
  final double budgetTotal;
  final double roiPercent; // e.g. 184 = 184% ROI
  final int leadsGenerated;
  final List<double> trend; // last 6 periods, for sparkline

  const ClientCampaign({
    required this.clientName,
    required this.channel,
    required this.status,
    required this.budgetSpent,
    required this.budgetTotal,
    required this.roiPercent,
    required this.leadsGenerated,
    required this.trend,
  });

  double get spendProgress =>
      budgetTotal == 0 ? 0 : (budgetSpent / budgetTotal).clamp(0, 1);
}

/// Mock client/campaign data — modeled on the kind of accounts an agency
/// like Adstacks Media runs (SEO, PPC, social, web, lead gen). Swap for
/// your real campaign-management API or CRM data.
class CampaignData {
  static const campaigns = [
    ClientCampaign(
      clientName: 'Bolt Rides',
      channel: Channel.ppc,
      status: CampaignStatus.active,
      budgetSpent: 84000,
      budgetTotal: 120000,
      roiPercent: 212,
      leadsGenerated: 1340,
      trend: [40, 55, 48, 62, 70, 78],
    ),
    ClientCampaign(
      clientName: 'CoinDCX',
      channel: Channel.seo,
      status: CampaignStatus.active,
      budgetSpent: 32000,
      budgetTotal: 50000,
      roiPercent: 156,
      leadsGenerated: 860,
      trend: [22, 28, 30, 35, 33, 41],
    ),
    ClientCampaign(
      clientName: 'Spinny',
      channel: Channel.web,
      status: CampaignStatus.completed,
      budgetSpent: 95000,
      budgetTotal: 95000,
      roiPercent: 98,
      leadsGenerated: 410,
      trend: [10, 18, 25, 30, 28, 32],
    ),
    ClientCampaign(
      clientName: 'Acko Insurance',
      channel: Channel.social,
      status: CampaignStatus.active,
      budgetSpent: 61000,
      budgetTotal: 90000,
      roiPercent: 174,
      leadsGenerated: 1120,
      trend: [30, 34, 29, 45, 50, 58],
    ),
    ClientCampaign(
      clientName: 'EaseMyTrip',
      channel: Channel.leadGen,
      status: CampaignStatus.review,
      budgetSpent: 18000,
      budgetTotal: 40000,
      roiPercent: 88,
      leadsGenerated: 290,
      trend: [12, 15, 14, 18, 16, 20],
    ),
    ClientCampaign(
      clientName: 'Lenskart',
      channel: Channel.ppc,
      status: CampaignStatus.active,
      budgetSpent: 110000,
      budgetTotal: 150000,
      roiPercent: 245,
      leadsGenerated: 1980,
      trend: [50, 60, 58, 72, 80, 92],
    ),
  ];

  static double get averageRoi {
    final total = campaigns.fold<double>(0, (s, c) => s + c.roiPercent);
    return total / campaigns.length;
  }

  static int get totalLeads =>
      campaigns.fold<int>(0, (s, c) => s + c.leadsGenerated);

  static int get activeCount =>
      campaigns.where((c) => c.status == CampaignStatus.active).length;

  static double get totalSpend =>
      campaigns.fold<double>(0, (s, c) => s + c.budgetSpent);
}
