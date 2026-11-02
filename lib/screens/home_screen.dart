import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/travel_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Destination> destinations = const [
    Destination(
      id: '1',
      name: 'Bali',
      location: 'Indonesia',
      imageUrl: 'https://example.com/bali.jpg',
      description: 'Pulau Dewata dengan pantai indah dan budaya yang kaya.',
    ),
    Destination(
      id: '2',
      name: 'Tokyo',
      location: 'Jepang',
      imageUrl: 'https://example.com/tokyo.jpg',
      description: 'Kota metropolitan modern yang memadukan teknologi dan tradisi.',
    ),
    Destination(
      id: '3',
      name: 'Paris',
      location: 'Prancis',
      imageUrl: 'https://example.com/paris.jpg',
      description: 'Kota romantis yang terkenal dengan Menara Eiffel dan museum seni.',
    ),
    Destination(
      id: '4',
      name: 'London',
      location: 'Inggris',
      imageUrl: 'https://example.com/london.jpg',
      description: 'Kota bersejarah dengan ikon Big Ben, London Eye, dan Sungai Thames.',
    ),
    Destination(
      id: '5',
      name: 'New York',
      location: 'Amerika Serikat',
      imageUrl: 'https://example.com/newyork.jpg',
      description: 'Kota yang tak pernah tidur dengan Times Square dan Patung Liberty.',
    ),
    Destination(
      id: '6',
      name: 'Sydney',
      location: 'Australia',
      imageUrl: 'https://example.com/sydney.jpg',
      description: 'Kota pelabuhan yang ikonik dengan gedung Sydney Opera House.',
    ),
  ];

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
      body: LayoutBuilder(
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
      ),
    );
  }
}
