import 'package:flutter/material.dart';

import 'src/screens/home_page.dart';

void main() {
  runApp(
    new Home(),
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
