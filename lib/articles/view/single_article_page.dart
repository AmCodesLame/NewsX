import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/articles/articles.dart';

class SingleArticlePage extends StatelessWidget {
  const SingleArticlePage(
      {super.key,
      required this.article,
      required this.height,
      required this.width});
  final Article article;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    var title = article.title?.split(" - ");
    var content = article.content?.split("[+");

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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 37, 37, 37), // Background color
                    foregroundColor:
                        Colors.amber, // Text Color (Foreground color)
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.download),
                  label: const Text(
                    'Download',
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 37, 37, 37), // Background color
                    foregroundColor:
                        Colors.amber, // Text Color (Foreground color)
                  ),
                ),
              ),
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
  }
}
