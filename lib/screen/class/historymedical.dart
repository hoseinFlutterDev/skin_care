import 'package:hive/hive.dart';

part 'historymedical.g.dart'; // اینجا به فایل .g.dart اشاره کنید

@HiveType(typeId: 1)
class HistoryMedical extends HiveObject {
  @HiveField(1)
  int id;

  @HiveField(2)
  final String historyMedical;

  @HiveField(3)
  final String visitDate; // تاریخ

  @HiveField(4)
  final String visitTime; // زمان
  @HiveField(5)
  final String? imageVisit; // فیلد جدید برای ذخیره مسیر تصویر

  HistoryMedical({
    required this.imageVisit,
    required this.id,
    required this.historyMedical,
    required this.visitDate,
    required this.visitTime, // مقداردهی به زمان
  });
}
