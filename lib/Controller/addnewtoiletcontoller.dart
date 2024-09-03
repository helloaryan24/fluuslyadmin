import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import '../All_Custom_Faction/APIURL.dart';
import '../All_Custom_Faction/All_Widget.dart';

class addnewtoiletcontoller extends GetxController {
  var addressController = TextEditingController();
  var additionalDetailController = TextEditingController();
  var cleanlinessController = TextEditingController();
  var poopPriceController = TextEditingController();
  var peePriceController = TextEditingController();
  var showerPriceController = TextEditingController();
  var mapController = Rx<GoogleMapController?>(null);
  var currentLocation = LatLng(26.8851151, 75.6257473).obs;
  var locationName = 'Current Location'.obs;
  var markers = <Marker>{}.obs;
  RxBool showBottomSheet = false.obs;
  var selectedImagePaths = <String>[].obs;

  var wheelchair = false.obs;
  var babyChangeStation = false.obs;
  var soapAndPaperTowel = false.obs;
  var freeWifi = false.obs;
  var isAvailable = false.obs;
  var isNotAvailable = false.obs;
  var isUnderMaintenance = false.obs;

  @override
  void onInit() {
    super.onInit();
    AllApiFaction().fetchNearbyPlaces(currentLocation.value, 'hospital', markers);
    markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: currentLocation.value,
        draggable: true,
        onDragEnd: (newPosition) => fetchAddressDetails(newPosition),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: locationName.value),
      ),
    );
  }

  void addImagePath(String imagePath) {
    selectedImagePaths.add(imagePath);
  }

  void removeImagePath(String imagePath) {
    selectedImagePaths.remove(imagePath);
  }

  void resetMarkers() {
    markers.clear();
  }

  void updateLocation(LatLng newLocation, [String? name]) {
    currentLocation.value = newLocation;
    if (name != null) {
      locationName.value = name;
      addressController.text = name;
    }
    mapController.value?.animateCamera(CameraUpdate.newLatLng(newLocation));
    markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: newLocation,
        draggable: true,
        onDragEnd: (newPosition) => fetchAddressDetails(newPosition),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: name ?? 'Selected Location'),
      ),
    );
  }

  void toggleBottomSheet() {
    showBottomSheet.value = !showBottomSheet.value;
  }

  Future<void> fetchAddressDetails(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String name = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        updateLocation(position, name);
      }
    } catch (e) {
      print('Error fetching address details: $e');
    }
  }

  void toggleWheelchair() => wheelchair.value = !wheelchair.value;
  void toggleBabyChangeStation() => babyChangeStation.value = !babyChangeStation.value;
  void toggleSoapAndPaperTowel() => soapAndPaperTowel.value = !soapAndPaperTowel.value;
  void toggleFreeWifi() => freeWifi.value = !freeWifi.value;

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

  Future<void> updateToiletData(BuildContext context) async {
    // Check if required fields are not empty
    if (addressController.text.trim().isEmpty ||
        cleanlinessController.text.trim().isEmpty ||
        poopPriceController.text.trim().isEmpty ||
        peePriceController.text.trim().isEmpty ||
        showerPriceController.text.trim().isEmpty) {
      showErrorSnackbar('Please fill all required fields.');
      return;
    }

    List<String> amenities = [];
    if (wheelchair.value) amenities.add('Wheelchair accessible');
    if (babyChangeStation.value) amenities.add('Baby change station');
    if (soapAndPaperTowel.value) amenities.add('Soap and paper towel available');
    if (freeWifi.value) amenities.add('Free wifi');

    final data = {
      'address': addressController.text.trim(),
      'additional_notes': additionalDetailController.text.trim(),
      'cleanliness': cleanlinessController.text.trim(),
      'price_for_poop': double.tryParse(poopPriceController.text.trim()) ?? 0.0,
      'price_for_pee': double.tryParse(peePriceController.text.trim()) ?? 0.0,
      'price_for_shower': double.tryParse(showerPriceController.text.trim()) ?? 0.0,
      'status': _getStatus(),
      'amenities': amenities,
      'photos': selectedImagePaths.toList(),
      'longitude': currentLocation.value.longitude,
      'latitude': currentLocation.value.latitude,
    };

    print('Request Data: $data');

    await AllApiFaction().AddNewToilet(data, context);

    _resetFormState();
  }

  String _getStatus() {
    if (isAvailable.value) return 'Available';
    if (isNotAvailable.value) return 'Not Available';
    if (isUnderMaintenance.value) return 'Under Maintenance';
    return 'Unknown';
  }

  void _resetFormState() {
    addressController.clear();
    additionalDetailController.clear();
    cleanlinessController.clear();
    poopPriceController.clear();
    peePriceController.clear();
    showerPriceController.clear();
    selectedImagePaths.clear();
    markers.clear();
    isAvailable.value = false;
    isNotAvailable.value = false;
    isUnderMaintenance.value = false;
    wheelchair.value = false;
    babyChangeStation.value = false;
    soapAndPaperTowel.value = false;
    freeWifi.value = false;
    currentLocation.value = LatLng(26.864608, 75.764692);
    locationName.value = 'Current Location';
  }

  void showErrorSnackbar(String message) {
    showSuccessSnackbar(message, icon: Icons.error_outline, iconColor: Colors.red, containerColor: Colors.red);
  }
}
