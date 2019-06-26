import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:unit_converter_flutter/backdrop.dart';

import 'package:unit_converter_flutter/category.dart';
import 'package:unit_converter_flutter/category_tile.dart';

import 'package:unit_converter_flutter/unit.dart';
import 'package:unit_converter_flutter/unit_converter.dart';

import 'package:unit_converter_flutter/api.dart';

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.

final _backgroundColor = Colors.green[100];

class CategoryRoute extends StatefulWidget {
  const CategoryRoute();

  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  /// Key Lists
  Category _defaultCategory;
  Category _currentCategory;
  final _categories = <Category>[];

//  static const _categoryNames = <String>[
//    'Length',
//    'Area',
//    'Volume',
//    'Mass',
//    'Time',
//    'Digital Storage',
//    'Energy',
//    'Currency',
//  ];

//  static const _categoryIcons = <IconData>[
//    Icons.linear_scale,
//    Icons.border_all,
//    Icons.calendar_view_day,
//    Icons.details,
//    Icons.access_time,
//    Icons.storage,
//    Icons.battery_charging_full,
//    Icons.attach_money
//  ];

  static const _categoryIconNames = <String>[
    'assets/icons/length.png',
    'assets/icons/area.png',
    'assets/icons/volume.png',
    'assets/icons/mass.png',
    'assets/icons/time.png',
    'assets/icons/digital_storage.png',
    'assets/icons/power.png',
    'assets/icons/currency.png',
  ];

//  static const _baseColorsPrime = <Color>[
//    Colors.teal,
//    Colors.orange,
//    Colors.pinkAccent,
//    Colors.blueAccent,
//    Colors.yellow,
//    Colors.greenAccent,
//    Colors.purpleAccent,
//    Colors.red,
//  ];

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

  /// Function to call when a [Category] is tapped.
  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });

    print('Inside _onCategoryTap...with ${category.tileName} '
        'with \n_currentCategory = ${_currentCategory.tileName}');
  }

  /// Makes the correct number of rows for the list view.
  ///
  /// For portrait, we construct a [ListView] from the list of category widgets.
//  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
//    return ListView.builder(
//      itemBuilder: (BuildContext context, int index) {
//        return CategoryTile(
//          category: _categories[index],
//          onTap: _onCategoryTap,
//        );
//      },
//      itemCount: _categories.length,
//    );
//  }

  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {

          /// You may want to make the Currency [Category] not tappable
          /// while it is loading, or if there an error.
          var _category = _categories[index];
          return CategoryTile(
            category: _category,
            onTap: _category.tileName == apiCategory['name'] && _category.units.isEmpty
                ? null
                : _onCategoryTap,
          );
        },
        itemCount: _categories.length,
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _categories.map((Category c) {
          return CategoryTile(
            category: c,
            onTap: _onCategoryTap,
          );
        }).toList(),
      );
    }
  }

  ///Remove the overriding of initState(). Instead, we can
  /// wait for our JSON asset to be loaded in (async).
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // We have static unit conversions located in our
    // assets/data/regular_units.json
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
      await _retrieveApiCategory();
    }
  }


  /// Retrieves a list of [Categories] and their [Unit]s
  Future<void> _retrieveLocalCategories() async {
    // Consider omitting the types for local variables. For more details on Effective
    // Dart Usage, see https://www.dartlang.org/guides/language/effective-dart/usage
    final json = DefaultAssetBundle.of(context)
        .loadString('assets/data/regular_units.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Data retrieved from API is not a Map');
    }

    /// Create Categories and their list of Units, from the JSON asset
    var categoryIndex = 0;
    data.keys.forEach((key) {
      final List<Unit> units =
          data[key].map<Unit>((dynamic data) => Unit.fromJSON(data)).toList();

      var category = Category(
        tileName: key,
        units: units,
        tileColor: _baseColors[categoryIndex],
        tileIcon: _categoryIconNames[categoryIndex],
      );
      setState(() {
        if (categoryIndex == 0) {
          _defaultCategory = category;
        }
        _categories.add(category);
      });
      categoryIndex += 1;
    });
  }

  /// Retrieves a [Category] and its [Unit]s from an API on the web
  Future<void> _retrieveApiCategory() async {
    // Add a placeholder while we fetch the Currency category using the API
    setState(() {
      _categories.add(Category(
        tileName: apiCategory['name'],
        units: [],
        tileColor: _baseColors.last,
        tileIcon: _categoryIconNames.last,
      ));
    });
    final api = Api();
    final jsonUnits = await api.getUnits(apiCategory['route']);
    // If the API errors out or we have no internet connection, this category
    // remains in placeholder mode (disabled)
    if (jsonUnits != null) {
      final units = <Unit>[];
      for (var unit in jsonUnits) {
        units.add(Unit.fromJSON(unit));
      }
      setState(() {
        _categories.removeLast();
        _categories.add(Category(
          tileName: apiCategory['name'],
          units: units,
          tileColor: _baseColors.last,
          tileIcon: _categoryIconNames.last,
        ));
      });
    }
  }


//  /// Returns a list of mock [Unit]s.
//  List<Unit> _retrieveUnitList(String categoryName) {
//    return List.generate(5, (int i) {
//      i += 1;
//
//      return Unit(
//        unitName: '$categoryName Unit $i',
//        conversionValue: i.toDouble(),
//      );
//    });
//  }

//  void initState() {
//    super.initState();
//    for (var i = 0; i < _categoryNames.length; i++) {
//      var category = Category(
//        tileName: _categoryNames[i],
//        tileColor: _baseColors[i],
//        tileIcon: _categoryIcons[i],
//        units: _retrieveUnitList(_categoryNames[i]),
//      );
//      if (i == 0) {
//        _defaultCategory = category;
//      }
//      _categories.add(category);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    /// Create a list view of the Categories
    if (_categories.isEmpty) {
      return Center(
        child: Container(
          height: 180.0,
          width: 180.0,
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Based on the device size, figure out how to best lay out the list
    // You can also use MediaQuery.of(context).size to calculate the orientation
    assert(debugCheckHasMediaQuery(context));
    final listViewOfCategories = Padding(
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildCategoryWidgets(MediaQuery.of(context).orientation),
    );

//  Widget build(BuildContext context) {
//    /// Create a list view of the Categories
//    final listViewOfCategories = Container(
//      padding: EdgeInsets.symmetric(horizontal: 32.0),
////      color: _backgroundColor,
//      child: _buildCategoryWidgets(MediaQuery.of(context).orientation),
//    );

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

//    return Scaffold(
//      appBar: appBar,
//      body: listViewOfCategories,
//    );

    return Backdrop(
      currentCategory:
          _currentCategory == null ? _defaultCategory : _currentCategory,
      frontPanel: _currentCategory == null
          ? UnitConverter(category: _defaultCategory)
          : UnitConverter(category: _currentCategory),
      backPanel: listViewOfCategories,
      frontTitle: Padding(
        padding: EdgeInsets.only(
          top: 16.0,
          bottom: 16.0,
        ),
        child: Text(
          'Unit Converter',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline.fontSize,
          ),
        ),
      ),
      backTitle: Padding(
        padding: EdgeInsets.only(
          top: 10.0,
          bottom: 4.0,
        ),
        child: Text(
          'Select a Category',
          style: TextStyle(
            fontSize: 30,
//            fontSize: Theme.of(context).textTheme.display1.fontSize,
          ),
        ),
      ),
    );
  }
}
