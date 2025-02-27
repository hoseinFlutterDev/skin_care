import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:skin_care/main.dart';
import 'package:skin_care/screen/add_screen.dart';
import 'dart:io';

import 'package:skin_care/screen/class/historymedical.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);
  static List<HistoryMedical> historys = [];

  // متد استاتیک برای دریافت ویزیت‌های یک بیمار خاص
  static List<HistoryMedical> getPatientVisits(
    int patientId,
    Box<HistoryMedical> visitBox,
  ) {
    return visitBox.values.where((visit) => visit.id == patientId).toList();
  }

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Box<HistoryMedical> visitBox = Hive.box('historyMedicalBox');

  @override
  void initState() {
    MyApp.saveVisit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // دریافت ویزیت‌های بیمار خاص با استفاده از patientId از صفحه AddPatientPage
    History.getPatientVisits(AddPatientPage.id, visitBox);

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Visit History',
            style: TextStyle(
              fontFamily: 'Caveat',
              fontSize: 35,
              color: Color.fromARGB(255, 12, 97, 167),
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 96, 98, 112),
                const Color.fromARGB(255, 184, 155, 98),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ValueListenableBuilder(
            valueListenable: visitBox.listenable(),
            builder: (context, Box<HistoryMedical> box, _) {
              var patientVisits = History.getPatientVisits(
                AddPatientPage.id,
                box,
              );

              return ListView.builder(
                itemCount: patientVisits.length,
                itemBuilder:
                    (context, index) => GestureDetector(
                      onLongPress: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text(
                                    'Are You Sure You Want To Delete This Visit?',
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            visitBox.deleteAt(index);
                                            MyApp.saveVisit();
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('No'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          );
                        });
                      },
                      child: historyWidget(
                        patientId:
                            AddPatientPage
                                .id, // ارسال patientId به historyWidget
                        index: index,
                        patientVisits: patientVisits, // ارسال ویزیت‌های بیمار
                      ),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class historyWidget extends StatelessWidget {
  final int patientId;
  final int index;
  final List<HistoryMedical> patientVisits;

  historyWidget({
    Key? key,
    required this.index,
    required this.patientId,
    required this.patientVisits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IntrinsicHeight(
              // ارتفاع را بر اساس محتوا تنظیم می‌کند
              child: Column(
                children: [
                  //! visit history
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home_outlined, color: Colors.white54),
                      SizedBox(width: 25),
                      Text(
                        'Visit History',
                        style: TextStyle(fontSize: 18, color: Colors.white60),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          // Date
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.date_range_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                patientVisits[index].visitDate,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          // Time
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                patientVisits[index].visitTime,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // image
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => Dialog(
                                    backgroundColor: Colors.black,
                                    child:
                                        patientVisits[index].imageVisit !=
                                                    null &&
                                                patientVisits[index]
                                                    .imageVisit!
                                                    .isNotEmpty
                                            ? Image.file(
                                              File(
                                                patientVisits[index]
                                                    .imageVisit!,
                                              ),
                                            )
                                            : Text('عکس انتخاب نشده است'),
                                  ),
                            );
                          },
                          child: SizedBox(
                            height: 150,
                            width: 100,
                            child:
                                patientVisits[index].imageVisit != null &&
                                        patientVisits[index]
                                            .imageVisit!
                                            .isNotEmpty
                                    ? Image.file(
                                      File(patientVisits[index].imageVisit!),
                                    )
                                    : Text('عکس انتخاب نشده است'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      patientVisits[index].historyMedical,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
