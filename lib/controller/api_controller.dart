import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_node_auth/model/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  String authRouteBase = 'http://shopri.rentoch.com';
  //secure storage
  final _storage = const FlutterSecureStorage();
  final String _tokenKey = "token";
  //
  List<Product> _products = [];
  List<Product> get products => _products;

  ApiController() {
    getProducts();
  }

  void getProducts() async {
    String? _token = await _storage.read(key: _tokenKey);
    if (_token != null) {
      // Dio dio = Dio(BaseOptions(baseUrl: authRouteBase, connectTimeout: 5000, receiveTimeout: 100000, headers: {'x-access-token': _token}));
      Dio dio = Dio(BaseOptions(baseUrl: authRouteBase, headers: {'x-access-token': _token}));
      try {
        final response = await dio.get("/data/products");
        if (response.statusCode == 200) {
          var _listDataJson = response.data as List;
          // for (var i = 0; i < _listDataJson.length; i++) {
          _products = _listDataJson.map((prod) => Product.fromJson(prod)).toList();
          // }
          print(_products.length);
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('no token found skippng fetch');
    }
  }
}
