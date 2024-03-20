import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tablet/App.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(
    255, 80, 59, 138));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then((fn) {
    runApp(
      MaterialApp(
        theme: ThemeData.light().copyWith(
            colorScheme: kColorScheme
        ),
        home: const App(),
      ),
    );
  });
}
