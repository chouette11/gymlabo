extension DateTimeExtension on DateTime {
  String get y => this.year.toString().padLeft(2, '0');
  String get M => this.month.toString().padLeft(2, '0');
  String get d => this.day.toString().padLeft(2, '0');
  String get h => this.hour.toString().padLeft(2, '0');
  String get m => this.minute.toString().padLeft(2, '0');
  DateTime get toDate => DateTime(year, month, day);
}