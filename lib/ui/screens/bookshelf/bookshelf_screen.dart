import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';


@RoutePage()
class BookshelfScreen extends StatelessWidget {
  const BookshelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bookshelf"),),
      body: Center(
        child: Text("Bookshelf Screen"),
      ),
    );
  }
}
