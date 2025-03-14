import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'shopping_dao.dart';
import 'shopping_item.dart';

part 'shopping_database.g.dart';

@Database(version: 1, entities: [ShoppingItem])
abstract class ShoppingDatabase extends FloorDatabase {
  ShoppingDao get shoppingDao;
}
