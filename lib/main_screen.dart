import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketlistData = [];
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    //get data from API
    try {
      Response response = await Dio().get(
          "https://flutterapitest321-default-rtdb.firebaseio.com/bucketlist.json");
      bucketlistData = response.data;
      isLoading = false;
      setState(() {});
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bucket List"),
        actions: [
          InkWell(
              onTap: getData,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.refresh),
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
        },
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
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
      ),
    );
  }
}
