final class Article {
  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source?.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "content": content,
      };
}

class NewsRepo {
  String? status;
  int? totalResults;
  List<Article>? articles;

  NewsRepo({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsRepo.fromJson(Map<String, dynamic> json) => NewsRepo(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((dynamic json) => Article.fromJson(json))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles":
            List<Article>.from(articles!.map((dynamic json) => json.toJson())),
      };
}

class Source {
  String? name;
  String? id;

  Source({required this.name, required this.id});

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(name: json["name"], id: json["id"]);

  Map<String, dynamic> toJson() => {"name": name, "id": id};
}
