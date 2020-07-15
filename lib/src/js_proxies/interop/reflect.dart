@JS()
library reflect;

import 'package:js/js.dart';

@JS('Reflect')
class Reflect {
  external static void deleteProperty(dynamic object, dynamic property);
}
