import 'package:flutter/material.dart';
import 'home/user_list.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'User List',
      home: UserList(),
    );
  }
}
