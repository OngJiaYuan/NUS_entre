import 'dart:convert';
import 'package:nus_entreprenuership_app/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();
  Future<List<Article>> getArticle() async {
    final queryParameters = {
      'country': 'sg',
      'category': 'technology',
      'apiKey': 'd57afb93ee014b4b82f750992c5d156c'
    };
    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}
