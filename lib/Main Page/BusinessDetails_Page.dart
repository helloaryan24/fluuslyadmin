import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuslyadmin/All_Custom_Faction/Colors.dart';
import 'package:fluuslyadmin/All_Custom_Faction/TextStyle.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add intl package for date formatting

import '../All_Custom_Faction/All_Widget.dart';
import '../All_Custom_Faction/Image.dart';
import '../Controller/Bussinessdetailscontroller.dart';

class Businessdetails_Page extends StatelessWidget {
  final Businessdetailscontoller controller = Get.put(Businessdetailscontoller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whitecolor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business Details',
                  style: TextStyles.Montserratbold,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.greycolor.withOpacity(0.5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Images.wclogo),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 30,
                          width: 150,
                          alignment: Alignment.center,
                          child: Text(
                            'Promote my business',
                            style: TextStyles.Montserratbold5,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.gradientcolor2,
                              borderRadius: BorderRadius.circular(5)))
                    ],
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
                        Text("Address", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "",
                          controller: controller.businessname,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (query) {},
                        ),
                        SizedBox(height: 20),
                        Text("City", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "",
                          controller: controller.firstname,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (query) {},
                        ),
                        SizedBox(height: 20),
                        Text("State", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "",
                          controller: controller.lastname,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (query) {},
                        ),
                        SizedBox(height: 20),
                        Text("Postal code", style: TextStyles.MontserratRegular7),
                        SizedBox(height: 5),
                        buildInputField2(
                          hintText: "",
                          controller: controller.dateofbirth,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (query) {},
                        ),
                      ],
                    ),
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
                              'Monday',
                              'Tuesday',
                              'Wednesday',
                              'Thursday',
                              'Friday',
                              'Saturday',
                              'Sunday'
                            ];
                            final day = daysOfWeek[index];
                            return GestureDetector(
                              onTap: () async {
                                // Show date and time picker when tapped
                                final selectedValues = await showDateTimePicker(context, day);
                                if (selectedValues != null) {
                                  // Update the controller with selected values
                                  controller.updateOperatingTime(day, selectedValues['time']!);
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
                                      controller.operatingTimes[day] ?? 'Choose date',
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
                          value: controller.allowNotificationForNewReviews.value,
                          onChanged: (bool? value) {
                            controller.toggleAllowNotificationForNewReviews();
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
                          value: controller.nearbyToilets.value,
                          onChanged: (bool? value) {
                            controller.toggleNearbyToilets();
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
                          value: controller.emailNotifications.value,
                          onChanged: (bool? value) {
                            controller.toggleEmailNotifications();
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton4(
                        style: TextStyles.Montserratbold10,
                        backgroundColor: AppColors.whitecolor,
                        onTap: () {
                          // Get.toNamed('/Businessdetails_Page');
                        },
                        text: "Edit",
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: CustomButton5(
                        style: TextStyles.Montserratbold1,
                        backgroundColor: AppColors.contcolor1,
                        onTap: () {
Get.back();},
                        text: "Update",
                      ),
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

  // Function to show date and time picker
  Future<Map<String, String>?> showDateTimePicker(BuildContext context, String day) async {
    // Show time picker
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return null;

    final formattedTime = selectedTime.format(context);
    return {
      'day': day,
      'time': formattedTime,
    };
  }
}