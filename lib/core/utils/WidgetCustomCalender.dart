// import 'package:finance/core/utils/Support.dart';
// import 'package:flutter/material.dart';
// import '../res/AppColor.dart';
// import '../res/AppStyle.dart';
// import '../widgets/WidgetText.dart';
// import 'Constants.dart';

// class WidgetCustomCalender extends StatelessWidget {
//   const WidgetCustomCalender({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// double _currentPageHeight = 530.0; // Default height for the first page
// int selectedIndex = 0; // Default height for the first page

// Widget loadCustomCalender(
//     {required BuildContext context,
//     required PageController monthController,
//     required String selectedDate,
//     bool isShowHeader = true,
//     required VoidCallback? Function(BuildContext context, String selectedDate,
//             List<SpecialDa> specialDay)
//         onSelectDate,
//     required VoidCallback? Function(
//             BuildContext context, int month, String monthName, String year)
//         onMonthChange}) {
//   var screen = MediaQuery.of(context).size;
//   if (Constants.calendarData[selectedIndex].days.length > 42)
//     _currentPageHeight = isShowHeader ? 620 : 535;
//   else {
//     _currentPageHeight = isShowHeader ? 560 : 465;
//   }
//   return StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) => AnimatedContainer(
//         duration: Duration(milliseconds: 100),
//         height: _currentPageHeight,
//         child: PageView.builder(
//           controller: monthController,
//           itemCount: Constants.calendarData.length, // Number of pages
//           onPageChanged: (index) {
//             selectedIndex = index;
//             Constants.currentMonthIndex = index;
//             setState(() {
//               if (Constants.calendarData[selectedIndex].days.length > 42)
//                 _currentPageHeight = isShowHeader ? 650 : 530;
//               else {
//                 _currentPageHeight = isShowHeader ? 553 : 450;
//               }
//             });
//             List<String> monthSplit =
//                 Constants.calendarData[index].monthName.split(" ");
//             int month = convertToInteger(Constants.calendarData[index].month);
//             String monthName = monthSplit[0];
//             String year = monthSplit[1];
//             onMonthChange(context, month, monthName, year);
//           },
//           itemBuilder: (context, index) {
//             return Container(
//               margin: EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   if (isShowHeader) ...[
//                     Stack(
//                       children: [
//                         Column(
//                           children: [
//                             Container(
//                               width: double.maxFinite,
//                               color: AppColor.colorPrimary,
//                               padding: EdgeInsets.all(10),
//                               child: Column(
//                                 children: [
//                                   appText(
//                                       text: Constants
//                                           .calendarData[index].monthName,
//                                       style: AppStyle.txtHeader.copyWith(
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 22,
//                                           color: AppColor.colorWhite),
//                                       textAlign: TextAlign.center),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: double.maxFinite,
//                               color: Color(0xff527980),
//                               padding: EdgeInsets.all(10),
//                               margin: EdgeInsets.only(bottom: 10),
//                               child: Column(
//                                 children: [
//                                   appText(
//                                       text: Constants
//                                           .calendarData[index].monthNameTamil,
//                                       style: AppStyle.txtHeader.copyWith(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 14,
//                                           color: AppColor.colorWhite),
//                                       textAlign: TextAlign.center),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Positioned(
//                           top: 0,
//                           bottom: 0,
//                           left: 10,
//                           child: InkWell(
//                             onTap: () {
//                               int currentPage = convertToInteger(monthController
//                                   .page
//                                   .toString()
//                                   .replaceAll(".0", ""));
//                               if (currentPage > 0) {
//                                 monthController.animateToPage(
//                                   currentPage - 1,
//                                   duration: Duration(milliseconds: 300),
//                                   curve: Curves.easeInOut,
//                                 );
//                               }
//                             },
//                             child: Container(
//                               height: 35,
//                               width: 35,
//                               child: Center(
//                                 child: Image.asset(
//                                   'assets/leftarrrow.png',
//                                   color: AppColor.colorWhite,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 0,
//                           bottom: 0,
//                           right: 10,
//                           child: InkWell(
//                             onTap: () {
//                               int currentPage = convertToInteger(monthController
//                                   .page
//                                   .toString()
//                                   .replaceAll(".0", ""));
//                               if (currentPage <
//                                   (Constants.calendarData.length - 1)) {
//                                 monthController.animateToPage(
//                                   currentPage + 1,
//                                   duration: Duration(milliseconds: 300),
//                                   curve: Curves.easeInOut,
//                                 );
//                               }
//                             },
//                             child: Container(
//                               height: 35,
//                               width: 35,
//                               child: Center(
//                                 child: Image.asset(
//                                   'assets/rightarrow.png',
//                                   color: AppColor.colorWhite,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                   Wrap(
//                     spacing: 2.5,
//                     runSpacing: 2.5,
//                     children: Constants.calendarData[index].days.map((item) {
//                       return GestureDetector(
//                         onTap: () {
//                           if (item.type == null) {
//                             var monthNameSplit = Constants
//                                 .calendarData[index].monthName
//                                 .split(" ");
//                             var year = monthNameSplit[1];
//                             var month =
//                                 "00" + Constants.calendarData[index].month;
//                             var day = "00" + item.date;

//                             var date = year +
//                                 "-" +
//                                 month.substring(month.length - 2) +
//                                 "-" +
//                                 day.substring(day.length - 2);

//                             onSelectDate(context, date, item.specialDay);
//                           }
//                         },
//                         child: Container(
//                           width: (screen.width - 40) / 7,
//                           child: formatDate(item, Constants.calendarData[index],
//                               selectedDate),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             );
//           },
//         )),
//   );
// }

// formatDate(
//     DayElement dayElement, MonthElement monthElement, String selectedDate) {
//   return Column(
//     children: [
//       Visibility(
//         visible: dayElement.type != null && dayElement.type == "header",
//         child: Container(
//           height: 50,
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//             color: AppColor.headerBar,
//             borderRadius: BorderRadius.circular(1),
//           ),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 appText(
//                     text: dayElement.date,
//                     style: AppStyle.txtHeader.copyWith(
//                       fontSize: 16,
//                       color: AppColor.colorBlack,
//                       fontWeight: FontWeight.w700,
//                     )),
//                 appText(
//                     text: dayElement.tamilDate,
//                     style: AppStyle.txtSubTitle
//                         .copyWith(fontSize: 10, color: AppColor.colorBlack))
//               ],
//             ),
//           ),
//         ),
//       ),
//       Visibility(
//         visible: dayElement.type != null && dayElement.type == "empty",
//         child: Container(
//           width: double.maxFinite,
//           height: 75,
//           decoration: BoxDecoration(
//             color: AppColor.colorCalInActive,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               appText(
//                   text: dayElement.date,
//                   style: AppStyle.txtHeader
//                       .copyWith(color: AppColor.colorGrayLight))
//             ],
//           ),
//         ),
//       ),
//       Visibility(
//         visible: dayElement.type == null || dayElement.type == "",
//         child: Container(
//           height: 75,
//           decoration: BoxDecoration(
//               color: isSelectedDate(dayElement, monthElement, selectedDate)
//                   ? AppColor.colorPrimary
//                   : (dayElement.govtholiday == "yes")
//                       ? AppColor.colorRed
//                       : AppColor.colorCalDate,
//               borderRadius: BorderRadius.circular(10)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 2.0, left: 2, right: 2),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Expanded(
//                       child: appText(
//                           text: dayElement.tamilMonth,
//                           style: AppStyle.txtSubTitle.copyWith(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 6.5,
//                               color: isSelectedDate(
//                                       dayElement, monthElement, selectedDate) || (dayElement.govtholiday == "yes")
//                                   ? AppColor.colorWhite
//                                   : AppColor.colorSecondary)),
//                     ),
//                     appText(
//                         text: dayElement.tamilDate,
//                         style: AppStyle.txtSubTitle.copyWith(
//                           fontWeight: FontWeight.w800,
//                           fontSize: 12,
//                           color: isSelectedDate(
//                                   dayElement, monthElement, selectedDate) || (dayElement.govtholiday == "yes")
//                               ? AppColor.colorWhite
//                               : (dayElement.day == "Sun" ||
//                                       dayElement.day == "Sat")
//                                   ? AppColor.colorRed
//                                   : AppColor.colorSecondary,
//                         ))
//                   ],
//                 ),
//               ),
//               Center(
//                 child: appText(
//                     text: dayElement.date,
//                     style: AppStyle.txtHeader.copyWith(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w800,
//                       color: (isSelectedDate(
//                               dayElement, monthElement, selectedDate) || (dayElement.govtholiday == "yes"))
//                           ? AppColor.colorWhite
//                           : (dayElement.day == "Sun" || dayElement.day == "Sat")
//                               ? AppColor.colorRed
//                               : AppColor.colorBlack,
//                     )),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 3),
//                   child: Wrap(
//                     spacing: 1,
//                     runSpacing: 1,
//                     children: dayElement.specialDay.map((item) {
//                       return Container(
//                         padding: EdgeInsets.only(top:5, right: 0),
//                         child: Image.asset(formatCalenderImage(item.icon), height: 12),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }


// isSelectedDate(
//     DayElement dayElement, MonthElement monthElement, String selectedDate) {
//   var monthNameSplit = monthElement.monthName.split(" ");
//   var year = monthNameSplit[1];
//   var month = "00" + monthElement.month;
//   var day = "00" + dayElement.date;
//   var date = year +
//       "-" +
//       month.substring(month.length - 2) +
//       "-" +
//       day.substring(day.length - 2);
//   return (selectedDate == date);
// }
