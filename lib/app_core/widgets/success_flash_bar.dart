// ignore_for_file: must_be_immutable

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SuccessFlushBar extends Flushbar {
  final String msg;

  SuccessFlushBar(this.msg, {Key? key}) : super(key: key);

  @override
  String? get message => msg;

  @override
  Duration? get duration => const Duration(seconds: 2, milliseconds: 500);

  @override
  Color get messageColor => Colors.white;
  @override
  double get messageSize => 16;

  @override
  Color? get leftBarIndicatorColor => Colors.green;

  @override
  Widget? get icon => const Icon(
        Icons.info_outline,
        size: 34.0,
        color: Colors.green,
      );

  @override
  EdgeInsets get margin => const EdgeInsets.all(15);

  @override
  EdgeInsets get padding => const EdgeInsets.all(25);
}
