import 'package:flutter/material.dart';
import '../models/destination.dart';

class TravelProvider extends ChangeNotifier {
  final List<Destination> _destinations = [
    const Destination(
      id: '1',
      name: 'Pantai Kuta',
      location: 'Bali, Indonesia',
      imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
      description:
          'Pantai eksotis di Bali yang terkenal dengan pasir putih dan pemandangan matahari terbenam yang memukau.',
    ),
    const Destination(
      id: '2',
      name: 'Candi Borobudur',
      location: 'Magelang, Jawa Tengah',
      imageUrl: 'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272',
      description:
          'Candi Buddha terbesar di dunia yang dikelilingi pegunungan hijau dan relief bersejarah.',
    ),
    const Destination(
      id: '3',
      name: 'Raja Ampat',
      location: 'Papua Barat Daya, Indonesia',
      imageUrl: 'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf',
      description:
          'Kepulauan tropis dengan keanekaragaman hayati bawah laut terbaik di dunia dan gugusan pulau karst yang ikonik.',
    ),
    const Destination(
      id: '4',
      name: 'Gunung Bromo',
      location: 'Jawa Timur, Indonesia',
      imageUrl: 'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272',
      description:
          'Gunung berapi aktif dengan lautan pasir luas dan panorama matahari terbit yang spektakuler.',
    ),
  ];

  final bool _isLoading = false;

  List<Destination> get destinations => _destinations;
  bool get isLoading => _isLoading;
}

