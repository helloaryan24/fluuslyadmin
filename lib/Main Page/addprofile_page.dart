import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../All_Custom_Faction/All_Widget.dart';
import '../All_Custom_Faction/Colors.dart';
import '../All_Custom_Faction/TextStyle.dart';
import '../Controller/Addprofilecontoller.dart';

class Addprofile_Page extends StatelessWidget {
  final Addprofilecontoller controller = Get.put(Addprofilecontoller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whitecolor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                      () => GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.greycolor,
                      backgroundImage: controller.selectedImagePath.value != null
                          ? FileImage(File(controller.selectedImagePath.value!))
                          : null,
                      child: controller.selectedImagePath.value == null
                          ? Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: AppColors.blackcolor,
                      )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text("Upload photo", style: TextStyles.MontserratRegular4),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.gradientcolor1,
                        AppColors.gradientcolor2,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 15, bottom: 25, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Business name", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "",
                          controller: controller.businessname,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: 20),
                        Text("First name", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "",
                          controller: controller.firstname,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: 20),
                        Text("Last name", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "",
                          controller: controller.lastname,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: 20),
                        Text("Date of birth", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "YYYY/MM/DD",
                          controller: controller.dateofbirth,
                          keyboardType: TextInputType.datetime,
                          maxLength: 10,
                        ),
                        SizedBox(height: 20),
                        Text("Contact no.", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "xxxxxxxxxx",
                          controller: controller.contactno,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CustomButton5(
                  style: TextStyles.Montserratbold1,
                  backgroundColor: AppColors.contcolor1,
                  onTap: () {
                    controller.submitProfile();
                  },
                  text: "Complete",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



