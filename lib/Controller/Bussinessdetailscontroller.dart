import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Businessdetailscontoller extends GetxController {
  final businessName = TextEditingController(); // Address
  final city = TextEditingController(); // City
  final state = TextEditingController(); // State
  final postalCode = TextEditingController(); // Postal code
  final contactNo = TextEditingController(); // Contact number

  var selectedImagePaths = <String>[].obs;

  // Store both 'open' and 'close' times for each day
  var operatingTimes = {
    "Monday": {"open": "", "close": ""},
    "Tuesday": {"open": "", "close": ""},
    "Wednesday": {"open": "", "close": ""},
    "Thursday": {"open": "", "close": ""},
    "Friday": {"open": "", "close": ""},
    "Saturday": {"open": "", "close": ""},
    "Sunday": {"open": "", "close": ""},
  }.obs;

  // Amenities toggles
  var wheelchair = false.obs;
  var babyChangeStation = false.obs;
  var genderNeutralWashroom = false.obs;

  // Toggle methods for amenities
  void toggleWheelchair() {
    wheelchair.value = !wheelchair.value;
  }

  void toggleBabyChangeStation() {
    babyChangeStation.value = !babyChangeStation.value;
  }

  void addImagePath(String imagePath) {
    selectedImagePaths.add(imagePath);
    update();
  }

  void removeImagePath(String imagePath) {
    selectedImagePaths.remove(imagePath);
    update();
  }

  void toggleGenderNeutralWashroom() {
    genderNeutralWashroom.value = !genderNeutralWashroom.value;
  }

  // Update both open and close times for a specific day
  void updateOperatingTime(String day, String openTime, String closeTime) {
    operatingTimes[day] = {'open': openTime, 'close': closeTime};
  }

  // Method to collect all data
  void printAllData() {
    // Collect selected amenities
    List<String> amenities = [];
    if (wheelchair.value) amenities.add('Wheelchair accessible');
    if (babyChangeStation.value) amenities.add('Baby change station');
    if (genderNeutralWashroom.value) amenities.add('Gender neutral washroom');

    final data = {
      "photos": selectedImagePaths.toList(),
      "address": businessName.text,
      "city": city.text,
      "state": state.text,
      "postalCode": postalCode.text,
      "contactNo": contactNo.text,
      "operatingTimes": operatingTimes.map((day, times) => MapEntry(day, {"open": times['open'], "close": times['close']})),
      "amenities": amenities, // Add the dynamically collected amenities
    };

    // Convert the map to JSON for the API
    print(data);
  }

  @override
  void onClose() {
    businessName.dispose();
    city.dispose();
    state.dispose();
    postalCode.dispose();
    contactNo.dispose();
    super.onClose();
  }
}
