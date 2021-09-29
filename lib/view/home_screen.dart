import 'package:flutter/material.dart';
import 'package:flutter_node_auth/controller/auth_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: GetBuilder<AuthController>(
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.currentUser!.username!.capitalize.toString()),
                Text(controller.currentUser!.email!.capitalize.toString()),
                Text(controller.currentUser!.userId!.capitalize.toString()),
                SizedBox(height: size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MaterialButton(
                    onPressed: () {
                      controller.signOut();
                    },
                    child: const Text('Sign out', style: TextStyle(color: Colors.white)),
                    minWidth: double.infinity,
                    height: 50.0,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
