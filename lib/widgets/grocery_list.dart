import 'package:flutter/material.dart';
import 'package:flutter_shopping_list/models/grocery_item.dart';
import 'package:flutter_shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    _groceryItems.remove(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body:
          _groceryItems.isNotEmpty
              ? ListView.builder(
                itemCount: _groceryItems.length, // Example item count
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      _removeItem(_groceryItems[index]);
                    },
                    background: Container(color: Colors.red),
                    key: ValueKey(_groceryItems[index].id),
                    child: ListTile(
                      title: Text(_groceryItems[index].name),
                      leading: Container(
                        width: 24,
                        height: 24,
                        color: _groceryItems[index].category.color,
                      ),
                      trailing: Text(_groceryItems[index].quantity.toString()),
                    ),
                  );
                },
              )
              : const Center(
                child: Text(
                  "Add your groceries!",
                  style: TextStyle(fontSize: 18),
                ),
              ),
    );
  }
}
