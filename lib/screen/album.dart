import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skin_care/screen/home_page.dart';

class PatientAlbumPage extends StatefulWidget {
  final int patientIndex; // ایندکس بیمار که تصاویر او رو میخوایم نمایش بدیم

  const PatientAlbumPage({super.key, required this.patientIndex});

  @override
  State<PatientAlbumPage> createState() => _PatientAlbumPageState();
}

class _PatientAlbumPageState extends State<PatientAlbumPage> {
  @override
  Widget build(BuildContext context) {
    // چک کردن اینکه بیماران و تصاویر درست هستند
    final patient =
        HomePage.patients.isNotEmpty
            ? HomePage.patients[widget.patientIndex]
            : null; // اطمینان از وجود بیمار
    final images =
        patient?.imagePaths ?? []; // استفاده از لیست خالی در صورت نبود تصاویر

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 33, 79, 243),
              const Color.fromARGB(255, 233, 176, 30),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: images.length, // تعداد تصاویر از لیست گرفته می‌شود
          itemBuilder:
              (context, index) => Container(
                margin: EdgeInsets.all(8.0), // اضافه کردن فاصله بین تصاویر
                child: CircleAvatar(
                  radius: 180,
                  backgroundColor: Colors.transparent,
                  child:
                      images[index].isNotEmpty
                          ? Image.file(File(images[index]), fit: BoxFit.cover)
                          : Image.asset(
                            'assets/images/sun.jpg',
                            fit: BoxFit.cover,
                          ), // عکس پیشفرض
                ),
              ),
        ),
      ),
    );
  }
}
