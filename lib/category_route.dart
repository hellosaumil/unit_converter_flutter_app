import 'package:flutter/material.dart';

import 'package:unit_converter_flutter/category.dart';
import 'package:unit_converter_flutter/unit.dart';

final _backgroundColor = Colors.green[100];

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  State<StatefulWidget> createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  /// Key Lists
  final categories = <Category>[];

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _categoryIcons = <IconData>[
    Icons.linear_scale,
    Icons.border_all,
    Icons.calendar_view_day,
    Icons.details,
    Icons.access_time,
    Icons.storage,
    Icons.battery_charging_full,
    Icons.attach_money
  ];

  static const _baseColorsPrime = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];

  // TODO: Returns a list of mock [Unit]s.
  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(5, (int i) {
      i += 1;

      return Unit(
        unitName: '$categoryName Unit $i',
        conversionValue: i.toDouble(),
      );
    });
  }

  /// Makes the correct number of rows for the list view.
  ///
  /// For portrait, we construct a [ListView] from the list of category widgets.
  Widget _buildCategoryWidgets(
      List<Widget> categories, Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) => categories[index],
        itemCount: categories.length,
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: categories,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // TODO: Append Category data to categories
    for (var i = 0; i < _categoryNames.length; i++) {
      print(_categoryNames[i]);
      categories.add(Category(
        tileName: _categoryNames[i],
        tileIcon: _categoryIcons[i],
        tileColor: _baseColors[i],
        units: _retrieveUnitList(_categoryNames[i]),
      ));
    }
  }

  // TODO: implement build
  @override
  Widget build(BuildContext context) {
    // TODO: Create a list view of the Categories
    final listViewOfCategories = Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: _backgroundColor,
      child:
          _buildCategoryWidgets(categories, MediaQuery.of(context).orientation),
    );

    // TODO: Create an App Bar
    final appBar = AppBar(
      title: Text(
        'Unit Converter',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.display1.fontSize,
        ),
      ),
      backgroundColor: _backgroundColor,
      centerTitle: true,
      elevation: 10.0,
    );

    return Scaffold(
      appBar: appBar,
      body: listViewOfCategories,
    );
  }
}
