import 'package:flutter/material.dart';

import 'package:flutter_leaning/views/learning.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // darkTheme: themeData(ThemeConfig.darkTheme),
      home: Learning(),
    );
  }
}
