import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter_flutter/unit_converter.dart';
import 'package:unit_converter_flutter/unit.dart';

import 'category.dart';

final _tileHeight = 100.0;
final _borderRadius = BorderRadius.circular(_tileHeight / 2);

/// A [CategoryTile] to display a [Category].
/// The [CategoryTile] shows the name and color of a [Category] for unit
/// conversions.
///
/// Tapping on it brings you to the unit converter.
class CategoryTile extends StatelessWidget {
  final Category category;
  /// You may want to pass in a null onTap when the Currency [Category]
  /// is in a loading or error state. In build(), you'll want to update the UI
  /// accordingly.
  final ValueChanged<Category> onTap;

  const CategoryTile({Key key, @required this.category, this.onTap})
      : assert(category != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _tileHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          splashColor: category.tileColor["splash"],
          highlightColor: category.tileColor["highlight"],
//          onTap: () => _naviageToConverter(context),
          onTap: () => onTap(category),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 20.0, 10.0),
                child: Image.asset(
                  category.tileIcon,
                  width: 50,
                  height: 50,
                ),

//                child: Icon(
//                  this.category.tileIcon,
//                  size: 50.0,
//                ),
              ),
              Center(
                  child: Text(
                this.category.tileName,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _naviageToConverter(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1.0,
              title: Text(
                this.category.tileName,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.display1.fontSize,
                ),
              ),
              centerTitle: true,
              backgroundColor: this.category.tileColor,
            ),
            body: UnitConverter(category: this.category),
            resizeToAvoidBottomPadding: false,
          );
        },
      ),
    );
  }
}

ListView sampleListView() {
  return ListView(
    children: const <Widget>[
      Card(child: ListTile(title: Text('One-line ListTile'))),
      Card(
        child: ListTile(
          leading: FlutterLogo(),
          title: Text('One-line with leading widget'),
        ),
      ),
      Card(
        child: ListTile(
          title: Text('One-line with trailing widget'),
          trailing: Icon(Icons.more_vert),
        ),
      ),
      Card(
        child: ListTile(
          leading: FlutterLogo(),
          title: Text('One-line with both widgets'),
          trailing: Icon(Icons.more_vert),
        ),
      ),
      Card(
        child: ListTile(
          title: Text('One-line dense ListTile'),
          dense: true,
        ),
      ),
      Card(
        child: ListTile(
          leading: FlutterLogo(size: 56.0),
          title: Text('Two-line ListTile'),
          subtitle: Text('Here is a second line'),
          trailing: Icon(Icons.more_vert),
        ),
      ),
      Card(
        child: ListTile(
          leading: FlutterLogo(size: 72.0),
          title: Text('Three-line ListTile'),
          subtitle: Text('A sufficiently long subtitle warrants three lines.'),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
        ),
      ),
    ],
  );
}
