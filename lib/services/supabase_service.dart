import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/destination.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<dynamic>> getFavorites() async {
    try {
      final response = await _supabase.from('favorites').select();
      return response;
    } catch (e) {
      debugPrint('Error saat getFavorites: $e');
      return [];
    }
  }

  Future<void> addFavorite(Destination dest) async {
    try {
      await _supabase.from('favorites').insert({
        'destination_id': dest.id,
        'name': dest.name,
        'location': dest.location,
        'image_url': dest.imageUrl,
      });
    } catch (e) {
      debugPrint('Error saat addFavorite: $e');
      rethrow;
    }
  }
}

