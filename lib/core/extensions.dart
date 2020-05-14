import 'package:intl/intl.dart';

extension IntExtention on int {
  String get compact {
    var f = NumberFormat.compact();
    return f.format(this);
  }

  String get format {
    var f = NumberFormat.decimalPattern();
    return f.format(this);
  }
}
