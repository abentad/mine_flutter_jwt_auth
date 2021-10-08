import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  final String langCodeKey = 'langCode';
  final String countryCodeKey = 'countryCode';

  LanguageController() {
    loadLocale();
  }

  void loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(langCodeKey) != null) {
      Get.updateLocale(Locale(prefs.getString(langCodeKey) ?? "", prefs.getString(countryCodeKey) ?? ""));
    }
  }

  void changeLanguage({required String langCode, required String countryCode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Get.updateLocale(Locale(langCode, countryCode));
    await prefs.setString(langCodeKey, langCode);
    await prefs.setString(countryCodeKey, countryCode);
  }
}
