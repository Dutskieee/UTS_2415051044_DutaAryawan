import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/travel_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _showEditNoteDialog(
    BuildContext context,
    int id,
    String currentNote,
  ) {
    final TextEditingController noteController = TextEditingController(
      text: currentNote == 'Belum ada catatan' ? '' : currentNote,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Catatan Perjalanan'),
          content: TextField(
            controller: noteController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Tulis catatan rencana perjalanan Anda...',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final String updatedNote = noteController.text.trim().isEmpty
                    ? 'Belum ada catatan'
                    : noteController.text.trim();

                Navigator.pop(dialogContext);

                await Provider.of<TravelProvider>(
                  context,
                  listen: false,
                ).updateFavoriteNote(id, updatedNote);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Catatan berhasil diperbarui'),
                    ),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, String destinationId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus dari favorit?'),
          content: const Text(
            'Apakah Anda yakin ingin menghapus destinasi ini dari daftar favorit?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                await Provider.of<TravelProvider>(
                  context,
                  listen: false,
                ).deleteFromFavorites(destinationId);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Berhasil dihapus'),
                    ),
                  );
                }
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destinasi Favorit'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<TravelProvider>(
        builder: (context, travelProvider, child) {
          final favorites = travelProvider.favorites;

          if (favorites.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 72,
                      color: Colors.lightBlue.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada destinasi impian yang disimpan',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
            padding: const EdgeInsets.all(12.0),
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final dynamic item = favorites[index];
              final Map<String, dynamic> fav = item is Map<String, dynamic>
                  ? item
                  : <String, dynamic>{};

              final int id = fav['id'] is int
                  ? fav['id'] as int
                  : int.tryParse(fav['id']?.toString() ?? '0') ?? 0;
              final String destinationId =
                  fav['destination_id']?.toString() ?? '';
              final String name =
                  fav['name']?.toString() ?? 'Destinasi Tanpa Nama';
              final String location =
                  fav['location']?.toString() ?? 'Indonesia';
              final String imageUrl = fav['image_url']?.toString() ?? '';
              final String personalNote =
                  (fav['personal_note']?.toString().trim().isNotEmpty ?? false)
                      ? fav['personal_note'].toString()
                      : 'Belum ada catatan';

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.lightBlue[50],
                                  child: const Icon(
                                    Icons.landscape,
                                    color: Colors.lightBlue,
                                  ),
                                );
                              },
                            )
                          : Container(
                              color: Colors.lightBlue[50],
                              child: const Icon(
                                Icons.landscape,
                                color: Colors.lightBlue,
                              ),
                            ),
                    ),
                  ),
                  title: Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.lightBlue,
                            ),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(
                                location,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.sticky_note_2_outlined,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(
                                personalNote,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        tooltip: 'Edit Catatan',
                        onPressed: () {
                          _showEditNoteDialog(context, id, personalNote);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Hapus Favorit',
                        onPressed: () {
                          _confirmDelete(context, destinationId);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
