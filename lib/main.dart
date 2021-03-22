import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/image_detail.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APOD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<ImageDetail>(
        create: (context) => ImageDetail(),
        child: Home(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
