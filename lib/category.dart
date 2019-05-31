import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter_flutter/converter_route.dart';
import 'package:unit_converter_flutter/unit.dart';

final _tileHeight = 100.0;
final _borderRadius = BorderRadius.circular(_tileHeight / 2);

class Category extends StatelessWidget {
  final String tileName;
  final IconData tileIcon;
  final Color tileColor;
  final List<Unit> units;

  // Creates a [Category].
  //
  // A [Category] saves the name of the Category (e.g. 'Length'), its color for
  // the UI, and the icon that represents it (e.g. a ruler).
  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.

  const Category({
    Key key,
    @required this.tileName,
    @required this.tileIcon,
    @required this.tileColor,
    @required this.units,
  })  : assert(tileName != null),
        assert(tileIcon != null),
        assert(tileColor != null),
        assert(units!= null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _tileHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          splashColor: this.tileColor,
          highlightColor: this.tileColor,

          onTap: () => _naviageToConverter(context),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  this.tileIcon,
                  size: 60.0,
                ),
              ),
              Center(
                  child: Text(
                    this.tileName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _naviageToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                tileName,
                style: Theme.of(context).textTheme.headline,
              ),
              centerTitle: true,
              backgroundColor: tileColor,
            ),
            body: ConverterRoute(units, tileName, tileColor),
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