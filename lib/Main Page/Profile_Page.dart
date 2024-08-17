import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../All_Custom_Faction/All_Widget.dart';
import '../All_Custom_Faction/Colors.dart';
import '../All_Custom_Faction/Image.dart';
import '../All_Custom_Faction/TextStyle.dart';
import '../Controller/PersonContoller.dart';

class Profile_Page extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whitecolor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10,bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.contcolor1,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/b1/16/19/b11619c2fe24e11459d15c8303d0b726.jpg',
                    ),
                  ),
                ),
                Text(
                  "Lena Doe",
                  style: TextStyles.Montserratbold10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update profile picture",
                      style: TextStyles.MontserratSemibold3,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.contcolor1,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Obx(() => buildInputField1(
                  hintText: "Business name",
                  controller: TextEditingController(text: controller.username.value),
                  keyboardType: TextInputType.name,
                  onChanged: (query) {
                    // controller.searchLocation(query);
                  },
                )
                ),
                SizedBox(height: 10),
                Obx(() => buildInputField1(
                  hintText: "Name",
                  controller: TextEditingController(text: controller.email.value),
                  keyboardType: TextInputType.name,
                  onChanged: (query) {
                    // controller.searchLocation(query);
                  },
                )),
                SizedBox(height: 10),
                buildInputField1(
                  hintText: "Date of birth",
                  controller: controller.searchController.value,
                  keyboardType: TextInputType.name,
                  onChanged: (query) {
                    // controller.searchLocation(query);
                  },
                ),
                SizedBox(height: 10),
                buildInputField1(
                  hintText: "Contact no",
                  controller: controller.searchController.value,
                  keyboardType: TextInputType.name,
                  onChanged: (query) {
                    // controller.searchLocation(query);
                  },
                ),
                SizedBox(height: 30),
                CustomButton3(
                  text: 'Support',
                  backgroundColor: AppColors.gradientcolor2,
                  onTap: () {
                    // handle button tap
                    Get.toNamed('/Support_Page');
                  },
                  style: TextStyles.MontserratMedium3,
                  assetImage: Images.Supportlogo, // specify your asset image path
                ),
                SizedBox(height: 10),
                CustomButton3(
                  text: 'Messages',
                  backgroundColor: AppColors.gradientcolor2,
                  onTap: () {
                    // handle button tap
                    Get.toNamed('/Message_Page');
                  },
                  style: TextStyles.MontserratMedium3,
                  assetImage: Images.Messageslogo, // specify your asset image path
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      // controller.logout();
                    },
                    child: Text(
                      "Log out",
                      style: TextStyles.MontserratSemibold5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );  }
}
