import 'package:flutter/material.dart';
import 'package:unit_converter_flutter/category.dart';
import 'package:unit_converter_flutter/unit.dart';

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

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  // TODO: Returns a list of mock [Unit]s.
  List<Unit> _retrieveUnitList(String categoryName) {
    return List.generate(4, (int i) {
      i += 1;

      return Unit(
        '$categoryName Unit $i',
        i.toDouble(),
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

//    final backgroundColor = Colors.greenAccent[100];

    // TODO: Create a list view of the Categories
    final listView = Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Theme.of(context).backgroundColor,
      child: _buildCategoryWidgets(categories, MediaQuery.of(context).orientation),
    );

    // TODO: Create an App Bar
    final appBar = AppBar(
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: Colors.deepOrangeAccent,
        displayColor: Colors.lightGreenAccent,
      ),
      title: Text(
        'Unit Converter',
        style: TextStyle(
          color: Theme.of(context).backgroundColor,
          fontSize: Theme.of(context).textTheme.headline.fontSize,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Theme.of(context).primaryColor,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
