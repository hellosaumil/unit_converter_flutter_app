import 'package:flutter/material.dart';

import 'package:unit_converter_flutter/unit.dart';

class ConverterRoute extends StatefulWidget {
  final String categoryName;
  final Color categoryColor;
  final List<Unit> units;

  const ConverterRoute(this.units, this.categoryName, this.categoryColor)
      : assert(units != null),
        assert(categoryName != null),
        assert(categoryColor != null);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ConverterRouteState();
  }
}

class _ConverterRouteState extends State<ConverterRoute> {

  @override
  Widget build(BuildContext context) {
    final unitWidgets = widget.units.map((Unit unit) {
      return Container(
        color: widget.categoryColor,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.unitName,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline.fontSize,
                color: Theme.of(context).backgroundColor,
              ),
            ),
            Text(
              'Conversion: ${unit.conversionValue}',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.subhead.fontSize,
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ],
        ),
      );
    }).toList();

    return ListView(
        children: unitWidgets,
    );
  }
}
