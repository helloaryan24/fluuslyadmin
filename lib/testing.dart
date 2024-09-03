// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
//
// import 'Controller/addnewtoiletcontoller.dart';
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   List<CustomLocation> locations = [];
//   List<String> suggestions = [];
//   LatLng? currentLocation;
//   final TextEditingController locationController = TextEditingController();
//   final addnewtoiletcontoller controller = Get.find<addnewtoiletcontoller>();
//   String googleApiKey = 'AIzaSyBAsTmejAByMGzlH9qkGbXr-mva057vtGM'; // Replace with your Google API Key
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//   }
//
//   Future<void> getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       setState(() {
//         currentLocation = LatLng(position.latitude, position.longitude);
//         locations.add(CustomLocation(
//           latitude: position.latitude,
//           longitude: position.longitude,
//           name: "My Location",
//         ));
//       });
//       if (currentLocation != null) {
//         mapController.animateCamera(CameraUpdate.newLatLng(currentLocation!));
//       }
//     } catch (e) {
//       print("Error fetching current location: $e");
//     }
//   }
//
//   Future<void> getPlaceSuggestions(String input) async {
//     if (input.isEmpty) {
//       setState(() {
//         suggestions.clear();
//       });
//       return;
//     }
//
//     // Define country codes for US, UK, and India
//     List<String> countryCodes = ['us', 'gb', 'in']; // Add more as needed
//
//     // Generate a component parameter for each country code
//     String components = countryCodes.map((code) => 'country:$code').join('|');
//
//     String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request = '$baseURL?input=$input&key=$googleApiKey&components=$components';
//
//     try {
//       var response = await http.get(Uri.parse(request));
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         var predictions = jsonResponse['predictions'] as List<dynamic>? ?? [];
//         setState(() {
//           suggestions = predictions
//               .map<String>(
//                   (prediction) => prediction['description'] as String? ?? '')
//               .toList();
//         });
//       } else {
//         print("Error fetching place suggestions: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Failed to fetch suggestions: $e");
//     }
//   }
//
//   Future<void> getLocationFromPlaceId(String description) async {
//     try {
//       List<Location> locationList = await locationFromAddress(description);
//       if (locationList.isNotEmpty) {
//         double latitude = locationList[0].latitude;
//         double longitude = locationList[0].longitude;
//         print('Latitude: $latitude, Longitude: $longitude');
//
//         // Reverse geocoding to get the address
//         List<Placemark> placemarks =
//         await placemarkFromCoordinates(latitude, longitude);
//         if (placemarks.isNotEmpty) {
//           Placemark placemark = placemarks[0];
//           String address =
//               '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
//           print('Address: $address');
//
//           setState(() {
//             // Add the new location and clear previous markers
//             locations.clear();
//             locations.add(CustomLocation(
//               latitude: latitude,
//               longitude: longitude,
//               name: description,
//             ));
//           });
//           mapController.animateCamera(CameraUpdate.newLatLng(
//             LatLng(latitude, longitude),
//           ));
//           // Clear suggestions after selecting a location
//           setState(() {
//             suggestions.clear();
//           });
//           locationController.text =
//               description; // Fill the TextField with the selected description
//
//           // Update the location in the controller
//           controller.updateLocation(description as LatLng);
//         }
//       }
//     } catch (e) {
//       print("Failed to get location: $e");
//     }
//   }
//
//   Set<Marker> _createMarkers() {
//     return locations.map((location) {
//       return Marker(
//         markerId: MarkerId(location.name),
//         position: LatLng(location.latitude, location.longitude),
//         infoWindow: InfoWindow(
//           title: location.name,
//         ),
//         icon: location.name == "My Location"
//             ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)
//             : BitmapDescriptor.defaultMarker,
//       );
//     }).toSet();
//   }
//
//   void _resetMap() {
//     if (currentLocation != null) {
//       mapController.animateCamera(CameraUpdate.newLatLng(currentLocation!));
//     }
//   }
//
//   void _printSelectedLocation() {
//     if (locations.isNotEmpty) {
//       CustomLocation lastLocation = locations.last;
//       print(
//           'Selected Location - Latitude: ${lastLocation.latitude}, Longitude: ${lastLocation.longitude}, Name: ${lastLocation.name}');
//     } else {
//       print('No location selected.');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Map with Search'),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: GestureDetector(
//         onTap: () {
//           _printSelectedLocation();
//         },
//         child: Container(
//             width: 200,
//             height: 50,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             alignment: Alignment.center,
//             child: Text("OK")
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             myLocationEnabled: true,
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//             initialCameraPosition: CameraPosition(
//               target: currentLocation ?? LatLng(37.7749, -122.4194),
//               zoom: 15.0,
//             ),
//             markers: _createMarkers(),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10,right: 80,top: 5),
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: locationController,
//                     decoration: InputDecoration(
//                       hintText: 'Search Location',
//                       prefixIcon: Icon(Icons.search, color: Colors.black),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 10.0),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         if (value.isEmpty) {
//                           suggestions.clear();
//                         } else {
//                           getPlaceSuggestions(value);
//                         }
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // Visibility widget to show/hide the suggestions container
//                 Visibility(
//                   visible: suggestions.isNotEmpty,
//                   child: Container(
//                     height: 200, // Set a height for the suggestion list
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: suggestions.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(
//                             suggestions[index],
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           onTap: () {
//                             getLocationFromPlaceId(suggestions[index]);
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CustomLocation {
//   final double latitude;
//   final double longitude;
//   final String name;
//
//   CustomLocation({
//     required this.latitude,
//     required this.longitude,
//     required this.name,
//   });
// }






//===================
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// import '../All_Custom_Faction/All_Widget.dart';
// import '../All_Custom_Faction/Colors.dart';
// import '../All_Custom_Faction/TextStyle.dart';
// import '../Controller/addnewtoiletcontoller.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   final addnewtoiletcontoller controller = Get.find<addnewtoiletcontoller>();
//   final TextEditingController locationController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Reset location and markers when navigating to the page
//     // controller.resetLocation();
//     controller.resetMarkers();
//
//     // Listen to changes in the locationName and update the TextField accordingly
//     controller.locationName.listen((location) {
//       locationController.text = location;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         backgroundColor: AppColors.gradientcolor1,
//         title: Text("Google Map", style: TextStyles.Montserratbold11),
//       ),
//       body: Stack(
//         children: [
//           // Google Maps
//           Obx(
//                 () => GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: controller.currentLocation.value,
//                 zoom: 15,
//               ),
//               myLocationEnabled: true,
//               myLocationButtonEnabled: true,
//               zoomControlsEnabled: true,
//               markers: Set<Marker>.of(controller.markers),
//               onMapCreated: (GoogleMapController gMapController) {
//                 controller.mapController.value = gMapController;
//               },
//               onTap: (LatLng position) {
//                 controller.fetchAddressDetails(position);
//               },
//             ),
//           ),
//           // TextField for autofill location
//           Align(
//             alignment: Alignment.topCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: locationController,
//                 decoration: InputDecoration(
//                   labelText: 'Location',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   prefixIcon: Icon(Icons.location_on),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           // OK Button or other widgets below
//         ],
//       ),
//       // Floating Action Button to go to current location
//     );
//   }
//
//   @override
//   void dispose() {
//     locationController.dispose();
//     super.dispose();
//   }
// }
