import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/articles/bloc/article_bloc.dart';
import 'package:flutter_infinite_list/articles/view/aritcles_page.dart';
import 'package:http/http.dart' as http;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ArticlesPage());
  }
}

// class App extends MaterialApp {
//   const App({super.key}) : super(home: const ArticlesPage());
// }

// MultiBlocProvider(
//         providers: [
//           BlocProvider(
//               create: (context) =>
//                   ArticleBloc(httpClient: http.Client())..add(ArticleFetched()))
//         ],
