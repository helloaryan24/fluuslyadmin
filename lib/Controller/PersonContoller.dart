import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../All_Custom_Faction/shared_preferences_Page.dart';

class ProfileController extends GetxController {
  var searchController = TextEditingController().obs;
  var username = ''.obs;
  var email = ''.obs; // Add email observable

  @override
  void onInit() {
    super.onInit();
    _loadUsername();
    _loadEmail(); // Load email in onInit
  }

  Future<void> _loadUsername() async {
    String loadedUsername = await UserPreferences.loadUsername();
    username.value = loadedUsername;
  }

  Future<void> _loadEmail() async {
    String loadedEmail = await UserPreferences.loadEmail();
    email.value = loadedEmail; // Update email observable
  }

  Future<void> logout() async {
    UserPreferences.clearAllData();
    print("Yes");
  }
  // Future<void> logout() async {
  //   final url = Uri.parse('https://fluushy.devashishsoni.site/api/logout');
  //
  //   try {
  //     // Call the logout API
  //     final response = await http.post(url, headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Pass the token if required
  //     });
  //
  //     if (response.statusCode == 200) {
  //       // Handle success
  //       final jsonResponse = json.decode(response.body);
  //       print('Logout successful: $jsonResponse');
  //
  //       // Clear user data (example)
  //       await UserPreferences.clearAllData();
  //
  //       // Navigate to login page or show success message
  //       // Get.offAllNamed('/Login_Page');
  //     } else {
  //       // Handle failure
  //       print('Logout failed: ${response.body}');
  //       Get.snackbar('Error', 'Logout failed. Please try again.');
  //     }
  //   } catch (e) {
  //     // Handle error
  //     print('Error: $e');
  //     Get.snackbar('Error', 'An error occurred. Please try again.');
  //   }
  // }
}
