import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import '../All_Custom_Faction/APIURL.dart';

class addnewtoiletcontoller extends GetxController {
  var searchController = TextEditingController().obs;
  var addressController = TextEditingController();
  var additionalDetailController = TextEditingController();
  var CleanlinessController = TextEditingController();
  var poopPriceController = TextEditingController();
  var peePriceController = TextEditingController();
  var showerPriceController = TextEditingController();
  var mapController = Rx<GoogleMapController?>(null);
  var currentLocation = LatLng(26.864608, 75.764692).obs;
  var locationName = 'Current Location'.obs;
  var suggestions = <String>[].obs;
  var markers = <Marker>{}.obs;
  RxBool showBottomSheet = false.obs;

  var selectedImagePaths = <String>[].obs;

  void addImagePath(String imagePath) {
    selectedImagePaths.add(imagePath);
    update();
  }
  void removeImagePath(String imagePath) {
    selectedImagePaths.remove(imagePath);
    update();
  }

// Update the updateToiletData method
  void updateToiletData(BuildContext context) async {
    List<String> amenities = [];

    // Add selected amenities to the list
    if (Wheelchair.value) amenities.add('Wheelchair accessible');
    if (babyChangeStation.value) amenities.add('Baby change station');
    if (soapAndPaperTowel.value) amenities.add('Soap and paper towel available');
    if (freeWifi.value) amenities.add('Free wifi');

    // Collect all the data
    final data = {
      'address': addressController.text,
      'additional_notes': additionalDetailController.text,
      'cleanliness': CleanlinessController.text,
      'price_for_poop': double.tryParse(poopPriceController.text) ?? 0.0,
      'price_for_pee': double.tryParse(peePriceController.text) ?? 0.0,
      'price_for_shower': double.tryParse(showerPriceController.text) ?? 0.0,
      'status': _getStatus(), // Determine the status
      'amenities': amenities, // Add the amenities array here
      'photos': selectedImagePaths.toList(),
      'longitude': currentLocation.value.longitude,
      'latitude': currentLocation.value.latitude,
    };

    // Print the data to the console for now
    print(jsonEncode(data));

    try {
      await AllApiFaction().AddnewToilet(data, context);

      // Clear all text fields and reset other state as needed
      addressController.clear();
      additionalDetailController.clear();
      CleanlinessController.clear();
      poopPriceController.clear();
      peePriceController.clear();
      showerPriceController.clear();
      selectedImagePaths.clear();
      markers.clear();
      isAvailable.value = false;
      isNotAvailable.value = false;
      isUnderMaintenance.value = false;
      Wheelchair.value = false;
      babyChangeStation.value = false;
      soapAndPaperTowel.value = false;
      freeWifi.value = false;

      // Optionally reset current location
      currentLocation.value = LatLng(26.864608, 75.764692);
      locationName.value = 'Current Location';
      mapController.value?.animateCamera(
        CameraUpdate.newLatLng(currentLocation.value),
      );
      markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: currentLocation.value,
          draggable: true,
          onDragEnd: (newPosition) {
            fetchAddressDetails(newPosition);
          },
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: locationName.value,
          ),
        ),
      );
    } catch (e) {
      print('Error sending data: $e');
    }
  }
  // Checkbox states for different features

  // Helper function to get the toilet status
  String _getStatus() {
    if (isAvailable.value) return 'Available';
    if (isNotAvailable.value) return 'Not Available';
    if (isUnderMaintenance.value) return 'Under Maintenance';
    return 'Unknown';
  }

  var Wheelchair = false.obs;
  var babyChangeStation = false.obs;
  var soapAndPaperTowel = false.obs;
  var freeWifi = false.obs;

  // Checkbox states for toilet status
  var isAvailable = false.obs;
  var isNotAvailable = false.obs;
  var isUnderMaintenance = false.obs;

  void toggleWheelchair() {
    Wheelchair.value = !Wheelchair.value;
  }

  void toggleBabyChangeStation() {
    babyChangeStation.value = !babyChangeStation.value;
  }

  void toggleSoapAndPaperTowel() {
    soapAndPaperTowel.value = !soapAndPaperTowel.value;
  }

  void toggleFreeWifi() {
    freeWifi.value = !freeWifi.value;
  }

  void toggleAvailable() {
    isAvailable.value = !isAvailable.value;
    if (isAvailable.value) {
      isNotAvailable.value = false;
      isUnderMaintenance.value = false;
    }
  }

  void toggleNotAvailable() {
    isNotAvailable.value = !isNotAvailable.value;
    if (isNotAvailable.value) {
      isAvailable.value = false;
      isUnderMaintenance.value = false;
    }
  }

  void toggleUnderMaintenance() {
    isUnderMaintenance.value = !isUnderMaintenance.value;
    if (isUnderMaintenance.value) {
      isAvailable.value = false;
      isNotAvailable.value = false;
    }
  }


  void updateLocation(LatLng newLocation, [String? name]) {
    currentLocation.value = newLocation;
    if (name != null) {
      locationName.value = name;
      addressController.text = name; // Update the address controller
    }
    mapController.value?.animateCamera(
      CameraUpdate.newLatLng(newLocation),
    );

    // Update marker position
    markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: newLocation,
        draggable: true,
        onDragEnd: (newPosition) {
          fetchAddressDetails(newPosition);
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: name ?? 'Selected Location',
        ),
      ),
    );
  }

  void toggleBottomSheet() {
    showBottomSheet.value = !showBottomSheet.value;
  }

  void searchLocation(String query) {
    LatLng searchedLocation = LatLng(26.864608, 75.764692); // Placeholder value
    updateLocation(searchedLocation, 'Searched Location');
  }

  Future<void> fetchAddressDetails(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String name = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        print('===== ${place.name} ${place.locality} ${place.administrativeArea} ${place.country}');

        updateLocation(position, name);
      }
    } catch (e) {
      print('Error fetching address details: $e');
    }
  }



  @override
  void onInit() {
    super.onInit();
    // Fetch initial nearby places (e.g., hospitals) when the controller is initialized
    AllApiFaction().fetchNearbyPlaces(currentLocation.value, 'hospital',markers);
    // Add initial draggable marker
    markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: currentLocation.value,
        draggable: true,
        onDragEnd: (newPosition) {
          fetchAddressDetails(newPosition);
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: locationName.value,
        ),
      ),
    );
  }
}
