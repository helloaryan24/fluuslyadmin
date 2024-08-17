import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Businessdetailscontoller extends GetxController {
  final businessname = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final dateofbirth = TextEditingController();
  final contactno = TextEditingController();

  var allowNotificationForNewReviews = false.obs;
  var nearbyToilets = false.obs;
  var emailNotifications = false.obs;

  var operatingTimes = Map<String, String>().obs;

  void toggleAllowNotificationForNewReviews() {
    allowNotificationForNewReviews.value = !allowNotificationForNewReviews.value;
  }

  void toggleNearbyToilets() {
    nearbyToilets.value = !nearbyToilets.value;
  }

  void toggleEmailNotifications() {
    emailNotifications.value = !emailNotifications.value;
  }

  void updateOperatingTime(String day, String time) {
    operatingTimes[day] = time;
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
}