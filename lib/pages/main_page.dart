import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lab_2/data/product_repository.dart';
import 'package:lab_2/pages/widgets/product_grid.dart';

import 'developers_page.dart';

class MainPage extends StatelessWidget {
  final String title;

  const MainPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainPage(
      title: title,
      deviceWidth: MediaQuery.of(context).size.width,
    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage({Key? key, required this.title, required this.deviceWidth})
      : super(key: key);

  final String title;
  final double deviceWidth;

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage>
    with SingleTickerProviderStateMixin {
  static final ProductRepository _repository = ProductRepository();
  ConnectivityResult? _connectivityResult;
  final TextEditingController _searchController = TextEditingController();
  late final Timer _connectionTimer;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
    _checkConnectivityState().whenComplete(() {
      if (_connectivityResult != ConnectivityResult.wifi &&
          _connectivityResult != ConnectivityResult.mobile) {
        _connectionTimer =
            Timer.periodic(const Duration(seconds: 3), _timerCallback);
      }
    });
  }

  void _timerCallback(Timer _) async {
    await _checkConnectivityState();
    if (_connectivityResult == ConnectivityResult.wifi ||
        _connectivityResult == ConnectivityResult.mobile) {
      _connectionTimer.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DevelopersPage()),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
        flexibleSpace: SafeArea(
          child: _searchRow(),
        ),
      ),
      body: _body(),
    );
  }

  Widget _searchRow() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5, left: 10),
            hintText: 'Search...',
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.black12,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white38,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 0.5,
              ),
            ),
          ),
          controller: _searchController,
        ),
      ),
    );
  }

  Widget _body() {
    if (_connectivityResult != ConnectivityResult.wifi &&
        _connectivityResult != ConnectivityResult.mobile) {
      return const Center(
        child: Text('Нет соединения'),
      );
    } else {
      return ProductGrid(
          products: _repository.getAllProducts(),
          search: _searchController.text);
    }
  }

  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      log('Connected to a Wi-Fi network');
    } else if (result == ConnectivityResult.mobile) {
      log('Connected to a mobile network');
    } else {
      log('Not connected to any network');
    }
    setState(() {
      _connectivityResult = result;
    });
  }
}
