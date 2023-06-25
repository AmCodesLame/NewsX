import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/articles/articles.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem(
      {required this.article,
      super.key,
      required this.height,
      required this.width});

  final Article article;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    var title = article.title?.split(" - ");
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey,
                    offset: Offset(0, 2),
                    spreadRadius: 1)
              ]),
          height: height * 0.25,
          margin: EdgeInsets.only(
              bottom: height * 0.01,
              top: height * 0.02,
              left: width * 0.02,
              right: width * 0.02),
          child: Stack(
            children: <Widget>[
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                  width: width,
                  height: height * 0.25,
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
              Container(
                height: height,
                width: width,
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.025),
                child: Column(
                  children: [
                    Flexible(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          title?[0] ?? "Title",
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        "-${title?[1]}",
                        style: TextStyle(
                            color: Color.fromARGB(255, 182, 182, 182),
                            fontSize: 12,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => SingleArticlePage(
                    article: article,
                    height: height,
                    width: width,
                  ))));
        });
  }
}
