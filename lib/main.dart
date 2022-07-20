import 'package:flutter/material.dart';
import 'package:new_flutter_app/core/store.dart';
import 'package:new_flutter_app/pages/Homepage.dart';
import 'package:new_flutter_app/pages/cart_page.dart';
import 'package:new_flutter_app/pages/login_page.dart';
import 'package:new_flutter_app/utils/routes.dart';
import 'package:new_flutter_app/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(
    VxState(
      store: MyStore(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: MyTheme.darkTheme(context),
      theme: MyTheme.lightTheme(context),
      initialRoute: MyRoutes.loginRoute,
      routes: {
        //"/": (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => const Homepage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.cartRoute: (context) => const CartPage(),
      },
    );
  }
}

class Mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: LoginPage(),
      );
}
