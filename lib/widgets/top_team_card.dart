import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/dashboard_data.dart';
import 'project_list.dart';

/// Shows top-performing employees this month — office equivalent of the
/// reference design's "Top Creators" panel.
class TopTeamCard extends StatelessWidget {
  const TopTeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashCard(
      color: AppColors.darkCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardHeader(
            title: 'Top Team Members',
            textColor: AppColors.textOnDark,
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('Name',
                    style: TextStyle(
                        color: AppColors.textOnDarkMuted, fontSize: 11.5)),
              ),
              Expanded(
                flex: 2,
                child: Text('Tasks',
                    style: TextStyle(
                        color: AppColors.textOnDarkMuted, fontSize: 11.5)),
              ),
              Expanded(
                flex: 2,
                child: Text('Rating',
                    style: TextStyle(
                        color: AppColors.textOnDarkMuted, fontSize: 11.5)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final m in DashboardData.team) _TeamRow(member: m),
        ],
      ),
    );
  }
}

class _TeamRow extends StatelessWidget {
  final TeamMember member;
  const _TeamRow({required this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.brandPurple.withValues(alpha: 0.25),
                  child: Text(
                    member.name[0],
                    style: const TextStyle(
                      color: AppColors.textOnDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    member.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textOnDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${member.tasksDone}',
              style: const TextStyle(
                  color: AppColors.textOnDarkMuted, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                const Icon(Icons.star_rounded,
                    size: 14, color: AppColors.warning),
                const SizedBox(width: 3),
                Text(
                  member.rating.toString(),
                  style: const TextStyle(
                      color: AppColors.textOnDark, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
