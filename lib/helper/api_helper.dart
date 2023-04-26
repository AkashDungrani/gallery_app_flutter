import 'dart:convert';

import 'package:gallery_app/models/image_helper.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();
  static final ApiHelper apiHelper = ApiHelper._();
  Future<List<Photos>?> fetchimage({String category = "lion"}) async {
    String apikey = "35751837-4bd276317c069a626ca71bd63";
    String api =
        "https://pixabay.com/api/?key=$apikey&q=$category&image_type=photo&pretty=true";
    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(res.body);
      List data = decodedData['hits'];
      List<Photos> k = data.map((e) => Photos.fromMap(data: e)).toList();
      return k;
    }
  }
}
