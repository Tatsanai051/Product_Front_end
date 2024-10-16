import 'package:flutter/material.dart';
import 'package:flutter_lab1/pages/userpage.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'package:flutter_lab1/pages/adminpage.dart';
import 'package:flutter_lab1/pages/addpage.dart';
import 'package:flutter_lab1/providers/user_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Flutter Auth Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: const Color.fromARGB(255, 126, 246, 150),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(),
          ),
        ),
        home: const LoginPage(),
        routes: {
          '/homeadmin': (context) => WelcomePage(),
          '/homeuser': (context) => UserWelcomePage(),
          '/addproduct': (context) => AddPage(),
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}
