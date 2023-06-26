import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_infinite_list/app.dart';
import 'package:flutter_infinite_list/articles/articles.dart';
import 'package:flutter_infinite_list/simple_bloc_observer.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(DownloadedAdapter());
  await Hive.openBox<Downloaded>("create");

  // Hive.openBox<Downloaded>("downlaods");

  Bloc.observer = const SimpleBlocObserver();
  runApp(const App());
}
