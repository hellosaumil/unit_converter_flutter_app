import 'package:meta/meta.dart';

class Unit {
  final String unitName;
  final double conversionValue;

  const Unit({@required this.unitName, @required this.conversionValue})
      : assert(unitName != null),
        assert(conversionValue != null);

  /// Create Unit object from a JSON object
  Unit.fromJSON(Map jsonMap)
      : assert(jsonMap['name'] != null),
        assert(jsonMap['conversion'] != null),
        unitName = jsonMap['name'],
        conversionValue = jsonMap['conversion'].toDouble();
}
