import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Usermodel.dart';
import 'All_Widget.dart';
import 'Image.dart';

class ApiUrls {
  static const String MainUrl = 'https://fluushy.devashishsoni.site/api/';
  static const String signuprapiapi = '${MainUrl}signup';
  static const String loginapi = '${MainUrl}signin';
  static const String signup = '${MainUrl}signup';
  static const String verifyotpapi = '${MainUrl}verify-otp';
  static const String resendotpapi = '${MainUrl}resend-otp';
  static const String bankapi = '${MainUrl}bank-details';
  static const String pickupapi = '${MainUrl}pickup-address';
  static const String businessdetailsapi = '${MainUrl}business-details';
  static const String toiletsaddapi = '${MainUrl}toilets';
  static const String _placesApiKey = 'AIzaSyDZWSWa5kSdIu0342P4VKoY2HTsBg3SNlE';

}

class AllApiFaction extends GetxController {

  Future<void> businessdetailsapi(String username, String email, String password,
      String passwordConfirmation) async {
    Get.dialog(
      lottieAnimation(Get.context!),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );

    try {
      final String signUpUrl = ApiUrls.businessdetailsapi;
      final signUpResponse = await http.post(
        Uri.parse(signUpUrl),
        body: {
          'username': username,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      Get.back(); // Close the loading dialog

      if (signUpResponse.statusCode == 201) {
        final jsonResponse = jsonDecode(signUpResponse.body);
        final success = jsonResponse['success'];
        final message = jsonResponse['message'];

        if (success == true) {
          showSuccessSnackbar(message,
              icon: Icons.check_circle,
              iconColor: Colors.green,
              containerColor: Colors.green);

        } else {
          showErrorSnackbar(message);
        }
      } else if (signUpResponse.statusCode == 400) {
        final jsonResponse = jsonDecode(signUpResponse.body);
        final message = jsonResponse['message'];

        if (message == "The email has already been taken.") {
          showErrorSnackbar("The email has already been taken.");
        } else {
          showErrorSnackbar(
              'An error occurred while processing your request: $message');
        }
      } else {
        showErrorSnackbar(
            'An error occurred while processing your request: ${signUpResponse.statusCode}');
      }
    } catch (e) {
      Get.back();
      showErrorSnackbar('An error occurred while processing your request: $e');
    }
  }
  Future<void> Signupapi(String username, String email, String password) async {
    Get.dialog(
      lottieAnimation(Get.context!),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );

    try {
      final String signUpUrl = ApiUrls.signup;
      final signUpResponse = await http.post(
        Uri.parse(signUpUrl),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      Get.back(); // Close the loading dialog

      if (signUpResponse.statusCode == 200) {
        final jsonResponse = jsonDecode(signUpResponse.body);
        final success = jsonResponse['success'];
        final message = jsonResponse['message'];
        if (success == true) {
          showSuccessSnackbar(message,
              icon: Icons.check_circle,
              iconColor: Colors.green,
              containerColor: Colors.green);
          Get.toNamed('/Otpverification_Screen',
            arguments: {'email': email}
          );
        } else {
          showErrorSnackbar(message);
        }
      } else if (signUpResponse.statusCode == 400) {
        final jsonResponse = jsonDecode(signUpResponse.body);
        final message = jsonResponse['message'];

        if (message == "The email has already been taken.") {
          showErrorSnackbar("The email has already been taken.");
        } else {
          showErrorSnackbar(
              'An error occurred while processing your request: $message');
        }
      } else {
        showErrorSnackbar(
            'An error occurred while processing your request: ${signUpResponse.statusCode}');
      }
    } catch (e) {
      Get.back();
      showErrorSnackbar('An error occurred while processing your request: $e');
    }
  }
  Future<void> loginin(String email, String password) async {
    print(email);
    print(ApiUrls.loginapi);
    Get.dialog(
      lottieAnimation(Get.context!),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );
    try {
      final String loginUrl = ApiUrls.loginapi;

      final loginResponse = await http.post(
        Uri.parse(loginUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      print('Response Status Code: ${loginResponse.statusCode}');
      print('Response Body: ${loginResponse.body}');
      final jsonResponse = jsonDecode(loginResponse.body);

      if (loginResponse.statusCode == 200) {
        final UserResponse userResponse = UserResponse.fromJson(jsonResponse);
        print('Success: ${userResponse.success}');

        Get.back(); // Dismiss loading dialog

        if (userResponse.success == true) {
          final message = userResponse.message;
          print('Message: $message');
          showSuccessSnackbar(message!,
              icon: Icons.check_circle,
              iconColor: Colors.green,
              containerColor: Colors.green);

          Data? data = userResponse.data;
          if (data != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('userId', data.id ?? 0);
            await prefs.setString('username', data.username ?? '');
            await prefs.setString('email', data.email ?? '');
            await prefs.setString('password', data.password ?? '');
            await prefs.setBool('isEmailVerified', data.isEmailVerified ?? false);
            await prefs.setInt('v', data.v ?? 0);
            await prefs.setString('token', data.token ?? '');
            await prefs.setBool('isLoggedIn', true);
          }

          // Navigate to the next screen
          Get.offAllNamed('/BottomBar_Page');
        } else {
          final message = userResponse.message;
          print('Error Message: $message');
          showSuccessSnackbar(message!,
              icon: Icons.error_outline,
              iconColor: Colors.red,
              containerColor: Colors.red);
        }
      } else {
        Get.back(); // Dismiss loading dialog
        final message = jsonResponse['message'];
        print('Error Message: $message');
        print(
            'Failed to log in. Status Code: ${loginResponse.statusCode}');
        showSuccessSnackbar('$message',
            icon: Icons.error_outline,
            iconColor: Colors.red,
            containerColor: Colors.red);
      }
    } catch (e) {
      Get.back(); // Dismiss loading dialog
      showSuccessSnackbar('An error occurred while processing your request',
          icon: Icons.error_outline,
          iconColor: Colors.red,
          containerColor: Colors.red);
      print('Exception occurred: $e');
    }
  }
  Future<void> confirmOtp(String otp, BuildContext context) async {
    final Map<String, dynamic> args = Get.arguments;
    final String email = args['email'];
    print('Email: $email');
    print('OTP: $otp');
    print('API URL: ${ApiUrls.verifyotpapi}');

    Get.dialog(
      lottieAnimation(context),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );

    try {
      final int otpInt = int.parse(otp); // Convert OTP to integer
      final String confirmOtpUrl = ApiUrls.verifyotpapi;
      final confirmOtpResponse = await http.post(
        Uri.parse(confirmOtpUrl),
        body: {'email': email, 'otp': otpInt.toString()}, // Send OTP as string
      );

      print('Response Status Code: ${confirmOtpResponse.statusCode}');
      print('Response Body: ${confirmOtpResponse.body}');
      final jsonResponse = jsonDecode(confirmOtpResponse.body);

      if (confirmOtpResponse.statusCode == 200) {
        final UserResponse userResponse = UserResponse.fromJson(jsonResponse);
        print('Success: ${userResponse.success}');

        Get.back(); // Dismiss loading dialog

        if (userResponse.success == true) {
          final message = userResponse.message;
          print('Message: $message');
          showSuccessSnackbar(message!,
              icon: Icons.check_circle,
              iconColor: Colors.green,
              containerColor: Colors.green);

          Data? data = userResponse.data;
          if (data != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('userId', data.id ?? 0);
            await prefs.setString('username', data.username ?? '');
            await prefs.setString('email', data.email ?? '');
            await prefs.setString('password', data.password ?? '');
            await prefs.setBool('isEmailVerified', data.isEmailVerified ?? false);
            await prefs.setInt('v', data.v ?? 0);
            await prefs.setString('token', data.token ?? '');
            await prefs.setBool('isLoggedIn', true);

          }

          // Navigate to the next screen
          Get.offAllNamed('/BottomBar_Page');
        } else {
          final message = userResponse.message;
          print('Error Message: $message');
          showSuccessSnackbar(message!,
              icon: Icons.error_outline,
              iconColor: Colors.red,
              containerColor: Colors.red);
        }
      } else {
        Get.back(); // Dismiss loading dialog
        final message = jsonResponse['message'];
        print('Error Message: $message');
        print(
            'Failed to verify OTP. Status Code: ${confirmOtpResponse.statusCode}');
        showSuccessSnackbar('$message',
            icon: Icons.error_outline,
            iconColor: Colors.red,
            containerColor: Colors.red);
      }
    } catch (e) {
      Get.back(); // Dismiss loading dialog
      showSuccessSnackbar('An error occurred while processing your request',
          icon: Icons.error_outline,
          iconColor: Colors.red,
          containerColor: Colors.red);
      print('Exception occurred: $e');
    }
  }
  Future<void> resendOtp() async {
    try {
      final args = Get.arguments as Map<String, dynamic>?;
      final email = args?['email'];
      // if (email == null) {
      //   _showErrorDialog('Missing email argument');
      //   return;
      // }

      final response = await http.post(Uri.parse(ApiUrls.resendotpapi), body: {'email': email});
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final message = responseData['message'] ?? 'OTP resent successfully';
        showSuccessSnackbar(
          message,
          icon: Icons.check_circle,
          iconColor: Colors.green,
          containerColor: Colors.green,
        );
      } else {
        showSuccessSnackbar(
          'Failed to resend OTP. Please try again.',
          icon: Icons.error_outline,
          iconColor: Colors.red,
          containerColor: Colors.red,
        );
      }
    } catch (e) {
      showSuccessSnackbar(
        'An error occurred while processing your request.',
        icon: Icons.error_outline,
        iconColor: Colors.red,
        containerColor: Colors.red,
      );
    }
  }

  Future<void> fetchNearbyPlaces(LatLng position, String type ,markers) async {
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${position.latitude},${position.longitude}'
        '&radius=1500&type=$type&key=${ApiUrls._placesApiKey}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          for (var place in data['results']) {
            final marker = Marker(
              markerId: MarkerId(place['place_id']),
              position: LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']),
              infoWindow: InfoWindow(title: place['name']),
            );
            markers.add(marker);
          }
        }
      } else {
        print('Failed to load places');
      }
    } catch (e) {
      print('Error fetching nearby places: $e');
    }
  }

  Future<void> AddnewToilet(Map<String, dynamic> data , BuildContext context) async {
    Get.dialog(
      lottieAnimation(Get.context!),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );

    try {
      final response = await http.post(
        Uri.parse(ApiUrls.toiletsaddapi),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        print('Data successfully sent to the server');
        Get.back(); // Close the loading dialog
        FocusScope.of(context).unfocus();
        showSuccessSnackbar("Add new Toilet",
            icon: Icons.check_circle,
            iconColor: Colors.green,
            containerColor: Colors.green);

      } else {
        showSuccessSnackbar('Failed add new Toilet, Try Again',
            icon: Icons.error_outline,
            iconColor: Colors.red,
            containerColor: Colors.red);
        Get.back(); // Close the loading dialog
        FocusScope.of(context).unfocus();

      }
    } catch (e) {
      showSuccessSnackbar('Failed add Toilet',
          icon: Icons.error_outline,
          iconColor: Colors.red,
          containerColor: Colors.red);
      Get.back(); // Close the loading dialog
      FocusScope.of(context).unfocus();

    }

  }

  void _showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: EdgeInsets.all(0),
        content: AlertDialogBox(message: message),
      ),
      barrierDismissible: false,
    );
  }
}
