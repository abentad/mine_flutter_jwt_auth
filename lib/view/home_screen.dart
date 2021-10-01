import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_node_auth/view/components/home_components.dart';
import 'package:flutter_node_auth/view/settings.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  double topBarTopOffset = 10.0;
  double bottomBarBottomOffset = 20.0;

  _scrollListener() {
    //scroll up
    if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      setState(() {
        topBarTopOffset = -120.0;
        bottomBarBottomOffset = 20.0;
      });

      //scroll down
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      setState(() {
        topBarTopOffset = 10.0;
        bottomBarBottomOffset = -120.0;
      });
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        controller: _scrollController,
                        // physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: 20,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            margin: index.isEven || index == 0 ? const EdgeInsets.only(left: 20.0) : const EdgeInsets.only(right: 20.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xfff2f2f2),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [BoxShadow(color: Colors.grey, offset: Offset(2, 3), blurRadius: 10.0)],
                            ),
                            child: const Text('name'),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: topBarTopOffset,
                left: 0.0,
                right: 0.0,
                child: BuildTopBar(
                  size: size,
                  onProfileTap: () {
                    Get.to(() => const Settings(), transition: Transition.cupertino);
                  },
                ),
              ),
              Positioned(bottom: bottomBarBottomOffset, left: 0.0, right: 0.0, child: const BuildBottomBar()),
            ],
          ),
        ),
      ),
    );
  }
}
