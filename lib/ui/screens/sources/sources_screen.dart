import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SourcesScreen extends StatelessWidget {
  const SourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Quản lý nguồn"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.ellipsis_vertical),
          ),
        ],
      ),
      body: Center(child: Text("Bản cập nhật")),
    );
  }
}
