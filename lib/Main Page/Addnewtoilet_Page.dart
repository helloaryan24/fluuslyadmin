import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluuslyadmin/All_Custom_Faction/Colors.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../All_Custom_Faction/All_Widget.dart';
import '../All_Custom_Faction/Image.dart';
import '../All_Custom_Faction/TextStyle.dart';
import '../Controller/addnewtoiletcontoller.dart';
import '../testing.dart';
import 'Google_map.dart';

class Addnewtoilet_Page extends StatelessWidget {
  final addnewtoiletcontoller controller = Get.put(addnewtoiletcontoller());
  Future<void> _showCamera(BuildContext context) async {
    final pickedFile =
     await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      controller.addImagePath(pickedFile.path);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.gradientcolor1,title: Text("Add New toilet", style: TextStyles.Montserratbold11),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
        child: Column(
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
            SizedBox(height: 20),
            Text('Manually fill the address', style: TextStyles.MontserratMedium5),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientcolor1, AppColors.gradientcolor2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address", style: TextStyles.MontserratRegular7),
                    SizedBox(height: 5),
                    buildInputField2(
                      hintText: "",
                      controller: controller.addressController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (query) {},
                      readOnly: true

                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 30),
            // Row(
            //   children: [
            //     Expanded(child: Divider(color: AppColors.greycolor)),
            //     SizedBox(width: 10),
            //     Text("Or you can", style: TextStyles.MontserratRegular4),
            //     SizedBox(width: 10),
            //     Expanded(child: Divider(color: AppColors.greycolor)),
            //   ],
            // ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: (){
                Get.to(() => MapScreen());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text('📍Selected location on the Map', style: TextStyles.MontserratRegular7),
                decoration: BoxDecoration(
                  color: AppColors.gradientcolor2,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('Description', style: TextStyles.MontserratMedium5),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientcolor1, AppColors.gradientcolor2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Cleanliness", style: TextStyles.MontserratRegular7),
                    SizedBox(height: 5),
                    buildInputField2(
                      hintText: "",
                      controller: controller.cleanlinessController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (query) {},
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Amenities", style: TextStyles.Montserratbold1),
                    ),
                    SizedBox(height: 10),
                    Obx(
                          () => CheckboxListTile(
                        activeColor: AppColors.whitecolor,
                        checkColor: AppColors.blackcolor,
                        title: Text('Wheelchair accessible', style: TextStyles.MontserratRegular7),
                        value: controller.wheelchair.value,
                        onChanged: (value) {
                          controller.toggleWheelchair();
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Obx(
                          () => CheckboxListTile(
                        activeColor: AppColors.whitecolor,
                        checkColor: AppColors.blackcolor,
                        title: Text('Baby change station', style: TextStyles.MontserratRegular7),
                        value: controller.babyChangeStation.value,
                        onChanged: (value) {
                          controller.toggleBabyChangeStation();
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Obx(
                          () => CheckboxListTile(
                        activeColor: AppColors.whitecolor,
                        checkColor: AppColors.blackcolor,
                        title: Text('Soap and paper towel available', style: TextStyles.MontserratRegular7),
                        value: controller.soapAndPaperTowel.value,
                        onChanged: (value) {
                          controller.toggleSoapAndPaperTowel();
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Obx(
                          () => CheckboxListTile(
                        activeColor: AppColors.whitecolor,
                        checkColor: AppColors.blackcolor,
                        title: Text('Free wifi', style: TextStyles.MontserratRegular7),
                        value: controller.freeWifi.value,
                        onChanged: (value) {
                          controller.toggleFreeWifi();
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('Additional detail', style: TextStyles.MontserratMedium5),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientcolor1, AppColors.gradientcolor2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Additional Notes", style: TextStyles.MontserratRegular7),
                    SizedBox(height: 5),
                    buildInputField2(
                      hintText: "Enter any additional details here...",
                      controller: controller.additionalDetailController,
                      keyboardType: TextInputType.text,
                      onChanged: (query) {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('Toilet Status', style: TextStyles.MontserratMedium5),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientcolor1, AppColors.gradientcolor2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Select Status", style: TextStyles.MontserratRegular7),
                    SizedBox(height: 10),
                    Obx(() {
                      return Column(
                        children: [
                          CheckboxListTile(
                            activeColor: AppColors.whitecolor,
                            checkColor: AppColors.blackcolor,
                            title: Text("Available", style: TextStyles.MontserratRegular7),
                            value: controller.isAvailable.value,
                            onChanged: (value) {
                              controller.toggleAvailable();
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            activeColor: AppColors.whitecolor,
                            checkColor: AppColors.blackcolor,
                            title: Text("Not Available", style: TextStyles.MontserratRegular7),
                            value: controller.isNotAvailable.value,
                            onChanged: (value) {
                              controller.toggleNotAvailable();
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            activeColor: AppColors.whitecolor,
                            checkColor: AppColors.blackcolor,
                            title: Text("Under Maintenance", style: TextStyles.MontserratRegular7),
                            value: controller.isUnderMaintenance.value,
                            onChanged: (value) {
                              controller.toggleUnderMaintenance();
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text('Pricing', style: TextStyles.MontserratMedium5),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.gradientcolor1, AppColors.gradientcolor2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("For Poop", style: TextStyles.MontserratRegular7),
                    SizedBox(height: 5),
                    buildInputField2(
                      hintText: "Enter price in \$",
                      controller: controller.poopPriceController,
                      keyboardType: TextInputType.number,
                      onChanged: (query) {},
                    ),
                    SizedBox(height: 10),
                    Text("For Pee", style: TextStyles.MontserratRegular7),
                    SizedBox(height: 5),
                    buildInputField2(
                      hintText: "Enter price in \$",
                      controller: controller.peePriceController,
                      keyboardType: TextInputType.number,
                      onChanged: (query) {},
                    ),
                    SizedBox(height: 10),
                    Text("For Shower", style: TextStyles.MontserratRegular7),
                    SizedBox(height: 5),
                    buildInputField2(
                      hintText: "Enter price in \$",
                      controller: controller.showerPriceController,
                      keyboardType: TextInputType.number,
                      onChanged: (query) {},
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            CustomButton4(
              style: TextStyles.Montserratbold1,
              backgroundColor: AppColors.gradientcolor2,
              onTap: () {
                controller.updateToiletData(context);
                FocusScope.of(context).unfocus();

              },
              text: 'Update',
            ),
          ],
        ),
      ),
    );
  }
}






