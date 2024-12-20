import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void getData() async {
    //get data from API
    Response response = await Dio().get(
        "https://flutterapitest321-default-rtdb.firebaseio.com/bucketlist.json");
    print(response.statusCode);
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bucket List"),
      ),
      body: ElevatedButton(onPressed: getData, child: Text("Get Data")),
    );
  }
}
