import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'data/remote_data_source.dart';
import 'pages/main_page.dart';

late final String userID;

void main() => initApp().whenComplete(() => runApp(const MyApp()));

Future<void> initApp() async {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(
        title: 'shop',
      ),
    );
  }
}
