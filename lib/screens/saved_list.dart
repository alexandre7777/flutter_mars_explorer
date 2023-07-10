import 'package:flutter/material.dart';

import 'mars_rover_bottom_navigation_bar.dart';

class SavedList extends StatefulWidget {
  static const routeName = '/';

  const SavedList({super.key, required this.title});

  final String title;

  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Text("saved"),
      bottomNavigationBar: marsRoverBottomNavigationBar(context),
    );
  }
}
