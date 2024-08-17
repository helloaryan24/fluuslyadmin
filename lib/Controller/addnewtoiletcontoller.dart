import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

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

  // Checkbox states for different features
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

  final String _placesApiKey = 'AIzaSyDZWSWa5kSdIu0342P4VKoY2HTsBg3SNlE';

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

  void selectLocation(String placeId) {
    LatLng selectedLocation = LatLng(26.864608, 75.764692); // Placeholder value
    updateLocation(selectedLocation, 'Selected Location');
    searchController.value.clear();
    suggestions.clear();
  }

  Future<void> fetchNearbyPlaces(LatLng position, String type) async {
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${position.latitude},${position.longitude}'
        '&radius=1500&type=$type&key=$_placesApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null) {
          for (var place in data['results']) {
            final marker = Marker(
              markerId: MarkerId(place['place_id']),
              position: LatLng(place['geometry']['location']['lat'], place['geometry']['location']['lng']),
              infoWindow: InfoWindow(title: place['name']),
            );
            markers.add(marker);
          }
        }
      } else {
        print('Failed to load places');
      }
    } catch (e) {
      print('Error fetching nearby places: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch initial nearby places (e.g., hospitals) when the controller is initialized
    fetchNearbyPlaces(currentLocation.value, 'hospital');
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
