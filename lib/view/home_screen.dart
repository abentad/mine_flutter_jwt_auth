import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_node_auth/constants.dart';
import 'package:flutter_node_auth/controller/api_controller.dart';
import 'package:flutter_node_auth/model/product.dart';
import 'package:flutter_node_auth/view/components/home_components.dart';
import 'package:flutter_node_auth/view/product_add.dart';
import 'package:flutter_node_auth/view/settings.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'dart:math' as math;

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  List<String> categories = ["Cars", "Electronics", "Jobs", "Clothes", "Shoes", "House Hold"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.to(() => const ProductAdd(), transition: Transition.cupertino);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: _SliverAppBarDelegate(
                minHeight: size.height * 0.19,
                maxHeight: size.height * 0.19,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [BoxShadow(color: Colors.grey.shade300, offset: const Offset(2, 7), blurRadius: 10.0)],
                        ),
                        child: BuildTopBar(
                          size: size,
                          onProfileTap: () {
                            Get.to(() => const Settings(), transition: Transition.cupertino);
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Row(
                                children: [
                                  Container(
                                    margin: index == 0
                                        ? const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0)
                                        : const EdgeInsets.only(right: 10.0, bottom: 10.0),
                                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: const Color(0xff444941),
                                      border: Border.all(color: const Color(0xfff8f8f8), width: 1.0),
                                    ),
                                    child: const Center(child: Text('All', style: TextStyle(color: Colors.white))),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
                                  ),
                                ],
                              );
                            }
                            return Container(
                              margin:
                                  index == 0 ? const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0) : const EdgeInsets.only(right: 10.0, bottom: 10.0),
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: const Color(0xfff2f2f2),
                                border: Border.all(color: Colors.grey.shade300, width: 1.0),
                              ),
                              // ignore: unnecessary_string_interpolations
                              child: Center(child: Text('${categories[index - 1]}', style: const TextStyle(color: Colors.black))),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: Container(height: size.height * 0.02)),
            GetBuilder<ApiController>(
              builder: (controller) => SliverStaggeredGrid.countBuilder(
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 10.0,
                itemCount: controller.products.length,
                itemBuilder: (context, index) => ProductCard(
                  controller: controller,
                  index: index,
                  size: size,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.controller, required this.index, required this.size, this.radiusDouble = 15.0}) : super(key: key);
  final ApiController controller;
  final int index;
  final Size size;
  final double radiusDouble;
  @override
  Widget build(BuildContext context) {
    List<Product> _products = List.from(controller.products.reversed);

    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusDouble), topRight: Radius.circular(radiusDouble)),
              boxShadow: const [BoxShadow(color: Colors.grey, offset: Offset(2, 8), blurRadius: 10.0)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusDouble), topRight: Radius.circular(radiusDouble)),
              child: Image(
                // image: NetworkImage('$kbaseUrl/${controller.products[index].productImages![0]}'),
                image: NetworkImage('$kbaseUrl/${_products[index].productImages![0]}'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xfff2f2f2),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radiusDouble), bottomRight: Radius.circular(radiusDouble)),
              boxShadow: const [BoxShadow(color: Colors.grey, offset: Offset(2, 8), blurRadius: 10.0)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                // Text(controller.products[index].name!.capitalize.toString(), style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                Text(_products[index].name!.capitalize.toString(), style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
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
