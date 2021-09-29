import 'dart:convert';

import 'package:flutter_node_auth/model/user.dart';
import 'package:flutter_node_auth/view/auth_choice.dart';
import 'package:flutter_node_auth/view/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  String authRouteBase = 'http://10.0.2.2:3000/user';
  //secure storage
  final _storage = const FlutterSecureStorage();
  final String _tokenKey = "token";
  //user
  User? _currentUser;
  User? get currentUser => _currentUser;

  AuthController() {
    checkUser();
  }

  void checkUser() async {
    String? token = await _storage.read(key: _tokenKey);
    if (token != null) {
      bool result = await signInWithToken(token);
      if (result) {
        Get.to(() => const HomeScreen());
      }
    } else {
      Get.to(() => const AuthChoice());
    }
  }

  //signup
  Future<bool> signUpUser(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse(authRouteBase + '/signup'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, String>{'username': username, 'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      _currentUser = User.fromJson(response.body);
      await _storage.write(key: _tokenKey, value: _currentUser!.token);
      print(_currentUser!.userId);
      return true;
    }
    return false;
  }

  //signin
  Future<bool> signInUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(authRouteBase + '/signin'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      _currentUser = User.fromJson(response.body);
      await _storage.write(key: _tokenKey, value: _currentUser!.token);
      print(_currentUser!.userId);
      return true;
    }
    return false;
  }

  //signin
  Future<bool> signInWithToken(String token) async {
    final response = await http.get(
      Uri.parse(authRouteBase + '/signinwithtoken'),
      headers: <String, String>{'x-access-token': token},
    );
    if (response.statusCode == 200) {
      _currentUser = User.fromJson(response.body);
      print(_currentUser!.userId);
      return true;
    }
    return false;
  }

  void signOut() async {
    if (await _storage.read(key: _tokenKey) != null) {
      await _storage.write(key: _tokenKey, value: null);
      Get.offAll(() => const AuthChoice());
    }
  }
}
