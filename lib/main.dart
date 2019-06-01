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
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.grey[600],
        ),
        // This colors the [InputOutlineBorder] when it is selected
        primaryColor: Colors.grey[500],
        textSelectionHandleColor: Colors.green[500],
      ),
      title: 'Unit Converter',
      home: CategoryRoute(),
    );
  }
}

