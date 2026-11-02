import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/destination.dart';

class ApiService {
  static const String _baseUrl =
      'https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json';

  Future<List<Destination>> fetchDestinations() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final dynamic decodedData = jsonDecode(response.body);

        if (decodedData is List) {
          return decodedData
              .whereType<Map<String, dynamic>>()
              .map((item) => Destination.fromJson(item))
              .toList();
        } else {
          debugPrint('Format response bukan List: $decodedData');
          return [];
        }
      } else {
        debugPrint('HTTP Error (${response.statusCode}): ${response.body}');
        return [];
      }
    } catch (e) {
      debugPrint('Exception saat fetchDestinations: $e');
      return [];
    }
  }
}
