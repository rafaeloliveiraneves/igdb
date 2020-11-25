import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/55695910/testing-in-flutter-gives-error-mediaquery-of-called-with-a-context-that-does-n?rq=1
Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}
