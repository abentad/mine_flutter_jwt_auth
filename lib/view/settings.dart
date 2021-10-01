import 'package:flutter/material.dart';
import 'package:flutter_node_auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                GetBuilder<AuthController>(
                  builder: (controller) => Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 2.0), shape: BoxShape.circle),
                        child: CircleAvatar(
                          radius: 50.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image(
                              // image: NetworkImage('http://shopri.rentoch.com/${controller.currentUser!.profile}'),
                              image: NetworkImage('http://10.0.2.2:3000/${controller.currentUser!.profile}'),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.currentUser!.username!.capitalize.toString(), style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500)),
                          Text(controller.currentUser!.email!.capitalize.toString(), style: const TextStyle(fontSize: 14.0, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                MaterialButton(
                  onPressed: () {
                    Get.find<AuthController>().signOut();
                  },
                  minWidth: double.infinity,
                  color: Colors.black,
                  height: 50.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  child: const Text(
                    'Sign out',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
