import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_node_auth/view/components/home_components.dart';
import 'package:flutter_node_auth/view/settings.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
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
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              floating: true,
              expandedHeight: 50.0,
              elevation: 0.0,
              title: BuildTopBar(
                size: size,
                onProfileTap: () {
                  Get.to(() => const Settings(), transition: Transition.cupertino);
                },
              ),
            ),
            SliverToBoxAdapter(child: Container(height: size.height * 0.02)),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: size.height * 0.065,
                maxHeight: size.height * 0.065,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Row(
                          children: [
                            Container(
                              margin:
                                  index == 0 ? const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0) : const EdgeInsets.only(right: 10.0, bottom: 10.0),
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
                        margin: index == 0 ? const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 10.0) : const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: const Color(0xfff2f2f2),
                          border: Border.all(color: Colors.grey.shade300, width: 1.0),
                        ),
                        child: Center(child: Text('Category $index', style: const TextStyle(color: Colors.black))),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: Container(height: size.height * 0.02)),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.0,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: index.isEven || index == 0 ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(15),
                            // boxShadow: const [BoxShadow(color: Colors.grey, offset: Offset(2, 3), blurRadius: 10.0)],
                          ),
                          child: const Text('name'),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Padding(
                        padding: index.isEven || index == 0 ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                        child: const Text('AKG N700NCM2 Wireless Headphones', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Padding(
                        padding: index.isEven || index == 0 ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                        child: const Text('\$200.00', style: TextStyle(fontSize: 13.0, color: Colors.grey)),
                      ),
                    ],
                  );
                },
                childCount: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
