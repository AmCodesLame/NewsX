import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_infinite_list/articles/articles.dart';

class Boxes {
  final String boxId;

  Boxes({required this.boxId});
  static Box<Downloaded> getDownloadsBox() => Hive.box<Downloaded>("downlaods");
}
