// import 'package:flutter/material.dart';

// import '../res/AppColor.dart';
// import '../res/AppStyle.dart';
// import '../widgets/WidgetText.dart';
// import 'Constants.dart';

// class WidgetCustomMonthlyCalender extends StatelessWidget {
//   const WidgetCustomMonthlyCalender({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// int year = 2024;

// Widget loadCustomMonthCalender(
//     {required BuildContext context,
//     required String calType,
//     required int selectedMonth,
//     required int selectedYear,
//     required bool isNeedAll,
//     required VoidCallback? Function(
//             BuildContext context, int selectedMonth, int selectedYear)
//         onSelectMonth,
//     required VoidCallback? Function(BuildContext context, int selectedYear)
//         onChangeYear}) {
//   var screen = MediaQuery.of(context).size;
//   int year = selectedYear;
//   return StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) => Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(color: AppColor.darkGrey)),
//       margin: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 color: AppColor.colorPrimary,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(5),
//                   topRight: Radius.circular(5),
//                 ),
//                 border: Border.all(color: AppColor.colorPrimary)),
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(
//                     Icons.keyboard_arrow_left_outlined,
//                     color: AppColor.colorWhite,
//                   ),
//                   iconSize: 40.0,
//                   onPressed: () {
//                     setState(() {
//                       year = year - 1;
//                       selectedYear = year;
//                       onChangeYear(context, year);
//                     });
//                   },
//                 ),
//                 Expanded(
//                   child: appText(
//                       text: year.toString(),
//                       style: AppStyle.txtHeader.copyWith(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 22,
//                           color: AppColor.colorWhite),
//                       textAlign: TextAlign.center),
//                 ),
//                 IconButton(
//                   icon: const Icon(
//                     Icons.keyboard_arrow_right_outlined,
//                     color: AppColor.colorWhite,
//                   ),
//                   iconSize: 40.0,
//                   onPressed: () {
//                     setState(() {
//                       year = year + 1;
//                       selectedYear = year;
//                       onChangeYear(context, year);
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           if (isNeedAll) ...[
//             SizedBox(height: 10),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   onSelectMonth(context, -1, year);
//                 });
//               },
//               child: Container(
//                 width: (screen.width - 10) / 5,
//                 child: formatMonth(
//                     -1, (calType == "tm") ? "அனைத்து" : "All", selectedMonth),
//               ),
//             ),
//           ],
//           Container(
//             color: AppColor.colorWhite,
//             width: double.maxFinite,
//             padding: EdgeInsets.only(top: 10, bottom: 10),
//             child: Center(
//               child: Wrap(
//                 spacing: 10,
//                 runSpacing: 20,
//                 children: Constants.MonthPickerData.map((item) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         onSelectMonth(context, item.id, year);
//                       });
//                     },
//                     child: Container(
//                       width: (screen.width - 10) / 5,
//                       child: formatMonth(
//                           item.id,
//                           (calType == "tm") ? item.tmMonth : item.enMonth,
//                           selectedMonth),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// formatMonth(int id, String monthName, int selectedMonth) {
//   return Container(
//     height: 35,
//     decoration: BoxDecoration(
//       color:
//           (id == selectedMonth) ? AppColor.colorPrimary : AppColor.colorTrans,
//       borderRadius: BorderRadius.circular(5),
//     ),
//     child: Center(
//       child: appText(
//           text: monthName,
//           style: AppStyle.txtSubTitle.copyWith(
//             fontSize: 12,
//             color: (id == selectedMonth)
//                 ? AppColor.colorWhite
//                 : AppColor.colorBlack,
//           )),
//     ),
//   );
// }

// isSelectedDate(int id, int selectedMonth) {
//   return (id == selectedMonth);
// }
