import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/articles/view/aritcles_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: const ArticlesPage());
  }
}

// class App extends MaterialApp {
//   const App({super.key}) : super(home: const ArticlesPage());
// }
