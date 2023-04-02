import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chat_gtp_app/models/chat_model.dart';
import 'package:chat_gtp_app/models/models_model.dart';
import 'package:http/http.dart' as http;
import 'package:chat_gtp_app/constraints/api_constrants.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$base_url/models"),
        headers: {'Authorization': 'Bearer $api_key'},
      );

      if (response.statusCode != 200) {
        throw HttpException("Failed to get models: ${response.statusCode}");
      }

      Map<String, dynamic>? jsonResponse = jsonDecode(response.body);

      if (jsonResponse == null) {
        throw HttpException("Invalid JSON response");
      }

      if (jsonResponse['error'] != null && jsonResponse['error']["message"] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      //print("jason $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  //send msg to api

   static Future<List<ChatModel>> sendMsg({required String message, required String modelId}) async {

     //print(message);
     //print(modelId);

    try {
      var response = await http.post(
        Uri.parse("$base_url/chat/completions"),
        headers: {'Authorization': 'Bearer $api_key',
                  "Content-Type" : "application/json",
        },
        body: jsonEncode(
            {
              "model": modelId,
              "messages": [{"role": "user", "content": message}]
            }
        ),

      );

      Map<String, dynamic>? jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode != 200) {

        throw HttpException("Failed to get models: ${response.statusCode}");
      }


      if (jsonResponse == null) {
        throw HttpException("Invalid JSON response");
      }

      if (jsonResponse['error'] != null && jsonResponse['error']["message"] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if(response.statusCode == 200){
        List<dynamic> choices = jsonResponse["choices"];
        chatList = List.generate(
            jsonResponse["choices"].length,
                (index) => ChatModel(
                    choices[index]['message']['content'],
                    1),
        );
        //print(jsonResponse['id']);
      }

      return chatList;

    } catch (error) {
      // log("error $error");
      //print(error);

      rethrow;
    }
  }
}