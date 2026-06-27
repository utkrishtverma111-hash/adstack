import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../models/dashboard_data.dart';

class CelebrationCard extends StatelessWidget {
  final String title;
  final List<CelebrationPerson> people;
  final String ctaLabel;
  final Color accent;

  const CelebrationCard({
    super.key,
    required this.title,
    required this.people,
    required this.ctaLabel,
    this.accent = AppColors.brandPurple,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCardAlt,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title,
                  style: const TextStyle(
                    color: AppColors.textOnDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  )),
              const SizedBox(width: 6),
              const Text('✨', style: TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final p in people)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: accent.withValues(alpha: 0.25),
                    child: Text(p.emoji, style: const TextStyle(fontSize: 16)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Text('Total',
                  style: TextStyle(
                      color: AppColors.textOnDarkMuted, fontSize: 12)),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${people.length}',
                  style: const TextStyle(
                      color: AppColors.textOnDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(ctaLabel,
                  style: const TextStyle(
                      fontSize: 12.5, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
