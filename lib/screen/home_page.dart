// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_super_parameters, unnecessary_set_literal
import 'dart:io';

import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skin_care/main.dart';
import 'package:skin_care/screen/add_screen.dart';
import 'package:skin_care/screen/class/specification.dart';
import 'package:skin_care/screen/user_detail_page.dart';

class HomePage extends StatefulWidget {
  // ignore: duplicate_ignore
  // ignore: use_super_parameters
  const HomePage({Key? key}) : super(key: key);
  static List<Specification> patients = [];
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late FancyDrawerController _controller;
  Box<Specification> hiveBox = Hive.box('mybox');

  @override
  void initState() {
    MyApp.getData();
    super.initState();
    _controller = FancyDrawerController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // List<Map<String, String>> patients = []; // لیست بیماران

  // static List<specifatoin> patients = [
  //   specifatoin(
  //       id: 0,
  //       name: 'ali',
  //       famely: 'mahdi',
  //       Nation: '4380103501',
  //       number: '0919942996',
  //       age: '35'),
  //   specifatoin(
  //       id: 0,
  //       name: 'ali',
  //       famely: 'mahdi',
  //       Nation: '4380103501',
  //       number: '0919942996',
  //       age: '35'),
  // ];
  // void _addPatient(newPatient) {
  //   setState(() {
  //     patients.add(newPatient);
  //   });
  // }
  // String searchTex = '';
  // AnimatedSearchBar _search() {
  //   return AnimatedSearchBar(
  //     label: "Search Something Here",
  //     onChanged: (value) {
  //       debugPrint("value on Change");
  //       setState(() {
  //         searchTex = value;
  //       });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 33, 79, 243),
                  const Color.fromARGB(255, 233, 176, 30),
                ],
              ),
            ),
            //drawer
            child: FancyDrawerWrapper(
              backgroundColor: Colors.transparent,
              controller: _controller,
              drawerItems: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: const Color.fromARGB(255, 240, 236, 236),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Go to home",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 231, 228, 233),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AddPatientPage.nameController.text = '';
                    AddPatientPage.famlyController.text = '';
                    AddPatientPage.nationController.text = '';
                    AddPatientPage.numberController.text = '';
                    AddPatientPage.ageController.text = '';
                    AddPatientPage.addressControler.text = '';
                    AddPatientPage.historyControler.text = '';
                    AddPatientPage.isEditing = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPatientPage()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_add_alt_outlined,
                        color: const Color.fromARGB(255, 240, 236, 236),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 216, 213, 217),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(Icons.input, color: Colors.white),
                      SizedBox(width: 15),
                      Text(
                        "Export Date",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 210, 206, 212),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: const Color.fromARGB(255, 240, 236, 236),
                      ),
                      SizedBox(width: 15),
                      Text(
                        "Log out",
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 210, 206, 212),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              child: Scaffold(
                extendBodyBehindAppBar: true,
                // اپ بار
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
                  leading: IconButton(
                    icon: Icon(Icons.menu, color: Colors.black),
                    onPressed: () {
                      _controller.toggle();
                    },
                  ),
                  actions: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: AnimatedSearchBar(
                        onClose: () {
                          MyApp.getData();
                          setState(() {});
                        },
                        duration: Duration(seconds: 1),
                        onFieldSubmitted: (String text) {
                          //درست کردن جستجو
                          List<Specification> result =
                              hiveBox.values
                                  .where(
                                    (value) =>
                                        value.name.contains(text) ||
                                        value.nation.contains(text),
                                  )
                                  .toList();
                          HomePage.patients.clear();
                          setState(() {
                            result.forEach(
                              (value) => {HomePage.patients.add(value)},
                            );
                          });
                        },
                        searchDecoration: InputDecoration(
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.blue, // رنگ مرز به صورت پیش‌فرض
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.green, // رنگ مرز هنگام تمرکز
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.red, // رنگ مرز هنگام خطا
                            ),
                          ),
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,

                          // رنگ پس‌زمینه زمانی که فیلد فعال نیست
                        ),
                      ),
                    ),
                  ],
                ),
                // بک گراند پاستیلی
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
                  // ساخت لیست بیلدر برای اضافه کردن
                  child: ListView.builder(
                    itemCount: HomePage.patients.length,
                    itemBuilder: (context, index) {
                      return Expanded(
                        child: GestureDetector(
                          // delete
                          onLongPress: () {
                            setState(() {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text(
                                        'Are You Sure Delet This item ?',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                hiveBox.deleteAt(index);
                                                MyApp.getData();
                                                setState(() {});

                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes'),
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
                          //* Edit
                          onTap: () {
                            AddPatientPage.nameController.text =
                                HomePage.patients[index].name;
                            AddPatientPage.famlyController.text =
                                HomePage.patients[index].famely;
                            AddPatientPage.nationController.text =
                                HomePage.patients[index].nation;
                            AddPatientPage.numberController.text =
                                HomePage.patients[index].number;
                            AddPatientPage.ageController.text =
                                HomePage.patients[index].age;
                            AddPatientPage.addressControler.text =
                                HomePage.patients[index].address;
                            AddPatientPage.historyControler.text =
                                HomePage.patients[index].history;
                            AddPatientPage.isEditing = true;
                            AddPatientPage.id = index;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetailPage(),
                              ),
                            ).then((value) {
                              MyApp.getData();
                              setState(() {});
                            });
                          },
                          child: Detile(index: index),
                        ),
                      );
                    },
                  ),
                ),
                //Add new Patient
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    AddPatientPage.nameController.text = '';
                    AddPatientPage.famlyController.text = '';
                    AddPatientPage.nationController.text = '';
                    AddPatientPage.numberController.text = '';
                    AddPatientPage.ageController.text = '';
                    AddPatientPage.addressControler.text = '';
                    AddPatientPage.historyControler.text = '';
                    AddPatientPage.isEditing = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPatientPage()),
                    ).then((value) {
                      MyApp.getData();
                      setState(() {});
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: duplicate_ignore
// ignore: must_be_immutable مشخصات کارت

class Detile extends StatelessWidget {
  int index;
  Detile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      // رفن به صفحه جزییات
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white10,
        ),

        //اضافه کردن کارت
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '',
                      //  HomePage.patients[index].number,
                      //  style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 15),
                    Text(
                      '',

                      ///        HomePage.patients[index].nation,
                      //       style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    HomePage.patients[index].name,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 22),
                  Text(
                    HomePage.patients[index].famely,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    HomePage.patients[index].imagePath != null &&
                            HomePage.patients[index].imagePath!.isNotEmpty
                        ? FileImage(File(HomePage.patients[index].imagePath!))
                            as ImageProvider
                        : AssetImage('assets/images/sun.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
