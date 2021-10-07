import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_node_auth/constants.dart';
import 'package:flutter_node_auth/controller/auth_controller.dart';
import 'package:flutter_node_auth/model/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ApiController extends GetxController {
  //secure storage
  final _storage = const FlutterSecureStorage();
  final String _tokenKey = "token";
  //
  final List<Product> _products = [];
  List<Product> get products => _products;

  ApiController();
  //variables for fetching more products on scroll
  int _pages = 2;
  final int _limits = 20;

  Future<bool> getProducts(bool isinitcall) async {
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
        if (isinitcall) {
          int _page = 1;
          int _limit = 20;
          _pages = 2;
          print('init fetch... page= $_page limit = $_limit');

          final response = await _dio.get("/data/products?page=$_page&limit=$_limit");
          if (response.statusCode == 200) {
            _products.clear();
            for (var i = 0; i < response.data['results'].length; i++) {
              _products.add(
                Product(
                  sId: response.data['results'][i]['_id'],
                  posterId: response.data['results'][i]['posterId'],
                  posterName: response.data['results'][i]['posterName'],
                  posterPhoneNumber: response.data['results'][i]['posterPhoneNumber'],
                  name: response.data['results'][i]['name'],
                  datePosted: response.data['results'][i]['datePosted'],
                  description: response.data['results'][i]['description'],
                  productImages: response.data['results'][i]['productImages'],
                ),
              );
            }
            print(_products.length);
            update();
            return true;
          }
        } else {
          print('fetching more... page= $_pages limit = $_limits');
          final response = await _dio.get("/data/products?page=$_pages&limit=$_limits");
          print(_products.length);
          if (response.statusCode == 200) {
            if (response.data['results'].isNotEmpty) {
              for (var i = 0; i < response.data['results'].length; i++) {
                _products.add(
                  Product(
                    sId: response.data['results'][i]['_id'],
                    posterId: response.data['results'][i]['posterId'],
                    posterName: response.data['results'][i]['posterName'],
                    posterPhoneNumber: response.data['results'][i]['posterPhoneNumber'],
                    name: response.data['results'][i]['name'],
                    datePosted: response.data['results'][i]['datePosted'],
                    description: response.data['results'][i]['description'],
                    productImages: response.data['results'][i]['productImages'],
                  ),
                );
              }
              print(_products.length);
              _pages = _pages + 1;
              print('next page: $_pages');

              update();
            } else {
              return false;
            }
            return true;
          }
        }
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      print('no token found skippng fetch');
      return false;
    }
    return false;
  }

  Future<bool> postProduct(String name, String description, List<File> imageFiles) async {
    String? _token = await _storage.read(key: _tokenKey);
    String posterId = Get.find<AuthController>().currentUser!.userId.toString();
    String posterName = Get.find<AuthController>().currentUser!.username.toString();
    String posterPhoneNumber = Get.find<AuthController>().currentUser!.phoneNumber.toString();

    if (_token != null) {
      List<MultipartFile> _images = [];
      for (File imageFile in imageFiles) {
        _images.add(await MultipartFile.fromFile(imageFile.path));
      }
      print("image length to be uploaded: ${_images.length}");
      FormData formData = FormData.fromMap(
        {
          "posterId": posterId,
          "posterName": posterName,
          "posterPhoneNumber": posterPhoneNumber,
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
