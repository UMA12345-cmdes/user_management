import 'dart:convert';

import 'package:http/http.dart';
import 'package:user_management/config/api_path/api_end_point.dart';
import 'package:user_management/data/model/response_modal/login_success_response.dart';
import 'package:user_management/data/model/response_modal/signup_response.dart';
import 'package:user_management/data/network/network_service.dart';

class AuthRepository {
  final NetworkService networkService =
      NetworkService(baseUrl: ApiEndPoint.baseUrl);
  Future<LoginSuccessResponse> signIn(String email, String password) async {
    final Map<String, dynamic> userData = <String, dynamic>{
      'email': email,
      'password': password
    };
    final Response response =
        await networkService.post(ApiEndPoint.loginEndPoint, data: userData);
    final dynamic decodeResponse = jsonDecode(response.body);
    return LoginSuccessResponse.fromJson(
        decodeResponse as Map<String, dynamic>);
  }

  Future<SignupResponse> signUp(
      String name, String email, String password) async {
    final Map<String, dynamic> userData = <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'avatar': 'https://picsum.photos/800'
    };
    final Response response =
        await networkService.post(ApiEndPoint.signupEndPoint, data: userData);
    final dynamic decodeResponse = jsonDecode(response.body);
    return SignupResponse.fromJson(decodeResponse as Map<String, dynamic>);
  }
}
