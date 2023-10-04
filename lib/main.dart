import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/bindings/authBinding.dart';
import 'firebase_options.dart';
import 'utils/colors.dart';
import 'utils/root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print("-" * 34);
    // print(Icons.accessibility_rounded.codePoint);
    // print("-" * 34);
    return GetMaterialApp(
      enableLog: false,
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      home: Root(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: corPrimaria,
        indicatorColor: corPrimaria,
        primaryColorLight: corPrimariaClara,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: corPrimariaClara,
          selectionColor: corPrimariaClara,
          selectionHandleColor: corPrimariaClara,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: corPrimariaClara),
      ),
    );
  }
}
