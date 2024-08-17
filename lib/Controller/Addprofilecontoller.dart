import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../All_Custom_Faction/APIURL.dart';
import '../All_Custom_Faction/All_Widget.dart';
import 'package:http/http.dart' as http;

class Addprofilecontoller extends GetxController {
  final businessname = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final dateofbirth = TextEditingController();
  final contactno = TextEditingController();

  var currentLocation = "".obs;
  var isLocationFetched = false.obs;
  var selectedImagePath = Rxn<String>(); // Holds the image path

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    businessname.dispose();
    firstname.dispose();
    lastname.dispose();
    dateofbirth.dispose();
    contactno.dispose();
    super.onClose();
  }

  bool validateFields() {
    return businessname.text.isNotEmpty &&
        firstname.text.isNotEmpty &&
        lastname.text.isNotEmpty &&
        dateofbirth.text.isNotEmpty &&
        contactno.text.isNotEmpty &&
        selectedImagePath.value != null;
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> submitProfile() async {
    if (!validateFields()) {
      Get.snackbar('Error', 'Please fill all fields and upload an image.', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!validateDateFormat(dateofbirth.text)) {
      Get.snackbar('Error', 'Date of birth must be in YYYY/MM/DD format.', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final imageFile = File(selectedImagePath.value!);
    final businessnameText = businessname.text;
    final firstnameText = firstname.text;
    final lastnameText = lastname.text;
    final dateofbirthText = dateofbirth.text;
    final contactnoText = contactno.text;

    await businessdetailsapi(
      imageFile,
      businessnameText,
      firstnameText,
      lastnameText,
      dateofbirthText,
      contactnoText,
    );
  }

  Future<void> businessdetailsapi(
      File image,
      String businessname,
      String firstname,
      String lastname,
      String dateofbirth,
      String contactno,
      ) async {
    Get.dialog(
      lottieAnimation(Get.context!),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );

    try {
      final String signUpUrl = ApiUrls.businessdetailsapi;
      final request = http.MultipartRequest('POST', Uri.parse(signUpUrl))
        ..fields['business_name'] = businessname
        ..fields['first_name'] = firstname
        ..fields['last_name'] = lastname
        ..fields['dob'] = dateofbirth
        ..fields['contact_no'] = contactno;

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', image.path));
      }

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      Get.back(); // Close the loading dialog

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(responseString);
        final success = jsonResponse['success'];
        final message = jsonResponse['message'];

        if (success == true) {
          showSuccessSnackbar(message,
              icon: Icons.check_circle,
              iconColor: Colors.green,
              containerColor: Colors.green
          );

          Get.offAndToNamed('/BottomBar_Page');
        } else {
          showErrorSnackbar(message);
        }
      } else if (response.statusCode == 422) {
        final jsonResponse = jsonDecode(responseString);
        final message = jsonResponse['message'];

        if (message == "The email has already been taken.") {
          showErrorSnackbar("The email has already been taken.");
        } else {
          showErrorSnackbar(
              'An error occurred while processing your request: $message'
          );
        }
      } else {
        showErrorSnackbar(
            'An error occurred while processing your request: ${response.statusCode}'
        );
      }
    } catch (e) {
      Get.back();
      showErrorSnackbar('An error occurred while processing your request: $e');
    }
  }

  bool validateDateFormat(String date) {
    // Implement your date format validation logic here
    return RegExp(r'^\d{4}/\d{2}/\d{2}$').hasMatch(date);
  }
}
