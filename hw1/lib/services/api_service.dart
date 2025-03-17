import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/breed.dart';
import '../models/cat.dart';

class ApiService {
  static const String _baseUrl = 'https://api.thecatapi.com/v1';

  Future<dynamic> _fetchData({
    required String endpoint,
    Map<String, String>? queryParameters,
  }) async {
    if (!dotenv.isInitialized) {
      try {
        await dotenv.load(fileName: '.env');
      } catch (e) {
        rethrow;
      }
    }

    final String apiKey = dotenv.env['API_KEY'] ?? '';

    final uri = Uri.parse(
      '$_baseUrl/$endpoint',
    ).replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: {'x-api-key': apiKey});

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody is List && responseBody.isEmpty) {
        throw Exception('Empty response from server');
      }
      return responseBody;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<List<Breed>> getAllBreeds() async {
    try {
      final data = await _fetchData(endpoint: 'breeds');
      if (data is List) {
        return data.map((json) => Breed.fromJson(json)).toList();
      } else {
        throw Exception('Invalid data format for breeds');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Cat> getRandomCatByBreed(String breedId) async {
    try {
      final data = await _fetchData(
        endpoint: 'images/search',
        queryParameters: {'breed_ids': breedId},
      );
      if (data is List && data.isNotEmpty) {
        return Cat.fromJson(data.first);
      } else {
        throw Exception('No cat found for the given breed ID');
      }
    } catch (e) {
      rethrow;
    }
  }
}
