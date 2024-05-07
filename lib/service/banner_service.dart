import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/banner_model.dart';

Future<List<BannerModel>> fetchBanners() async {
  final response =
      await http.get(Uri.parse('https://cookozy.web.app/api/banners'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'];
    return data.map((json) => BannerModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load banners');
  }
}
