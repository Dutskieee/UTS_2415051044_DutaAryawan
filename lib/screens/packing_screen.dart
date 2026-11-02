import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/travel_provider.dart';

class PackingScreen extends StatelessWidget {
  PackingScreen({super.key});

  final TextEditingController _itemController = TextEditingController();

  void _submitItem(BuildContext context) {
    final String text = _itemController.text.trim();
    if (text.isNotEmpty) {
      context.read<TravelProvider>().addItem(text);
      _itemController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Packing List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    onSubmitted: (_) => _submitItem(context),
                    decoration: InputDecoration(
                      hintText: 'Tambah barang bawaan...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 24,
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    tooltip: 'Tambah Barang',
                    onPressed: () => _submitItem(context),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TravelProvider>(
              builder: (context, travelProvider, child) {
                final items = travelProvider.packingList;

                if (items.isEmpty) {
                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.backpack_outlined,
                            size: 52,
                            color: Colors.lightBlue.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            'Belum ada barang bawaan di daftar Anda',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 4.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: item.isChecked,
                        onChanged: (_) {
                          travelProvider.toggleItem(item.id);
                        },
                        title: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: item.isChecked
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: item.isChecked ? Colors.grey : Colors.black87,
                          ),
                        ),
                        secondary: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          tooltip: 'Hapus Barang',
                          onPressed: () {
                            travelProvider.deleteItem(item.id);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
