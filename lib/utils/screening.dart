class Screening {
  final String service;
  final DateTime date;
  final String time;
  final String location;
  final bool isCompleted;

  Screening({
    required this.service,
    required this.date,
    required this.time,
    required this.location,
    required this.isCompleted,
  });
}
