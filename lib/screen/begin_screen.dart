import 'package:flutter/material.dart';
import 'home_page.dart';

class BeginScreen extends StatelessWidget {
  const BeginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            // تنظیم پس زمینه با گرادینت
            decoration: BoxDecoration(
              gradient: LinearGradient(
                // آرایه‌ای از رنگ‌ها
                colors: [
                  const Color.fromARGB(255, 96, 98, 112),
                  const Color.fromARGB(255, 184, 155, 98)
                ],
                // جهت شروع گرادینت
                begin: Alignment.topLeft,
                // جهت پایان گرادینت
                end: Alignment.bottomRight,
              ),
            ),
            // محتوای داخل Container
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 0,
                ),
                CircleAvatar(
                  radius: 180,
                  backgroundImage: AssetImage('images/1.webp'),
                ),
                Text(
                  'Atosa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'pacifico'),
                ),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    },
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
                      },
                      child: Text(
                        'W E L C O M E',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
// مثال: تعریف چند رنگ پاستیلی

class PastelColors {
  static const Color pastelBlue = Color(0xFFAEC6CF); // آبی پاستیلی
  static const Color pastelPink = Color(0xFFFFB7C5); // صورتی پاستیلی
  static const Color pastelGreen = Color(0xFF77DD77); // سبز پاستیلی
  static const Color pastelYellow = Color(0xFFFFF5BA); // زرد پاستیلی
}
