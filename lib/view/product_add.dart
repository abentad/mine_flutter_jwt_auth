import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_node_auth/controller/api_controller.dart';
import 'package:flutter_node_auth/controller/auth_controller.dart';
import 'package:flutter_node_auth/view/loading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<File> _imageFiles = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('New Product', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
              SizedBox(height: size.height * 0.04),
              TextFormField(
                controller: _nameController,
                cursorColor: Colors.black,
                style: const TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  filled: true,
                  fillColor: const Color(0xfff2f2f2),
                  hintText: "Name",
                  hintStyle: const TextStyle(fontSize: 14.0, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              TextFormField(
                controller: _descriptionController,
                cursorColor: Colors.black,
                style: const TextStyle(fontSize: 18.0),
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  filled: true,
                  fillColor: const Color(0xfff2f2f2),
                  hintText: "Description",
                  hintStyle: const TextStyle(fontSize: 14.0, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              const Text('Images', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.grey)),
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xfff2f2f2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  // color: Colors.purple,
                                  ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _imageFiles.length,
                                      itemBuilder: (context, index) => Container(
                                        margin: const EdgeInsets.all(10.0),
                                        width: size.width * 0.25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.yellow,
                                          image: DecorationImage(image: FileImage(_imageFiles[index]), fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (_imageFiles.length < 3) {
                                  File pickedFile = await Get.find<AuthController>().chooseImage(ImageSource.camera);
                                  File croppedFile = await Get.find<AuthController>().cropImage(pickedFile);
                                  setState(() {
                                    _imageFiles.add(croppedFile);
                                  });
                                } else {
                                  print('cant upload more than 3 images');
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                                child: const Center(child: Icon(Icons.add)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              MaterialButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  Get.to(() => const Loading(), transition: Transition.fade);
                  bool result = await Get.find<ApiController>().postProduct(_nameController.text, _descriptionController.text, _imageFiles);
                  Get.find<ApiController>().getProducts();
                  Get.back();
                  if (result) {
                    print('posted');
                    Get.back();
                  } else {
                    print('unable to post');
                  }
                },
                color: Colors.black,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                height: size.height * 0.07,
                child: const Text("Add", style: TextStyle(fontSize: 16.0, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
