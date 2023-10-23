import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgbt_app/model/chat_model.dart';
import 'package:chatgbt_app/model/models_model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  // get models
  static Future<List<ModelsModel>> getModel() async {
    try {
      var response = await http.get(
        Uri.parse("https://api.openai.com/v1/models"),
        headers: {
          "Authorization":
              "Bearer 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"
        },
      );
      Map jsonResponse = jsonDecode(response.body);
      // if (jsonResponse['data']) {

      // }
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        // log(value["id"].toString() );
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  //send message
  static Future<List<ChatModel>> sendMessage({
    required String message,
    required String modelId,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Authorization":
              "Bearer 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",
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 100,
          },
        ),
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        chatList = jsonResponse["choices"][0]["message"]["chat"];
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["text"], chatIndex: 1),
        );
      }

      return chatList;
    } catch (e) {
      return [];
    }
  }
}
