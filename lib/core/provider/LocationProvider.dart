// import 'dart:convert';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// // import '../../api_services/APIServices.dart';
// import '../model/ModelPlace.dart';
// import '../utils/Constants.dart';
// import '../utils/LocationUtils.dart';
// // import '../../providers/BaseProvider.dart';
// import '../utils/Support.dart';
// import 'CoreBaseProvider.dart';

// class LocationProvider extends CoreBaseProvider {
//   bool isSearchLoading = false;
//   bool isDrag = false;
//   String searchContent = "";
//   LatLng initialLocation = const LatLng(0.0, 0.0);
//   double latitude = 0.0;
//   double longitude = 0.0;
//   List<ModelPlace> listPlaces = [];

//   LocationProvider(context, screen, lat, lng) : super(context, null) {
//   }


//   clearPlaceList() {
//     listPlaces.clear();
//     notifyListeners();
//   }

//   updateIsSearchLoading(value) {
//     isSearchLoading = value;
//     notifyListeners();
//   }

//   updateLatLng(lat, lng) {
//     latitude = lat;
//     longitude = lng;
//   }

//   searchLocationAPI(String search) {
//     searchContent = search;
//     if (search.isEmpty) {
//       listPlaces.clear();
//       notifyListeners();
//     } else {
//       isSearchLoading = true;
//       String latlng = "$latitude,$longitude";
//       APIServices()
//           .searchLocationFromPlaceAPI(
//               search, latlng, getMapAPIKey())
//           .then((response) {
//         listPlaces.clear();
//         if (response.contains("predictions")) {
//           var predictions = json.decode(response)["predictions"];
//           for (int i = 0; i < predictions.length; i++) {
//             var placeId = predictions[i]["place_id"];
//             var fullName = predictions[i]["description"];
//             var primaryName = "";
//             var secondaryName = "";
//             if (predictions[i].toString().contains("structured_formatting")) {
//               var c1 = predictions[i]["structured_formatting"];
//               if (c1.toString().contains("main_text")) {
//                 primaryName = c1["main_text"];
//               }
//               if (c1.toString().contains("main_text")) {
//                 secondaryName = c1["secondary_text"];
//               }
//             }
//             var model = ModelPlace(
//                 full_name: fullName,
//                 place_id: placeId,
//                 primary_name: primaryName,
//                 secondary_name: secondaryName,
//                 latlng: "");
//             listPlaces.add(model);
//           }
//         } else {}
//         isSearchLoading = false;
//         notifyListeners();
//       });
//     }
//   }
// }
