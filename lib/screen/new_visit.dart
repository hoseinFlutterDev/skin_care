// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:skin_care/main.dart';
import 'package:skin_care/screen/add_screen.dart';
import 'package:skin_care/screen/class/historymedical.dart';

class NewVisit extends StatefulWidget {
  final int patientId; // شناسه مریض
  const NewVisit({Key? key, required this.patientId}) : super(key: key);
  static TextEditingController newHistoryControler = TextEditingController();
  static String date = 'Date';
  static String time = 'Time';

  @override
  State<NewVisit> createState() => _NewVisitState();
}

class _NewVisitState extends State<NewVisit> {
  Box<HistoryMedical> visitBox = Hive.box('historyMedicalBox');

  // time Show
  // static DateTime _selectedDate = DateTime.now();
  // TimeOfDay _selectedTime = TimeOfDay.now();

  //   void _pickDate() async {
  //     DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: _selectedDate,
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2050),
  //     );
  //     if (picked != null) {
  //       setState(() {
  //         _selectedDate = picked;
  //       });

  //       // ارسال تاریخ به صفحه دوم
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => History(
  //             date: _selectedDate,
  //             time: _selectedTime,
  //           ),
  //         ),
  //       );
  //     }
  //   }

  //   DateTime _time = DateTime.now();
  // // show time picker
  //   void _pickTime() async {
  //     TimeOfDay? picked = await showTimePicker(
  //       context: context,
  //       initialTime: _selectedTime,
  //     );
  //     if (picked != null) {
  //       setState(() {
  //         _selectedTime = picked;
  //       });

  //       // ارسال زمان به صفحه دوم
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => History(
  //             time: _selectedTime,
  //             date: _selectedDate,
  //           ),
  //         ),
  //       );
  //     }
  //   }
  File? _image;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'New Visit',
            style: TextStyle(
              color: Color.fromARGB(255, 12, 97, 167),
              fontFamily: 'caveat',
              fontSize: 35,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 96, 98, 112),
                Color.fromARGB(255, 184, 155, 98),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 80),
                // patient
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.person_3_outlined, size: 30),
                      SizedBox(width: 10),
                      Text(
                        'Patient',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ), // خط دور مستطیل
                      borderRadius: BorderRadius.circular(5), // گوشه‌های نرم
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.description_outlined, // آیکن اطلاعات
                              color: Colors.blue,
                            ),
                            SizedBox(width: 10), // فاصله بین آیکن و متن
                            Text(
                              AddPatientPage.famlyController.text,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 10),
                            Text(
                              AddPatientPage.nameController.text,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Text(
                          AddPatientPage.ageController.text,
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                //visit date
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.date_range_outlined, size: 30),
                      SizedBox(width: 10),
                      Text(
                        'Visit Date',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ), // خط دور مستطیل
                      borderRadius: BorderRadius.circular(5), // گوشه‌های نرم
                    ),
                    child: Column(
                      children: [
                        //! Data
                        GestureDetector(
                          onTap: () async {
                            Jalali? pickedDate = await showPersianDatePicker(
                              context: context,
                              initialDate: Jalali.now(),
                              firstDate: Jalali(1400),
                              lastDate: Jalali(1420),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                NewVisit.date =
                                    '${pickedDate.year}/${pickedDate.month}/${pickedDate.day}';
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(width: 10),
                              Text(
                                NewVisit
                                    .date, // _selectedDate.toString().substring(0, 10),
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        //Time
                        GestureDetector(
                          onTap: () async {
                            var timePick = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                            );
                            if (timePick != null) {
                              setState(() {
                                NewVisit.time = timePick.toString().substring(
                                  10,
                                  15,
                                );
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.access_time_rounded),
                              SizedBox(width: 10),
                              Text(
                                NewVisit
                                    .time, // _time.toString().substring(11, 16),
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //reason visit
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.note_alt_outlined, size: 30),
                      SizedBox(width: 10),
                      Text(
                        'Reason of visit',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                //! text field visit
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ), // خط دور مستطیل
                      borderRadius: BorderRadius.circular(5), // گوشه‌های نرم
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          TextField(
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            controller: NewVisit.newHistoryControler,
                            cursorColor: Colors.blue,
                            cursorWidth: 3,
                            showCursor: true,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter text',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 100,
                  height: 180,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('Take Photo'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text('Choose from Gallery'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child:
                        _image != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(_image!, width: 50, height: 50),
                            )
                            : Icon(Icons.add_a_photo_outlined, size: 30),
                  ),
                ),

                //save icon
                IconButton(
                  onPressed: () async {
                    HistoryMedical visit = HistoryMedical(
                      imageVisit:
                          _image?.path, // ذخیره تصویر در فیلد imageVisit
                      id: AddPatientPage.id,
                      historyMedical: NewVisit.newHistoryControler.text,
                      visitDate: NewVisit.date, //_selectedDate.toString(),
                      visitTime: NewVisit.time,
                    ); //_selectedTime.toString()),
                    //  History.historys.add(visit);
                    visitBox.add(visit);
                    MyApp.saveVisit();
                    Navigator.pop(context);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.save_outlined,
                    color: const Color.fromARGB(255, 200, 196, 196),
                    size: 35,
                  ),
                ),
                SizedBox(height: 250),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
