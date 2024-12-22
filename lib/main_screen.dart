import 'package:bucketlist/add_bucket_list.dart';
import 'package:bucketlist/view_item.dart';
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
  bool isError = false;

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
      isError = false;
      setState(() {});
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //           title: Text(
      //               "Connection to the server error! Please try again later"));
      //     });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget errorWidget({required String errorMessage}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text(errorMessage),
          ElevatedButton(onPressed: getData, child: Text("Try Again"))
        ],
      ),
    );
  }

  Widget listViewWidget() {
    return ListView.builder(
        itemCount: bucketlistData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewItem(
                    title: bucketlistData[index]['item'] ?? "",
                    image: bucketlistData[index]['image'] ?? "",
                  );
                }));
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundImage:
                    NetworkImage(bucketlistData[index]['image'] ?? ""),
              ),
              title: Text(bucketlistData[index]['item'] ?? ""),
              trailing: Text(bucketlistData[index]['cost'].toString()),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, "/add");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddBucketList();
          }));
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
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
            : isError
                ? errorWidget(errorMessage: "Error establishing connection...")
                : listViewWidget(),
      ),
    );
  }
}
