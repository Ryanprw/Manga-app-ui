import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/manga_model.dart';

class MangaRepository {
  final String baseUrl = 'https://api.jikan.moe/v4';

  //Top Manga
  Future<List<MangaModel>> fetchMangaByGenre(int genreId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/manga?genres=$genreId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List mangaList = data['data'];
        return mangaList.map((json) => MangaModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch manga by genre');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Top Anime
  Future<List<MangaModel>> fetchAnimeByGenre(int genreId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/anime?genres=$genreId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List animeList = data['data'];
        return animeList.map((json) => MangaModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch anime by genre');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Manga by ID
  Future<MangaModel> fetchMangaById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/manga/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return MangaModel.fromJson(data['data']);
      } else {
        print('Failed to fetch manga: ${response.statusCode}');
        throw Exception('Failed to fetch manga');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch manga');
    }
  }

  // Anime by ID
  Future<MangaModel> fetchAnimeById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return MangaModel.fromJson(data['data']);
      } else {
        print('Failed to fetch anime: ${response.statusCode}');
        throw Exception('Failed to fetch anime');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch anime');
    }
  }

  // Manga by Query
  Future<List<MangaModel>> searchManga(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/manga?q=$query'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List mangaList = data['data'];
        return mangaList.map((json) => MangaModel.fromJson(json)).toList();
      } else {
        print('Failed to search manga: ${response.statusCode}');
        throw Exception('Failed to search manga');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to search manga');
    }
  }

  // Anime by Query
  Future<List<MangaModel>> searchAnime(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime?q=$query'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List animeList = data['data'];
        return animeList.map((json) => MangaModel.fromJson(json)).toList();
      } else {
        print('Failed to search anime: ${response.statusCode}');
        throw Exception('Failed to search anime');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to search anime');
    }
  }

  // Fetch Genres
  Future<List<Map<String, dynamic>>> fetchGenres({bool isAnime = false}) async {
    try {
      final String endpoint = isAnime ? 'anime' : 'manga';
      final response = await http.get(Uri.parse('$baseUrl/genres/$endpoint'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List genresList = data['data'];
        return List<Map<String, dynamic>>.from(genresList);
      } else {
        print('Failed to fetch genres: ${response.statusCode}');
        throw Exception('Failed to fetch genres');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch genres');
    }
  }
}
