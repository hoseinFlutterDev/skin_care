import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:skin_care/screen/begin_screen.dart';
import 'package:skin_care/screen/class/historymedical.dart';
import 'package:skin_care/screen/class/reminder.dart';
import 'package:skin_care/screen/class/specification.dart';
import 'package:skin_care/screen/history.dart';
import 'package:skin_care/screen/home_page.dart';

void main() async {
  await Hive.initFlutter();

  // ثبت adapter برای Reminder
  Hive.registerAdapter(SpecificationAdapter());
  Hive.registerAdapter(HistoryMedicalAdapter());
  Hive.registerAdapter(ReminderAdapter()); // این خط را اضافه کنید

  await Hive.openBox<Specification>('mybox');
  await Hive.openBox<HistoryMedical>(
    'historyMedicalBox',
  ); // باز کردن باکس HistoryMedical
  await Hive.openBox<Reminder>(
    'reminderBox',
  ); // باز کردن باکس برای Reminder (اختیاری)

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static void saveVisit() {
    History.historys.clear();
    Box<HistoryMedical> visitBox = Hive.box<HistoryMedical>(
      'historyMedicalBox',
    );
    for (var value in visitBox.values) {
      History.historys.add(value);
    }
  }

  static void getData() {
    HomePage.patients.clear();
    Box<Specification> hiveBox = Hive.box<Specification>('mybox');
    for (var value in hiveBox.values) {
      HomePage.patients.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale("fa", "IR"),
      supportedLocales: const [Locale("fa", "IR"), Locale("en", "US")],
      localizationsDelegates: const [
        // Add Localization
        PersianMaterialLocalizations.delegate,
        PersianCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: BeginScreen(),
    );
  }
}
