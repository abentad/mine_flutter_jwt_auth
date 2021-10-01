import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_node_auth/model/user.dart';
import 'package:flutter_node_auth/view/auth_choice.dart';
import 'package:flutter_node_auth/view/home_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  // String authRouteBase = 'http://shopri.rentoch.com/user';
  String authRouteBase = "http://10.0.2.2:3000/user";
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
        Get.offAll(() => const HomeScreen(), transition: Transition.cupertino);
      }
    } else {
      Get.offAll(() => const AuthChoice(), transition: Transition.cupertino);
    }
  }

  //choose imageFile
  Future<File> chooseImage(ImageSource imageSourse) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? _image = await _picker.pickImage(source: imageSourse);
    final File file = File(_image!.path);
    return file;
  }

  //signup
  Future<bool> signUpUser(String username, String email, String password, File file) async {
    String endPoint = authRouteBase + '/signup';

    FormData formData = FormData.fromMap({
      "username": username,
      "email": email,
      "password": password,
      "profile": await MultipartFile.fromFile(file.path),
    });

    Dio dio = Dio();

    try {
      final response = await dio.post(endPoint, data: formData);
      if (response.statusCode == 201) {
        _currentUser = User.fromJson(response.toString());
        await _storage.write(key: _tokenKey, value: _currentUser!.token);
        print(_currentUser!.userId);
        return true;
      }
    } catch (e) {
      print(e);
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
      Get.offAll(() => const AuthChoice(), transition: Transition.cupertino);
    }
  }
}
