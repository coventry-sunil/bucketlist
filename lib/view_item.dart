import 'package:flutter/material.dart';

class ViewItem extends StatefulWidget {
  String title;
  String image;
  ViewItem({super.key, required this.title, required this.image});

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(widget.image))),
      ),
    );
  }
}
