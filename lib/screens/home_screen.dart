import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/travel_provider.dart';
import '../widgets/travel_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Planner'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Text(
                'Menu Travel',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Tentang Aplikasi'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Consumer<TravelProvider>(
        builder: (context, travelProvider, child) {
          if (travelProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (travelProvider.destinations.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Gagal memuat data',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final destinations = travelProvider.destinations;

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: destinations.length,
                  itemBuilder: (context, index) {
                    return TravelCard(
                      destination: destinations[index],
                    );
                  },
                );
              } else {
                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: destinations.length,
                  itemBuilder: (context, index) {
                    return TravelCard(
                      destination: destinations[index],
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
