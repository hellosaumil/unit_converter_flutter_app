import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:unit_converter_flutter/unit.dart';

class Category {
  final String tileName;
  final IconData tileIcon;
  final ColorSwatch tileColor;
  final List<Unit> units;

  // Creates a [Category].
  //
  // A [Category] saves the name of the Category (e.g. 'Length'), its color for
  // the UI, and the icon that represents it (e.g. a ruler).
  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.

  const Category({
    @required this.tileName,
    @required this.tileIcon,
    @required this.tileColor,
    @required this.units,
  })  : assert(tileName != null),
        assert(tileIcon != null),
        assert(tileColor != null),
        assert(units != null);
}
