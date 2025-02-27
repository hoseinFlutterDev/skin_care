import 'package:hive/hive.dart';
import 'package:skin_care/screen/class/reminder.dart';
import 'historymedical.dart';

part 'specification.g.dart';

@HiveType(typeId: 0)
class Specification extends HiveObject {
  @HiveField(1)
  int id;

  @HiveField(2)
  String? imagePath;

  @HiveField(3)
  String name;

  @HiveField(4)
  String famely;

  @HiveField(5)
  String nation;

  @HiveField(6)
  String number;

  @HiveField(7)
  String age;

  @HiveField(8)
  String history;

  @HiveField(9)
  String address;

  @HiveField(10)
  List<String> imagePaths;

  @HiveField(11)
  HiveList<HistoryMedical> visits; // تغییر به HiveList<HistoryMedical>
  @HiveField(12)
  Reminder? futureAppointment; // یادآور برای وقت آینده بیمار

  Specification({
    required this.address,
    required this.history,
    required this.id,
    required this.imagePath,
    required this.name,
    required this.famely,
    required this.nation,
    required this.number,
    required this.age,
    required this.imagePaths,
    required this.visits, // اینجا هم باید به عنوان HiveList تحویل داده بشه
    this.futureAppointment, // یادآور جدید
  });
}
