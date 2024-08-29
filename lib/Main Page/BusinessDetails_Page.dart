import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuslyadmin/All_Custom_Faction/Colors.dart';
import 'package:fluuslyadmin/All_Custom_Faction/TextStyle.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // Add intl package for date formatting

import '../All_Custom_Faction/All_Widget.dart';
import '../All_Custom_Faction/Image.dart';
import '../Controller/Bussinessdetailscontroller.dart';

class Businessdetails_Page extends StatelessWidget {
  final Businessdetailscontoller controller = Get.put(Businessdetailscontoller());
  Future<void> _showCamera(BuildContext context) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.addImagePath(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whitecolor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.gradientcolor1,title: Text(                  'Business Details',
             style: TextStyles.Montserratbold11),),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.greycolor.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Images.wclogo),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: (){
                          _showCamera(context); // Open the camera
                        },
                        child: Container(
                          height: 30,
                          width: 150,
                          alignment: Alignment.center,
                          child: Text('Promote my business', style: TextStyles.Montserratbold5),
                          decoration: BoxDecoration(
                            color: AppColors.gradientcolor2,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Obx(
                      () =>  Container(
                    height: controller.selectedImagePaths.isEmpty ?  0 : 120 , // Set the height of the container
                    width: double.infinity, // Keep the width to fill the screen
                    // color: Colors.red,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // Since height is 30, only one item per row
                        crossAxisSpacing: 0, // Space between items
                        mainAxisSpacing: 0,  // Space between items
                        childAspectRatio: 1, // Set aspect ratio to 1 for square items
                      ),
                      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                      itemCount: controller.selectedImagePaths.length,
                      itemBuilder: (context, index) {
                        String imagePath = controller.selectedImagePaths[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            // height: 50, // Set height of individual items
                            // width: 50, // Set width of individual items
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(File(imagePath)),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gradientcolor1.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0), // Adjusted padding
                              child: Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.removeImagePath(imagePath);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      size: 15, // Adjusted size for smaller delete icon
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
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
                      Text("Address", style: TextStyles.MontserratRegular7),
                      SizedBox(height: 5),
                      buildInputField2(
                        hintText: "",
                        controller: controller.businessName,  // Address
                        keyboardType: TextInputType.text,
                        onChanged: (query) {},
                      ),
                      SizedBox(height: 20),
                      Text("City", style: TextStyles.MontserratRegular7),
                      SizedBox(height: 5),
                      buildInputField2(
                        hintText: "",
                        controller: controller.city,  // City
                        keyboardType: TextInputType.text,
                        onChanged: (query) {},
                      ),
                      SizedBox(height: 20),
                      Text("State", style: TextStyles.MontserratRegular7),
                      SizedBox(height: 5),
                      buildInputField2(
                        hintText: "",
                        controller: controller.state,  // State
                        keyboardType: TextInputType.text,
                        onChanged: (query) {},
                      ),
                      SizedBox(height: 20),
                      Text("Postal code", style: TextStyles.MontserratRegular7),
                      SizedBox(height: 5),
                      buildInputField2(
                        hintText: "",
                        controller: controller.postalCode,  // Postal code
                        keyboardType: TextInputType.number,
                        onChanged: (query) {},
                      ),
                    ],
                  )

                ),
                ),
                SizedBox(
                  height: 30,
                ),
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
                        Text("Operating hours", style: TextStyles.Montserratbold1),
                        SizedBox(height: 20),
                        Text("Address", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(7, (index) {
                            final daysOfWeek = [
                              'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
                            ];
                            final day = daysOfWeek[index];
                            return GestureDetector(
                              onTap: () async {
                                // Show date and time picker for both Open and Close times
                                final selectedValues = await showDateTimePicker(context, day);
                                if (selectedValues != null) {
                                  // Update the controller with selected values for both open and close times
                                  controller.updateOperatingTime(day, selectedValues['open']!, selectedValues['close']!);
                                }
                              },
                              child: Obx(() => Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                decoration: BoxDecoration(
                                  color: AppColors.textfiledcolor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      day,
                                      style: TextStyles.Montserratbold7,
                                    ),
                                    Text(
                                      '-',
                                      style: TextStyles.Montserratbold7,
                                    ),
                                    Text(
                                      '${controller.operatingTimes[day]?['open'] ?? 'Open time'} - ${controller.operatingTimes[day]?['close'] ?? 'Close time'}',
                                      style: TextStyles.Montserratbold7,
                                    ),
                                  ],
                                ),
                              )),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.contcolor1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child:
                        Text("Amenities", style: TextStyles.Montserratbold1),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                            () => CheckboxListTile(
                          activeColor: AppColors.whitecolor,
                          checkColor: AppColors.blackcolor,
                          title: Text('Wheelchair accessbile',
                              style: TextStyles.MontserratRegular7),
                          value: controller.wheelchair.value,
                          onChanged: (bool? value) {
                            controller.toggleWheelchair();
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Obx(
                            () => CheckboxListTile(
                          activeColor: AppColors.whitecolor,
                          checkColor: AppColors.blackcolor,
                          title: Text('Baby change station',
                              style: TextStyles.MontserratRegular7),
                          value: controller.babyChangeStation.value,
                          onChanged: (bool? value) {
                            controller.toggleBabyChangeStation();
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Obx(
                            () => CheckboxListTile(
                          activeColor: AppColors.whitecolor,
                          checkColor: AppColors.blackcolor,
                          title: Text('Gender neutral washroom',
                              style: TextStyles.MontserratRegular7),
                          value: controller.genderNeutralWashroom.value,
                          onChanged: (bool? value) {
                            controller.toggleGenderNeutralWashroom();
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                CustomButton5(
                  style: TextStyles.Montserratbold1,
                  backgroundColor: AppColors.contcolor1,
                  onTap: () {
                    controller.printAllData(); // Print all data when "Update" is clicked
                    },
                  text: "Update",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to show date and time picker
  // Function to show time picker for both Open and Close times
  Future<Map<String, String>?> showDateTimePicker(BuildContext context, String day) async {
    // Show time picker for opening time
    TimeOfDay? openTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (openTime == null) return null;

    // Show time picker for closing time
    TimeOfDay? closeTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (closeTime == null) return null;

    final formattedOpenTime = openTime.format(context);
    final formattedCloseTime = closeTime.format(context);

    return {
      'open': formattedOpenTime,
      'close': formattedCloseTime,
    };
  }

}