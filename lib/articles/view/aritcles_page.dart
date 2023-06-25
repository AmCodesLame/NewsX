import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_infinite_list/articles/articles.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'X-News',
          style: TextStyle(fontSize: 40),
        ),
        backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      ),
      body: BlocProvider(
        create: (_) =>
            ArticleBloc(httpClient: http.Client())..add(ArticleFetched()),
        child: Container(
            padding: EdgeInsets.only(top: 10),
            decoration:
                BoxDecoration(color: const Color.fromRGBO(37, 37, 37, 1)),
            child: const ArticlesList()),
      ),
    );
  }
}
