import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_infinite_list/articles/articles.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: BlocProvider(
        create: (_) =>
            ArticleBloc(httpClient: http.Client())..add(ArticleFetched()),
        child: const ArticlesList(),
      ),
    );
  }
}
