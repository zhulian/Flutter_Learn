import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_leaning/util/bookmarkModel.dart';
import 'package:flutter_leaning/util/learningModel.dart';

import 'package:flutter_leaning/app.dart';

void main() async {
  final locator = GetIt.instance;

  locator.registerSingleton<BookmarkModel>(BookmarkModel());
  locator.registerSingleton<LearningModel>(LearningModel());
  runApp(MyApp());
}
