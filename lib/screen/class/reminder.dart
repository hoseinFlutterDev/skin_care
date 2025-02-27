// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 2) // typeId باید یکتا باشه
class Reminder extends HiveObject {
  @HiveField(0)
  final String dateAppointment; // زمان یادآور

  @HiveField(1)
  final String timeAppointment; // زمان یادآور
  // در اینجا به جای پارامتر text، به طور مستقیم فیلدهای مورد نیاز را می‌فرستیم
  Reminder({required this.dateAppointment, required this.timeAppointment});
}
