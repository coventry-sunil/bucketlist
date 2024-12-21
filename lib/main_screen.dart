import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketlistData = [];

  void getData() async {
    //get data from API
    try {
      Response response = await Dio().get(
          "https://flutterapitest321-default-rtdb.firebaseio.com/bucketlist.json");
      bucketlistData = response.data;
      setState(() {});
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text(
                    "Connection to the server error! Please try again later"));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bucket List"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: getData, child: Text("Get Data")),
          Expanded(
            child: ListView.builder(
                itemCount: bucketlistData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(bucketlistData[index]['image'] ?? ""),
                      ),
                      title: Text(bucketlistData[index]['item'] ?? ""),
                      trailing:
                          Text(bucketlistData[index]['cost'].toString() ?? ""),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
