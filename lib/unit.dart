import 'package:meta/meta.dart';

class Unit {
  final String unitName;
  final double conversionValue;

  const Unit({@required this.unitName, @required this.conversionValue})
      : assert(unitName != null),
        assert(conversionValue != null);

  // TODO - Create Unit object from a JSON object
  Unit.fromJSON(Map jsonMap)
      : assert(jsonMap['unitName'] != null),
        assert(jsonMap['conversionValue'] != null),
        unitName = jsonMap['unitName'],
        conversionValue = jsonMap['conversionValue'].toDouble();
}
