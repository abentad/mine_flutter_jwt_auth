import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_node_auth/constants.dart';
import 'package:flutter_node_auth/controller/api_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key, required this.selectedProductIndex}) : super(key: key);

  final int selectedProductIndex;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<ApiController>(
        builder: (controller) => SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // height: size.height * 0.6,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                        color: Color(0xfff2f2f2),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: '$kbaseUrl/${controller.products[selectedProductIndex].productImages![0]}',
                        placeholder: (context, url) => Container(
                          height: size.height * 0.15,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        '${controller.products[selectedProductIndex].name}',
                        style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        'By ${controller.products[selectedProductIndex].posterName.toString()}',
                        style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        controller.products[selectedProductIndex].description.toString(),
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(height: size.height * 0.2)
                  ],
                ),
              ),
              Positioned(
                bottom: 10.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: size.width * 0.02),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        height: 50.0,
                        child: const Text('Call', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        color: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        height: 50.0,
                        child: const Text('Message', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
