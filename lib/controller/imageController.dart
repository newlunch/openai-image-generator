// ignore_for_file: file_names

import 'dart:convert';
import 'package:openai_image_generator/filesWithImportantVariables/secrets.dart'
    as secrets;
import 'package:openai_image_generator/models/imageModels.dart';
import 'package:http/http.dart' as http;

class ImageController {
  Future<ImageModels> getImage({required String promt}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${secrets.apiKey}',
    };
    var body = jsonEncode({'prompt': promt, 'size': '256x256', 'n': 1});
    var request = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: headers,
        body: body);
    var requestJson = jsonDecode(request.body);
    if (request.statusCode == 200) {
      return ImageModels.url(requestJson);
    } else {
      return ImageModels.error(requestJson);
    }
  }
}
