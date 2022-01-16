import 'package:dio/dio.dart';
import 'package:kanban/model/card_response.dart';
import 'package:kanban/settings.dart';
import 'dart:developer' as console;

class ApiClient{
  static const String basePath = r'https://trello.backend.tests.nekidaem.ru/api/v1';
  static getDio() {
    Dio _dio = Dio();
    _dio.options = BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
    );
    return _dio;
  }

  Future apiAuth(String username, String password) async {
    final String url = '${basePath}/users/login/?$username:$password';
    Dio _dio = getDio();
    _dio.options = BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer',
        }
    );
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password
    });
    return await _dio.post(url, data: formData);
  }

  Future apiCards() async {
    final String url = '${basePath}/cards/';
    Dio _dio = getDio();
    return await _dio.get(url, options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'JWT ${preferences.token}',
        'username': 'armada',
        'password': 'FSH6zBZ0p9yH'
      },
    ),);
  }

  Future<CardResponse> apiCardsGet() async {
    final String url = '${basePath}/cards/';
    Dio _dio = getDio();
    try {
      Response response = await _dio.get(url, options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'JWT ${preferences.token}',
        },

      ));
      return CardResponse.fromJson(response.data);
    } catch(error, stacktrace) {
      console.log('$error , $stacktrace');
      return CardResponse.withError("$error");
    }
  }



}