import 'package:flutter/material.dart';
import 'shopping_database.dart';
import 'shopping_dao.dart';
import 'shopping_item.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  late ShoppingDatabase database;
  late ShoppingDao shoppingDao;
  List<ShoppingItem> shoppingList = [];

  @override
  void initState() {
    super.initState();
    initDb();
  }

  Future<void> initDb() async {
    database = await $FloorShoppingDatabase
        .databaseBuilder('shopping_list.db')
        .build();
    shoppingDao = database.shoppingDao;
    loadItems();
  }

  Future<void> loadItems() async {
    final items = await shoppingDao.getAllItems();
    setState(() {
      shoppingList = items;
    });
  }

  void addItem() async {
    String itemName = _itemController.text.trim();
    String quantity = _quantityController.text.trim();

    if (itemName.isNotEmpty && quantity.isNotEmpty) {
      final newItem = ShoppingItem(null, itemName, quantity);
      await shoppingDao.insertItem(newItem);
      loadItems();
      _itemController.clear();
      _quantityController.clear();
    }
  }

  void deleteItem(int index) async {
    // Show a confirmation dialog
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Item"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // No
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Yes
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    // If the user confirms deletion, proceed
    if (confirmDelete == true) {
      final itemToDelete = shoppingList[index];
      await shoppingDao.deleteItem(itemToDelete); // Delete from the database
      setState(() {
        shoppingList.removeAt(index); // Remove from the list
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shopping List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addItem,
              child: const Text("Add"),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: shoppingList.isEmpty
                  ? const Center(child: Text("There are no items in the list"))
                  : ListView.builder(
                itemCount: shoppingList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => deleteItem(index),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          "${index + 1}. ${shoppingList[index].name}",
                        ),
                        trailing: Text("x ${shoppingList[index].quantity}"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
