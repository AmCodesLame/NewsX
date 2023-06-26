import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_infinite_list/articles/articles.dart';
import 'package:flutter_infinite_list/articles/bloc/bloc/single_article_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({super.key});

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    getArticle() {
      Hive.openBox<Downloaded>("create");
      final box = Hive.box<Downloaded>("create");
      var articles = box.get("saved");
      return articles?.articles;
    }

    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        var width = MediaQuery.of(context).size.width * 0.96;

        var height = MediaQuery.of(context).size.height;
        switch (state.status) {
          case ArticleStatus.failure:
            final box = Hive.box<Downloaded>("create");
            var articles = box.get("saved")?.articles;

            if (articles != null) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= articles!.length
                      ? const BottomLoader()
                      : BlocProvider(
                          create: (context) => SingleArticleBloc(),
                          child: ArticleListItem(
                              downloadState: state.downloadState,
                              article: articles[index],
                              height: height,
                              width: width),
                        );
                },
                itemCount: articles.length,
                controller: _scrollController,
              );
            }
            return Text("ERROR");

          case ArticleStatus.success:
            if (state.articles.isEmpty) {
              return const Center(child: Text('no articles'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.articles.length
                    ? const BottomLoader()
                    : BlocProvider(
                        create: (context) => SingleArticleBloc(),
                        child: ArticleListItem(
                            downloadState: state.downloadState,
                            article: state.articles[index],
                            height: height,
                            width: width),
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.articles.length
                  : state.articles.length + 1,
              controller: _scrollController,
            );
          case ArticleStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ArticleBloc>().add(ArticleFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
