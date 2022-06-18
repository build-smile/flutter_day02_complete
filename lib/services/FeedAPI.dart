import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Feed.dart';

class FeedService {
  String url = 'https://jsonplaceholder.typicode.com';
  Future<List<Feed>> getFeed() async {
    Uri urlApi = Uri.parse('$url/posts');
    final response = await http.get(urlApi);
    print('$url/post');
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      List<Feed> data = result.map((e) => Feed.fromJson(e)).toList();
      return data;
    }

    return [];
  }
}
