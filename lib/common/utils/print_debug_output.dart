import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class DebugPrintConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final element in event.lines) {
      debugPrint(element);
    }
  }
}
