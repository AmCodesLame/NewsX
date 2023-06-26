import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/articles/articles.dart';
import 'package:flutter_infinite_list/articles/bloc/bloc/single_article_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleArticlePage extends StatelessWidget {
  SingleArticlePage(
      {super.key,
      required this.article,
      required this.height,
      required this.width});
  final Article article;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final Uri _url =
        Uri.parse(article.url ?? "https://youtu.be/dQw4w9WgXcQ?t=42");
    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    _saveToHive() async {
      // await Hive.openBox<Downloaded>("create");
      // final downloadedArticle = Downloaded()
      //   ..author = article.author
      //   ..content = article.content
      //   ..description = article.description
      //   ..publishedAt = article.publishedAt
      //   ..source = article.source?.name
      //   ..title = article.title
      //   ..url = article.url
      //   ..urlToImage = article.urlToImage;
      // final box = Hive.box<Downloaded>("create");
      // // final box = Boxes(boxId: 'downloads');
      // box.put(article.title, downloadedArticle);
      // BlocProvider.of<SingleArticleBloc>(context)..add(ArticleDownloaded());

      // context.read<ArticleBloc>()..add(ArticleDownloaded());

      // var test = box.get(article.title);
      // var tit = test?.title;
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 16,
            child: Container(
              height: height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(226, 0, 0, 0),
              ),
              child: Center(
                child: Text(
                  "Article Saved Offline!",
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      );
    }

    var title = article.title?.split(" - ");
    var content = article.content?.split("[+");
    return BlocConsumer<SingleArticleBloc, SingleArticleState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 14, 14, 14),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              article.source?.name ?? "X-News",
              style: TextStyle(fontSize: 40),
            ),
            backgroundColor: const Color.fromARGB(255, 26, 26, 26),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black,
                                  // Color.fromARGB(73, 0, 0, 0),
                                  const Color.fromARGB(0, 0, 0, 0)
                                ],
                              ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Container(
                              width: width,
                              height: height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      article.urlToImage ??
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSojwMMYZgtiupM4Vzdb5iBeE4b0Mamf3AgrxQJR19Xa4oIWV5xun9a02Ggyh4bZAurP_c&usqp=CAU",
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.22,
                              ),
                              Text(
                                title?[0] ?? "Title",
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 18, right: 18, top: 18),
                      child: Text(
                        '${content?[0]}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text(
                        'View Full Article',
                      ),
                      onPressed: _launchUrl,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color.fromARGB(255, 37, 37, 37), // Background color
                        foregroundColor:
                            Colors.amber, // Text Color (Foreground color)
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Expanded(
                  //   child: ElevatedButton.icon(
                  //     icon: state.downloadState
                  //         ? Icon(Icons.check)
                  //         : Icon(Icons.download),
                  //     label: Text(
                  //       '${state.downloadState ? "Downloaded" : "Download"}',
                  //     ),
                  //     onPressed: _saveToHive,
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor:
                  //           Color.fromARGB(255, 37, 37, 37), // Background color
                  //       foregroundColor:
                  //           Colors.amber, // Text Color (Foreground color)
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    width: 18,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        );
      },
    );
  }
}
