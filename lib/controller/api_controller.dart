import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_node_auth/constants.dart';
import 'package:flutter_node_auth/model/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ApiController extends GetxController {
  //secure storage
  final _storage = const FlutterSecureStorage();
  final String _tokenKey = "token";
  //
  final List<Product> _products = [];
  List<Product> get products => _products;

  ApiController() {
    getProducts();
  }

  void getProducts() async {
    String? _token = await _storage.read(key: _tokenKey);
    if (_token != null) {
      Dio _dio = Dio(
        BaseOptions(
          baseUrl: kbaseUrl,
          connectTimeout: 10000,
          receiveTimeout: 100000,
          headers: {'x-access-token': _token},
          responseType: ResponseType.json,
        ),
      );
      try {
        final response = await _dio.get("/data/products");
        if (response.statusCode == 200) {
          _products.clear();
          for (var i = 0; i < response.data.length; i++) {
            _products.add(
              Product(
                sId: response.data[i]['_id'],
                name: response.data[i]['name'],
                datePosted: response.data[i]['datePosted'],
                description: response.data[i]['description'],
                productImages: response.data[i]['productImages'],
              ),
            );
          }
          print(_products.length);
          update();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('no token found skippng fetch');
    }
  }

  Future<bool> postProduct(String name, String description, List<File> imageFiles) async {
    String? _token = await _storage.read(key: _tokenKey);
    if (_token != null) {
      List<MultipartFile> _images = [];
      for (File imageFile in imageFiles) {
        _images.add(await MultipartFile.fromFile(imageFile.path));
      }
      print("image length to be uploaded: ${_images.length}");
      FormData formData = FormData.fromMap(
        {
          "name": name,
          "description": description,
          "gallery": _images,
        },
      );

      Dio _dio = Dio(
        BaseOptions(
          baseUrl: kbaseUrl,
          connectTimeout: 10000,
          receiveTimeout: 100000,
          headers: {'x-access-token': _token},
          responseType: ResponseType.json,
        ),
      );

      try {
        final response = await _dio.post('/data/post', data: formData);
        if (response.statusCode == 201) {
          return true;
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('no token found skippng fetch');
    }

    return false;
  }
}
