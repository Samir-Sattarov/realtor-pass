import 'package:easy_localization/easy_localization.dart';

class NumberHelper {

  static format(num value ) {
return    NumberFormat.decimalPattern().format(value);
  }
}