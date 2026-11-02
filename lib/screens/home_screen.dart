import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/destination.dart';
import '../providers/travel_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildDestinationCard(BuildContext context, Destination destination) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(destination: destination),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22.0),
                  ),
                  child: Hero(
                    tag: destination.id,
                    child: Image.network(
                      destination.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.lightBlue[50],
                          child: const Icon(
                            Icons.landscape_rounded,
                            size: 42,
                            color: Colors.lightBlue,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: Colors.lightBlue,
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            destination.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<TravelProvider>(
              builder: (context, provider, child) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, ${provider.userName}!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Mau kemana hari ini?',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 6.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 16.0,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    context.read<TravelProvider>().searchDestinations(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari destinasi...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.lightBlue,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Consumer<TravelProvider>(
                builder: (context, travelProvider, child) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isWide = constraints.maxWidth > 600;
                      final int crossAxisCount = isWide ? 4 : 2;
                      final double childAspectRatio = isWide ? 0.9 : 0.82;

                      if (travelProvider.isLoading) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(20.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: isWide ? 8 : 6,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22.0),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      if (travelProvider.destinations.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                              'Gagal memuat data',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      final destinations = travelProvider.filteredDestinations;

                      if (destinations.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text(
                              'Destinasi tidak ditemukan',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 24.0),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemCount: destinations.length,
                        itemBuilder: (context, index) {
                          return _buildDestinationCard(
                            context,
                            destinations[index],
                          );
                        },
                      );
                    },
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
