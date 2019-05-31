import 'package:flutter/material.dart';
import 'package:unit_converter_flutter/category_route.dart';

void main() => runApp(UnitConverterApp());

class UnitConverterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.purple,
        secondaryHeaderColor: Colors.deepOrange,
        backgroundColor: Colors.white,

        fontFamily: 'Roboto',
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.purple,
          displayColor: Colors.purpleAccent,
        ),

      ),

      title: 'Unit Converter',
      home: CategoryRoute(),
    );
  }
}

