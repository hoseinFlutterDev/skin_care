// ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:skin_care/main.dart';
import 'package:skin_care/screen/add_screen.dart';
import 'package:skin_care/screen/album.dart';
import 'package:skin_care/screen/class/reminder.dart';
import 'package:skin_care/screen/class/responsiv.dart';
import 'package:skin_care/screen/history.dart';
import 'package:skin_care/screen/home_page.dart';
import 'package:skin_care/screen/new_visit.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({
    super.key,
    // required Map user,
    // required Null Function(Map<String, String> updatedUser) onSave,
    // required Null Function(dynamic updatedUser) onUpdate
  });
  static String dateAppointment = 'Date';
  static String timeAppointment = 'Time';
  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  TextEditingController historycontroler = TextEditingController();
  Box<Reminder> hiveBox = Hive.box('reminderBox');

  @override
  void initState() {
    super.initState();

    // بازیابی از Hive
    var reminder = hiveBox.get('nextAppointment_${AddPatientPage.id}');
    if (reminder != null) {
      setState(() {
        HomePage.patients[AddPatientPage.id].futureAppointment = reminder;
        UserDetailPage.dateAppointment = reminder.dateAppointment;
        UserDetailPage.timeAppointment = reminder.timeAppointment;
      });
    }

    MyApp.getData();
  }

  @override
  Widget build(BuildContext context) {
    List<Reminder> nextAppointment = [];
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 96, 98, 112),
                Color.fromARGB(255, 184, 155, 98),
              ],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Reminder item = Reminder(
                      dateAppointment: UserDetailPage.dateAppointment,
                      timeAppointment: UserDetailPage.timeAppointment,
                    );
                    hiveBox.add(item);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => History()),
                      );
                    },
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.history_rounded, size: 30),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      MyApp.saveVisit();
                      if (AddPatientPage.id == null) {
                        print("Error: Patient index is null!");
                        return;
                      }

                      print(
                        "Navigating to Album Page for Patient Index: ${AddPatientPage.id}",
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => PatientAlbumPage(
                                patientIndex: AddPatientPage.id,
                              ),
                        ),
                      );
                    },
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.photo_library_outlined, size: 30),
                    ),
                  ),
                ],
                floating: true,
                backgroundColor: Colors.transparent,
                expandedHeight: 400,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text(
                    " Details",
                    style: TextStyle(
                      fontFamily: 'Caveat',
                      fontSize: 40,
                      color: Color.fromARGB(255, 12, 97, 167),
                    ),
                  ),
                  background: Padding(
                    padding: const EdgeInsets.only(
                      top: 93,
                      bottom: 90,
                      left: 65,
                      right: 65,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        child:
                            HomePage.patients[AddPatientPage.id].imagePath !=
                                        null &&
                                    HomePage
                                        .patients[AddPatientPage.id]
                                        .imagePath!
                                        .isNotEmpty
                                ? Image.file(
                                  File(
                                    HomePage
                                        .patients[AddPatientPage.id]
                                        .imagePath!,
                                  ),
                                  fit: BoxFit.cover, // تنظیم اندازه تصویر
                                )
                                : Image.asset(
                                  'assets/images/sun.jpg',
                                  fit: BoxFit.cover, // تنظیم اندازه تصویر
                                ),
                      ),
                    ),
                  ),
                ),
              ),
              // detail
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: screenSize(context).screenHeight * 0.37,
                    width: screenSize(context).screenWidth * 0.2,
                    child: Column(
                      spacing: 18,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Name :',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                      255,
                                      62,
                                      131,
                                      227,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: controltext(
                                  text: AddPatientPage.nameController.text,
                                  controler: AddPatientPage.nameController,
                                ),
                              ),
                              SizedBox(
                                width: screenSize(context).screenWidth * 0.40,
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      AddPatientPage.isEditing = true;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => AddPatientPage(),
                                        ),
                                      ).then((value) {
                                        setState(() {});
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.edit, color: Colors.white60),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'famely :',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color.fromARGB(
                                    255,
                                    62,
                                    131,
                                    227,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              controltext(
                                text: AddPatientPage.famlyController.text,
                                controler: AddPatientPage.famlyController,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'National :',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color.fromARGB(
                                    255,
                                    62,
                                    131,
                                    227,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              controltext(
                                text: AddPatientPage.nationController.text,
                                controler: AddPatientPage.nationController,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'Phone Number :',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color.fromARGB(
                                    255,
                                    62,
                                    131,
                                    227,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              controltext(
                                text: AddPatientPage.numberController.text,
                                controler: AddPatientPage.numberController,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Expanded(
                                flex: 7,
                                child: Row(
                                  children: [
                                    Text(
                                      'Age :',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: const Color.fromARGB(
                                          255,
                                          62,
                                          131,
                                          227,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    controltext(
                                      text: AddPatientPage.ageController.text,
                                      controler: AddPatientPage.ageController,
                                    ),
                                    SizedBox(
                                      width:
                                          screenSize(context).screenWidth *
                                          0.38,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        ), // خط دور مستطیل
                                        borderRadius: BorderRadius.circular(
                                          5,
                                        ), // گوشه‌های نرم
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Next Appointment',
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                255,
                                                62,
                                                131,
                                                227,
                                              ),
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          //! Data
                                          GestureDetector(
                                            onTap: () async {
                                              Jalali? pickedDate =
                                                  await showPersianDatePicker(
                                                    context: context,
                                                    initialDate: Jalali.now(),
                                                    firstDate: Jalali(1400),
                                                    lastDate: Jalali(1420),
                                                  );

                                              if (pickedDate != null) {
                                                TimeOfDay? pickedTime =
                                                    await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                    );

                                                if (pickedTime != null) {
                                                  setState(() {
                                                    HomePage
                                                        .patients[AddPatientPage
                                                            .id]
                                                        .futureAppointment = Reminder(
                                                      dateAppointment:
                                                          '${pickedDate.year}/${pickedDate.month}/${pickedDate.day}',
                                                      timeAppointment:
                                                          '${pickedTime.hour}:${pickedTime.minute}',
                                                    );

                                                    // ذخیره در Hive
                                                    hiveBox.put(
                                                      'nextAppointment_${AddPatientPage.id}', // کلید منحصر به فرد
                                                      Reminder(
                                                        dateAppointment:
                                                            '${pickedDate.year}/${pickedDate.month}/${pickedDate.day}',
                                                        timeAppointment:
                                                            '${pickedTime.hour}:${pickedTime.minute}',
                                                      ),
                                                    );
                                                  });
                                                  MyApp.getData();
                                                }
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.date_range),
                                                SizedBox(width: 10),
                                                Text(
                                                  HomePage
                                                          .patients[AddPatientPage
                                                              .id]
                                                          .futureAppointment
                                                          ?.dateAppointment ??
                                                      'Date',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          //Time
                                          GestureDetector(
                                            onTap: () async {
                                              TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  );

                                              if (pickedTime != null) {
                                                setState(() {
                                                  HomePage
                                                      .patients[AddPatientPage
                                                          .id]
                                                      .futureAppointment = Reminder(
                                                    dateAppointment:
                                                        HomePage
                                                            .patients[AddPatientPage
                                                                .id]
                                                            .futureAppointment!
                                                            .dateAppointment, // تاریخ قبلی را نگه دارید
                                                    timeAppointment:
                                                        '${pickedTime.hour}:${pickedTime.minute}', // زمان جدید را ذخیره کنید
                                                  );
                                                });
                                                MyApp.getData();
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.access_time),
                                                SizedBox(width: 10),
                                                Text(
                                                  HomePage
                                                          .patients[AddPatientPage
                                                              .id]
                                                          .futureAppointment
                                                          ?.timeAppointment ??
                                                      'Time',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //! History
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.history, color: Colors.white54),
                                SizedBox(width: 25),
                                Text(
                                  'Patient History',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Expanded(
                              child: Text(
                                AddPatientPage.historyControler.text,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: const Color.fromARGB(
                                    137,
                                    241,
                                    237,
                                    237,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //! Address
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.home_outlined,
                                  color: Colors.white54,
                                ),
                                SizedBox(width: 25),
                                Text(
                                  'Address',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Text(
                              AddPatientPage.addressControler.text,
                              style: TextStyle(
                                fontSize: 22,
                                color: const Color.fromARGB(137, 241, 237, 237),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //!new visit push
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(side: BorderSide()),
          backgroundColor: const Color.fromARGB(255, 200, 232, 236),
          onPressed: () async {
            MyApp.saveVisit();
            NewVisit.newHistoryControler.text = '';
            NewVisit.date = 'Date';
            NewVisit.time = 'Time';
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewVisit(patientId: AddPatientPage.id),
              ),
            );

            // if (result != null) {
            //   setState(() {
            //     History.historys.add(result);
            //   });
            // }
          },
          child: Icon(
            Icons.medical_services,
            size: 35,
            color: const Color.fromARGB(255, 20, 115, 193),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class controltext extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controler;
  String text;
  controltext({required this.controler, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 18, color: Colors.white));
  }
}
