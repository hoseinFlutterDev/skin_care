import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_care/screen/class/specification.dart';

import 'class/historymedical.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({super.key});
  static TextEditingController nameController = TextEditingController();
  static TextEditingController famlyController = TextEditingController();
  static TextEditingController numberController = TextEditingController();
  static TextEditingController addressControler = TextEditingController();
  static TextEditingController historyControler = TextEditingController();

  static TextEditingController nationController = TextEditingController();

  static TextEditingController ageController = TextEditingController();

  static bool isEditing = false;
  static int id = 0;

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  // void _savePatient() {
  //   if (_nameController.text.isNotEmpty && _ageController.text.isNotEmpty) {
  //     Navigator.pop(context, {
  //       'name': _nameController.text,
  //       'age': _ageController.text,
  //       'famely': _famlyController,
  //       'nation': _nationController,
  //       'phone': _numberController,
  //       'image': 'assets/default.png',
  //     });
  //   }
  // }static TextEditingController nameController = TextEditingController();

  // فایل عکس انتخاب‌شده
  // ignore: unused_field
  File? _image;

  /// متد انتخاب عکس از گالری
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _famlyController.dispose();
  //   _nationController.dispose();
  //   _ageController.dispose();
  //   _numberController.dispose();
  //   super.dispose();
  // }
  Box<Specification> hiveBox = Hive.box('mybox');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // شفاف کردن اپ بار
        extendBodyBehindAppBar: true,
        //اپ بار
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          title: const Text(
            'Skin Care',
            style: TextStyle(
              fontFamily: 'Caveat',
              fontSize: 40,
              color: Color.fromARGB(255, 12, 97, 167),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 96, 98, 112),
                Color.fromARGB(255, 184, 155, 98),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 200),
              child: Center(
                child: Dialog(
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                  insetPadding: EdgeInsets.all(15),
                  child: AlertDialog(
                    title: Text(
                      AddPatientPage.isEditing ? 'Edit' : ' Add',
                      textAlign: TextAlign.center,
                    ),
                    //
                    actions: [
                      //name textField
                      TextField(
                        keyboardType: TextInputType.name,
                        controller: AddPatientPage.nameController,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(hintText: 'Name'),
                      ),
                      //Family textField
                      TextField(
                        keyboardType: TextInputType.name,
                        controller: AddPatientPage.famlyController,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(hintText: 'Family'),
                      ),
                      //Id textField
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: AddPatientPage.nationController,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(hintText: 'ID'),
                      ),
                      //age and phone textField
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: AddPatientPage.ageController,
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(hintText: 'Age'),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: AddPatientPage.numberController,
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(hintText: 'Phone'),
                            ),
                          ),
                        ],
                      ),
                      // در اینجا به جای ذخیره فقط یک تصویر، باید لیست تصاویر رو ذخیره کنی
                      SizedBox(
                        width: 100,
                        height: 100,
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
                                    child: Image.file(
                                      _image!,
                                      width: 50,
                                      height: 50,
                                    ),
                                  )
                                  : Icon(Icons.add_a_photo_outlined, size: 30),
                        ),
                      ),
                      // اضافه کردن
                      IntrinsicHeight(
                        child: TextField(
                          minLines: 1,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          controller: AddPatientPage.addressControler,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(hintText: 'Address'),
                        ),
                      ),
                      IntrinsicHeight(
                        child: TextField(
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          controller: AddPatientPage.historyControler,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            hintText: 'History Patient',
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            // باز کردن باکس‌ها
                            var hiveBox = await Hive.box<Specification>(
                              'mybox',
                            );
                            var historyBox = await Hive.box<HistoryMedical>(
                              'historymedicalbox',
                            );

                            // ایجاد یک آیتم جدید برای HistoryMedical

                            // ذخیره آیتم در HiveBox

                            // ایجاد HiveList و اضافه کردن آیتم به آن
                            HiveList<HistoryMedical> visits = HiveList(
                              historyBox,
                            );

                            // ایجاد آیتم جدید برای Specification
                            Specification item = Specification(
                              futureAppointment: null,
                              address: AddPatientPage.addressControler.text,
                              history: AddPatientPage.historyControler.text,
                              imagePath: _image?.path,
                              imagePaths: _image != null ? [_image!.path] : [],
                              id: Random().nextInt(999),
                              name: AddPatientPage.nameController.text,
                              famely: AddPatientPage.famlyController.text,
                              nation: AddPatientPage.nationController.text,
                              number: AddPatientPage.numberController.text,
                              age: AddPatientPage.ageController.text,
                              visits: visits,
                            );

                            if (AddPatientPage.isEditing) {
                              // ویرایش آیتم
                              hiveBox.put(AddPatientPage.id, item);
                            } else {
                              // افزودن آیتم جدید
                              hiveBox.add(item);
                            }

                            // به‌روزرسانی state (اگر لازم است)
                            setState(() {
                              // به‌روزرسانی state در اینجا
                            });

                            // بستن صفحه بعد از تکمیل عملیات
                            Navigator.pop(context);
                          },
                          child: Text(
                            AddPatientPage.isEditing ? 'Edit' : ' Save',
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
      ),
    );
  }
}
