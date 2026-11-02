import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../models/packing_item.dart';
import '../services/api_service.dart';
import '../services/supabase_service.dart';

class TravelProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final SupabaseService _supabaseService = SupabaseService();

  List<Destination> _destinations = [];
  List<dynamic> _favorites = [];
  final List<PackingItem> _packingList = [];
  bool _isLoading = true;
  String _searchQuery = '';

  String _userName = 'I Made Duta Aryawan';
  String _userBio = 'Suka menjelajah destinasi baru.';

  List<Destination> get destinations => _destinations;
  List<dynamic> get favorites => _favorites;
  List<PackingItem> get packingList => _packingList;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get userName => _userName;
  String get userBio => _userBio;

  List<Destination> get filteredDestinations {
    if (_searchQuery.trim().isEmpty) {
      return _destinations;
    }
    final query = _searchQuery.toLowerCase();
    return _destinations.where((destination) {
      return destination.name.toLowerCase().contains(query) ||
          destination.location.toLowerCase().contains(query);
    }).toList();
  }

  TravelProvider() {
    loadDestinations();
    loadFavorites();
  }

  void updateProfile(String name, String bio) {
    if (name.trim().isNotEmpty) {
      _userName = name.trim();
    }
    if (bio.trim().isNotEmpty) {
      _userBio = bio.trim();
    }
    notifyListeners();
  }

  void searchDestinations(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addItem(String name) {
    if (name.trim().isEmpty) return;
    _packingList.add(
      PackingItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.trim(),
      ),
    );
    notifyListeners();
  }

  void toggleItem(String id) {
    final index = _packingList.indexWhere((item) => item.id == id);
    if (index != -1) {
      _packingList[index].isChecked = !_packingList[index].isChecked;
      notifyListeners();
    }
  }

  void deleteItem(String id) {
    _packingList.removeWhere((item) => item.id == id);
    notifyListeners();
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

  Future<void> loadFavorites() async {
    try {
      _favorites = await _supabaseService.getFavorites();
    } catch (e) {
      debugPrint('Error di TravelProvider.loadFavorites: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> addToFavorite(Destination dest) async {
    await _supabaseService.addFavorite(dest);
    await loadFavorites();
    notifyListeners();
  }

  Future<void> deleteFromFavorites(String destinationId) async {
    await _supabaseService.removeFavorite(destinationId);
    await loadFavorites();
    notifyListeners();
  }

  Future<void> updateFavoriteNote(int id, String note) async {
    await _supabaseService.updateNote(id, note);
    await loadFavorites();
    notifyListeners();
  }
}
