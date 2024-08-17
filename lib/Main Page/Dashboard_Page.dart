import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluuslyadmin/All_Custom_Faction/All_Widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../All_Custom_Faction/Colors.dart';
import '../All_Custom_Faction/Image.dart';
import '../All_Custom_Faction/TextStyle.dart';

class Dashboard_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 70, // Adjust this value according to your design
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20), // Adjust this value according to your design
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gradientcolor1,
                                AppColors.gradientcolor2
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Image.asset(Images.wcminilogo),
                                SizedBox(height: 5),
                                Text(
                                  'Total toilets listed',
                                  style: TextStyles.MontserratRegular7,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '50,120',
                                  style: TextStyles.Montserratbold1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gradientcolor1,
                                AppColors.gradientcolor2
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Image.asset(Images.wcminilogo),
                                SizedBox(height: 5),
                                Text(
                                  'Total views and user',
                                  style: TextStyles.MontserratRegular7,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '5000',
                                  style: TextStyles.Montserratbold1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildGaugeSection('Total ratings'),
                  const SizedBox(height: 15),
                  _buildGaugeSection('Total reviews'),
                  const SizedBox(height: 15),
                  _buildGaugeSection('Total Visits'),
                  const SizedBox(height: 20),
                  CustomButton3(
                    text: 'Add toilet',
                    backgroundColor: AppColors.gradientcolor2,
                    onTap: () {
                      // handle button tap
                      Get.toNamed('/Addnewtoilet_Page');
                    },
                    style: TextStyles.MontserratMedium3,
                    assetImage: Images.wcminilogo, // specify your asset image path
                  ),
                  const SizedBox(height: 10),
                  CustomButton3(
                    text: 'Business details',
                    backgroundColor: AppColors.gradientcolor2,
                    onTap: () {
                      Get.toNamed('/Businessdetails_Page');
                    },
                    style: TextStyles.MontserratMedium3,
                    assetImage: Images.Businessdetails, // specify your asset image path
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 20,
            right: 20,
            child: Container(
              width: double.infinity,
              color: AppColors.whitecolor,
              child: Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 0),
                child: Text(
                  'Dashboard',
                  style: TextStyles.Montserratbold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGaugeSection(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  startAngle: 270,
                  endAngle: 270,
                  axisLineStyle: AxisLineStyle(
                    thickness: 1,
                    color: Colors.white,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: 100,
                      width: 0.2,
                      color: AppColors.circlecolor,
                      pointerOffset: 0.1,
                      cornerStyle: CornerStyle.bothFlat,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    RangePointer(
                      value: 80,
                      width: 0.2,
                      color: AppColors.gradientcolor1,
                      pointerOffset: 0.1,
                      cornerStyle: CornerStyle.bothCurve,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        '80',
                        style: TextStyles.Montserratbold2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 20),
        Text(
          label,
          style: TextStyles.MontserratSemibold6,
        ),
      ],
    );
  }
}
