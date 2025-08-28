// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';

// import '../../api_services/APIServices.dart';
// import '../provider/LocationProvider.dart';
// import '../res/AppColor.dart';
// import '../res/AppStyle.dart';
// import '../widgets/WidgetPopup.dart';
// import '../widgets/WidgetText.dart';
// import 'AppNavigator.dart';
// import 'Support.dart';

// class AddressFetchManager extends StatelessWidget {
//   String lat;
//   String lng;

//   AddressFetchManager({Key? key, required this.lat, required this.lng})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<LocationProvider>(
//       create: (context) => LocationProvider(context, "AddressFetch", lat, lng),
//       child: AddressFetchManagerPage(),
//     );
//   }
// }

// class AddressFetchManagerPage extends StatelessWidget {
//   AddressFetchManagerPage({super.key});

//   final TextEditingController _ttfSearch = TextEditingController();
//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();

//   String street_address = "";
//   String state = "";
//   String city = "";
//   String pincode = "";
//   String fetchAddress = "";

//   @override
//   Widget build(BuildContext context) {
//     var screen = MediaQuery.of(context).size;
//     var provider = Provider.of<LocationProvider>(context);
//     return Scaffold(
//       backgroundColor: AppColor.colorWhite,
//       appBar: AppBar(
//           shape: const Border(bottom: BorderSide(color: Color(0xFFA6A6A6))),
//           surfaceTintColor: AppColor.colorWhite,
//           elevation: 3,
//           centerTitle: true,
//           title: Text(
//             "Choose Address",
//             style: AppStyle.txtTitle
//                 .copyWith(fontSize: 20, color: AppColor.colorPrimary),
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColor.colorPrimary),
//             onPressed: () {
//               navigatePopCallBack(context, "");
//             },
//           )),
//       body: Consumer<LocationProvider>(
//         builder: (context, providerValue, child) => Container(
//             child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.only(left: 5, right: 5, top: 2),
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(color: AppColor.colorGray)),
//               child: Row(
//                 children: [
//                   const Icon(Icons.search),
//                   const SizedBox(width: 10),
//                   Expanded(
//                       child: TextField(
//                           autofocus: false,
//                           controller: _ttfSearch,
//                           keyboardType: TextInputType.text,
//                           style: AppStyle.textAppStyle,
//                           onChanged: (value) {
//                             if (fetchAddress != value.toString()) {
//                               provider.searchLocationAPI(
//                                   value.toLowerCase().toString());
//                             }
//                             if (value.toString().isEmpty) {
//                               provider.clearPlaceList();
//                             }
//                           },
//                           textInputAction: TextInputAction.go,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 0),
//                             hintText: "Search here",
//                             hintStyle: AppStyle.textStyleNormal.copyWith(
//                                 fontSize: 12, color: AppColor.colorAppHint),
//                           ))),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   providerValue.isSearchLoading
//                       ? Lottie.asset('assets/lottie/progress.json',
//                           width: 40, height: 40, repeat: true)
//                       : const SizedBox(
//                           height: 1,
//                         ),
//                 ],
//               ),
//             ),
//             Expanded(
//                 child: Stack(
//               children: [
//                 if (providerValue.listPlaces.isNotEmpty &&
//                     providerValue.searchContent.isNotEmpty)
//                   Container(
//                     margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
//                     decoration: AppStyle.cardDecoration,
//                     height: 250,
//                     child: ListView.separated(
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () {
//                               getAddressFromPlaces(
//                                   context,
//                                   providerValue.listPlaces[index].place_id,
//                                   provider);
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 const SizedBox(width: 10),
//                                 const Icon(
//                                   Icons.location_on,
//                                   color: AppColor.colorPrimary,
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         appText(
//                                             text: providerValue
//                                                         .listPlaces[index]
//                                                         .primary_name ==
//                                                     ""
//                                                 ? providerValue
//                                                     .listPlaces[index].full_name
//                                                 : providerValue
//                                                     .listPlaces[index]
//                                                     .primary_name,
//                                             style: AppStyle.textStyleBold
//                                                 .copyWith(
//                                                     fontSize: 14,
//                                                     color:
//                                                         AppColor.colorPrimary)),
//                                         const SizedBox(height: 2),
//                                         appText(
//                                             text: providerValue
//                                                 .listPlaces[index]
//                                                 .secondary_name,
//                                             style: AppStyle.textStyleBold
//                                                 .copyWith(
//                                                     fontSize: 10,
//                                                     color: AppColor
//                                                         .colorTextDark)),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                         separatorBuilder: (context, index) {
//                           return const Divider(
//                             color: AppColor.colorGrayLight,
//                             height: 1,
//                           );
//                         },
//                         itemCount: providerValue.listPlaces.length),
//                   ),
//               ],
//             )),
//           ],
//         )),
//       ),
//     );
//   }

//   moveCameraPosition(LocationProvider provider) async {
//     GoogleMapController controller = await _mapController.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       target: LatLng(provider.latitude, provider.longitude),
//       zoom: 14,
//     )));
//   }

//   Future<void> getAddressFromLatLong(
//       LocationProvider provider, lat, lng) async {
//     provider.updateIsSearchLoading(true);
//     String address = "";
//     await placemarkFromCoordinates(lat, lng).then((addresses) {
//       log(addresses.toString());
//       String street = "";
//       String thoroughFare = "";
//       String locality = "";
//       String administrativeArea = "";
//       String postalCode = "";
//       address = addresses[0].toString();
//       log(address.toString());

//       for (int i = 0; i < addresses.length; i++) {
//         if (street.isEmpty && addresses[i].street.toString().isNotEmpty) {
//           street = addresses[i].street.toString();
//         }
//         if (thoroughFare.isEmpty &&
//             addresses[i].thoroughfare.toString().isNotEmpty) {
//           thoroughFare = addresses[i].thoroughfare.toString();
//         }
//         if (locality.isEmpty && addresses[i].locality.toString().isNotEmpty) {
//           locality = addresses[i].locality.toString();
//           city = locality;
//         }
//         if (administrativeArea.isEmpty &&
//             addresses[i].administrativeArea.toString().isNotEmpty) {
//           administrativeArea = addresses[i].administrativeArea.toString();
//           state = administrativeArea;
//         }
//         if (postalCode.isEmpty &&
//             addresses[i].postalCode.toString().isNotEmpty) {
//           postalCode = addresses[i].postalCode.toString();
//           pincode = postalCode;
//         }
//       }

//       street_address = "$street, $thoroughFare";
//       provider.updateIsSearchLoading(false);
//       address =
//           "$street, $thoroughFare, $locality, $administrativeArea - $postalCode";
//       _ttfSearch.text = address;
//     }).onError((error, stackTrace) {
//       address = "Can't Find Location";
//       provider.updateIsSearchLoading(false);
//     });
//   }

//   getAddressFromLatLng(
//       BuildContext context, String latlng, LocationProvider provider) {
//     provider.updateIsSearchLoading(true);
//     APIServices().getAddressFromLatLng(latlng, getMapAPIKey()).then((response) {
//       provider.updateIsSearchLoading(false);
//       if (response.contains("results")) {
//         fetchAddress = json.decode(response)["results"][0]["formatted_address"];
//         _ttfSearch.text = fetchAddress;
//       } else {
//         failedSnackBar(
//             context: context, strMessage: "Sorry! Could not fetch address");
//       }
//     });
//   }

//   getAddressFromPlaces(
//       BuildContext context, String placeId, LocationProvider provider) {
//     provider.updateIsSearchLoading(true);
//     APIServices()
//         .getAddressFromPlaces(placeId, getMapAPIKey())
//         .then((response) async {
//       provider.updateIsSearchLoading(false);
//       if (response.contains("result")) {
//         provider.clearPlaceList();
//         var locations = json.decode(response)["result"];
//         if (locations.toString().contains("formatted_address")) {
//           fetchAddress = locations["formatted_address"];
//         }
//         if (locations.toString().contains("geometry")) {
//           locations = locations["geometry"];

//           if (locations.toString().contains("location")) {
//             // locations = locations["location"]["lat"];
//             var lat = locations["location"]["lat"].toString();
//             var lng = locations["location"]["lng"].toString();
//             _ttfSearch.text = fetchAddress;
//             var response = {
//               "street_address": street_address,
//               "city": city,
//               "state": state,
//               "pincode": pincode,
//               "full_address": fetchAddress,
//               "lat": lat,
//               "lng": lng
//             };
//             navigatePopCallBack(context, response);
//           }
//         }
//       } else {
//         failedSnackBar(
//             context: context, strMessage: "Sorry! Could not fetch address");
//       }
//     });
//   }
// }
