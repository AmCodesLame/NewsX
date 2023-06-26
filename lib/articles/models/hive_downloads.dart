import 'package:flutter_infinite_list/articles/articles.dart';
import 'package:hive/hive.dart';

part 'hive_downloads.g.dart';

@HiveType(typeId: 0)
class Downloaded extends HiveObject {
  List<Article>? articles;
}
