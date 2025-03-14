import 'package:floor/floor.dart';

@entity
class ShoppingItem {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String quantity;

  ShoppingItem(this.id, this.name, this.quantity);
}
