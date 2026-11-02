import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../services/api_service.dart';

class TravelProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Destination> _destinations = [];
  bool _isLoading = true;

  List<Destination> get destinations => _destinations;
  bool get isLoading => _isLoading;

  TravelProvider() {
    loadDestinations();
  }

  Future<void> loadDestinations() async {
    _isLoading = true;
    notifyListeners();

    try {
      _destinations = await _apiService.fetchDestinations();
    } catch (e) {
      debugPrint('Error di TravelProvider.loadDestinations: $e');
      _destinations = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
