import 'package:floor/floor.dart';
import 'shopping_item.dart';

@dao
abstract class ShoppingDao {
  @Query('SELECT * FROM ShoppingItem')
  Future<List<ShoppingItem>> getAllItems();

  @insert
  Future<void> insertItem(ShoppingItem item);

  @delete
  Future<void> deleteItem(ShoppingItem item);
}
