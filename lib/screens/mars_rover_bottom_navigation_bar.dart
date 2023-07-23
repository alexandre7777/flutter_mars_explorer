import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

marsRoverBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.conveyor_belt),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.save),
          label: 'Saved',
        ),
      ],
      onTap: (int index) => {
            if (index == 0) {context.go('/')} else {context.go('/saved')}
          },
      currentIndex: ModalRoute.of(context)?.settings.name == 'saved' ? 1 : 0);
}