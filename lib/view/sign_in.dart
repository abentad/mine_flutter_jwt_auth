import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_auth/controller/auth_controller.dart';
import 'package:flutter_node_auth/view/home_screen.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.06),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Welcome back!', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: size.height * 0.02),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Sign in to your account', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.grey)),
                ),
                SizedBox(height: size.height * 0.06),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      fillColor: const Color(0xfff2f2f2),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 60),
                        child: Text("Email", style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600)),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _passwordController,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 18.0),
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      filled: true,
                      fillColor: const Color(0xfff2f2f2),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0), borderSide: const BorderSide(color: Color(0xfff2f2f2))),
                      suffixIcon: const Icon(Icons.visibility_off),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 30),
                        child: Text("Password", style: TextStyle(fontSize: 16.0, color: Colors.grey.shade600)),
                      ),
                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () {}, child: const Text('Forgot password?', style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MaterialButton(
                    onPressed: () async {
                      bool _result = await Get.find<AuthController>().signInUser(_emailController.text, _passwordController.text);
                      if (_result) {
                        Get.offAll(() => const HomeScreen(), transition: Transition.fade);
                      }
                    },
                    color: Colors.black,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    height: size.height * 0.07,
                    child: const Text("Continue", style: TextStyle(fontSize: 16.0, color: Colors.white)),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0)),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Sign up',
                          style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
