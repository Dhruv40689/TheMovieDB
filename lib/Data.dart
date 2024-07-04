import 'dart:convert';
import 'package:http/http.dart' as http;

class Data {
  final bool adult;
  final String path;
  final String language;
  final String title;
  final String overview;
  final String releaseDate;

  Data({
    required this.adult,
    required this.path,
    required this.language,
    required this.title,
    required this.overview,
    required this.releaseDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      adult: json['adult'],
      path: json['poster_path'],
      language: json['original_language'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
    );
  }
}

class DataService {
  static const String baseUrl = "https://api.themoviedb.org/3/discover/movie?api_key=81a5499013451ffd894029835478e7b1&language=en-US&sort_by=popularity.desc&page=";

  Future<List<Data>> fetchData(int page) async {
    final Uri uri = Uri.parse(baseUrl + page.toString());
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> results = body['results'];

      return results.map((dynamic item) => Data.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
