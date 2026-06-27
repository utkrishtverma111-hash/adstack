import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../core/colors.dart';

class OfficeScheduleCard extends StatefulWidget {
  const OfficeScheduleCard({super.key});

  @override
  State<OfficeScheduleCard> createState() => _OfficeScheduleCardState();
}

class _OfficeScheduleCardState extends State<OfficeScheduleCard> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'General · 10:00 AM to 7:00 PM',
            style: TextStyle(
              color: AppColors.textOnDark,
              fontWeight: FontWeight.w600,
              fontSize: 13.5,
            ),
          ),
          const SizedBox(height: 10),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2035, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: false,
              titleTextStyle: TextStyle(
                color: AppColors.textOnDark,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              leftChevronIcon: Icon(Icons.chevron_left,
                  color: AppColors.textOnDarkMuted, size: 18),
              rightChevronIcon: Icon(Icons.chevron_right,
                  color: AppColors.textOnDarkMuted, size: 18),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle:
                  TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11),
              weekendStyle:
                  TextStyle(color: AppColors.textOnDarkMuted, fontSize: 11),
            ),
            calendarStyle: CalendarStyle(
              defaultTextStyle:
                  const TextStyle(color: AppColors.textOnDark, fontSize: 12),
              weekendTextStyle:
                  const TextStyle(color: AppColors.textOnDark, fontSize: 12),
              outsideTextStyle:
                  TextStyle(color: AppColors.textOnDarkMuted.withValues(alpha: 0.4)),
              todayDecoration: BoxDecoration(
                color: AppColors.brandPurple.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: AppColors.brandPurple,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
