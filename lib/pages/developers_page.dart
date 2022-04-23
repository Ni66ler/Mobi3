import 'package:flutter/material.dart';

class DevelopersPage extends StatelessWidget {
  const DevelopersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Developer\'s page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Лабораторная номер 2',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Костян Владислав',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 5),
            Image.asset(
              'assets/images/profile.jpg',
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'группа 951008',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
