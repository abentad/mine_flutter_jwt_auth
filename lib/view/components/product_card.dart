import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_auth/constants.dart';
import 'package:flutter_node_auth/controller/api_controller.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.controller, required this.index, required this.size, this.radiusDouble = 15.0}) : super(key: key);
  final ApiController controller;
  final int index;
  final Size size;
  final double radiusDouble;
  double doubleInRange(Random source, num start, num end) => source.nextDouble() * (end - start) + start;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusDouble), topRight: Radius.circular(radiusDouble)),
              // boxShadow: const [BoxShadow(color: Colors.grey, offset: Offset(2, 8), blurRadius: 10.0)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusDouble), topRight: Radius.circular(radiusDouble)),
              child: CachedNetworkImage(
                //TODO: reverse
                imageUrl: '$kbaseUrl/${controller.products[index].productImages![0]}',
                placeholder: (context, url) => Container(
                  height: size.height * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: const Color(0xfff2f2f2),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusDouble), topRight: Radius.circular(radiusDouble)),
                    // boxShadow: const [BoxShadow(color: Colors.grey, offset: Offset(2, 8), blurRadius: 10.0)],
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
              // color: Colors.black,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radiusDouble), bottomRight: Radius.circular(radiusDouble)),
              // boxShadow: const [BoxShadow(color: Colors.grey, offset: Offset(2, 8), blurRadius: 10.0)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                Text(controller.products[index].name!.capitalize.toString(), style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: size.height * 0.01),
                const Text('\$200.00', style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
