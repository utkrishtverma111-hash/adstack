class ProjectItem {
  final String title;
  final String subtitle;
  final bool highlighted;
  const ProjectItem({
    required this.title,
    required this.subtitle,
    this.highlighted = false,
  });
}

class TeamMember {
  final String name;
  final int tasksDone;
  final double rating;
  const TeamMember({
    required this.name,
    required this.tasksDone,
    required this.rating,
  });
}

class CelebrationPerson {
  final String name;
  final String emoji;
  const CelebrationPerson({required this.name, required this.emoji});
}

class PerformancePoint {
  final int year;
  final double pending;
  final double done;
  const PerformancePoint(this.year, this.pending, this.done);
}

/// Mock office data for Adstacks Media — replace with real API/DB data.
class DashboardData {
  static const projects = [
    ProjectItem(
      title: 'Technology behind the Blockchain',
      subtitle: 'Project #1 · See project details',
      highlighted: true,
    ),
    ProjectItem(
      title: 'Q3 Client Onboarding Revamp',
      subtitle: 'Project #2 · See project details',
    ),
    ProjectItem(
      title: 'Adstacks Media Brand Refresh',
      subtitle: 'Project #3 · See project details',
    ),
  ];

  static const team = [
    TeamMember(name: 'Priya Mehta', tasksDone: 562, rating: 4.8),
    TeamMember(name: 'Karan Patel', tasksDone: 522, rating: 4.6),
    TeamMember(name: 'Aman Bose', tasksDone: 562, rating: 4.5),
  ];

  static const birthdays = [
    CelebrationPerson(name: 'Riya', emoji: '🎂'),
    CelebrationPerson(name: 'Dev', emoji: '🎉'),
  ];

  static const anniversaries = [
    CelebrationPerson(name: 'Sara', emoji: '🎊'),
    CelebrationPerson(name: 'Ankit', emoji: '🏆'),
    CelebrationPerson(name: 'Neha', emoji: '✨'),
  ];

  static const performance = [
    PerformancePoint(2015, 20, 30),
    PerformancePoint(2016, 35, 15),
    PerformancePoint(2017, 18, 38),
    PerformancePoint(2018, 32, 20),
    PerformancePoint(2019, 22, 45),
    PerformancePoint(2020, 38, 25),
  ];
}
