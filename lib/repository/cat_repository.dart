import 'dart:convert';

import 'package:catapp/config/constant.dart';
import 'package:catapp/models/cat.dart';
import 'package:http/http.dart' as http;

class CatRepository {
  Future<List<Cat>> listCat() async {
    final url = Uri.parse(baseURL);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Iterable data = jsonDecode(response.body);
        return data.map((e) => Cat.fromJson(e)).toList();
      }
    } catch (error) {
      rethrow;
    }

    return [];
  }

  Future<Cat> findOne(String id) async {
    final url = Uri.parse('$baseURL/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Cat.fromJson(data);
      } else {
        throw Exception("Error");
      }
    } catch (error) {
      rethrow;
    }
  }
}
