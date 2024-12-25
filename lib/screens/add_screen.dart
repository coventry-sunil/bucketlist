// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddBucketList extends StatefulWidget {
  final int index;
  const AddBucketList({super.key, required this.index});

  @override
  State<AddBucketList> createState() => _AddBucketListState();
}

class _AddBucketListState extends State<AddBucketList> {
  TextEditingController itemText = TextEditingController();
  TextEditingController costText = TextEditingController();
  TextEditingController imageURLText = TextEditingController();

  Future<void> addBucketData() async {
    try {
      Map<String, dynamic> newData = {
        "item": itemText.text,
        "cost": costText.text,
        "image": imageURLText.text,
        "completed": false
      };

      await Dio().patch(
          "https://flutterapitest321-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json",
          data: newData);
      Navigator.pop(context, "refresh");
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    var addForm = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Bucket List"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: addForm,
            child: Column(children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.toString().length < 3) {
                    return "Must be more than 3 characters";
                  }
                  if (value == null || value.isEmpty) {
                    return "This field is required and must not be empty.";
                  } else {
                    return null;
                  }
                },
                controller: itemText,
                decoration: InputDecoration(label: Text("Item")),
              ),
              SizedBox(height: 30),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required and must not be empty.";
                  } else {
                    return null;
                  }
                },
                controller: costText,
                decoration: InputDecoration(label: Text("Estimated Cost")),
              ),
              SizedBox(height: 30),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required and must not be empty.";
                  } else {
                    return null;
                  }
                },
                controller: imageURLText,
                decoration: InputDecoration(label: Text("Image URL")),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (addForm.currentState!.validate()) {
                              addBucketData();
                            }
                          },
                          child: Text("Add Item"))),
                ],
              )
            ]),
          ),
        )

        // ElevatedButton(onPressed: addBucketData, child: Text("Add Data")),
        );
  }
}
