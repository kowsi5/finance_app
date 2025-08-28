
//   formatprofile() {
//     return Container(
//       margin: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Container(
//             // padding: const EdgeInsets.all(10.0),
//             height: 50,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                 ),
//                 color: AppColor.appprimary),
//             child: Center(
//               child: Text("customerdetails",
//                   style: AppStyle.txtHeader
//                       .copyWith(color: AppColor.colorwhite, fontSize: 22)),
//             ),
//           ),
//           Container(
//             // padding: const EdgeInsets.all(10.0),
//             height: 30,
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//                 // borderRadius: BorderRadius.only(
//                 //   topLeft: Radius.circular(10),
//                 //   topRight: Radius.circular(10),
//                 // ),
//                 color: AppColor.colorWhite),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Initate Collection",
//                     style: AppStyle.txtHeader
//                         .copyWith(color: AppColor.colorBlack, fontSize: 12)),
//                 Text(AppDateUtils.getCurrentTime(AppDateUtils.DatePattern9),
//                     style: AppStyle.txtHeader
//                         .copyWith(color: AppColor.colorBlack, fontSize: 12)),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(children: [
//               SizedBox(
//                 width: 10,
//               ),
//               ClipOval(
//                 child: Image.asset(
//                   'assets/images/home/person.png', // Replace with your image URL
//                   width: 80, // Set desired width
//                   height: 80, // Set desired height
//                   fit: BoxFit.cover, // Ensures the image covers the oval shape
//                 ),
//               ),
//               SizedBox(width: 10),
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                 _buildProfileDetail("Customer Name:", 'AMUTHA'),
//                 _buildProfileDetail("Guarantor Name:", 'N/A'),
//                 _buildProfileDetail("URN:", '99001012025689999'),
//                 _buildProfileDetail("Phone:", '95674 78654'),
//               ]),
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(8),
//                 color: Colors.grey[300],
//                 child: Text("Digital Payment Mode",
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               )
//             ]),
//           )
//         ],
//       ),
//     );
//   }

//   Widget
//   // Widget _buildPaymentModeSelection() {
//   //   return Row(
//   //     children: [
//   //       _buildRadioButton("UPI", digitalPaymentMode),
//   //       _buildRadioButton("Debit Card", digitalPaymentMode),
//   //       _buildRadioButton("Net Banking", digitalPaymentMode),
//   //     ],
//   //   );
//   // }



// //   Widget _buildPaymentTable() {
// //     return Column(
// //       children: [
// //         Table(
// //           border: TableBorder.all(color: Colors.blue),
// //           children: [
// //             _buildTableRow(
// //                 ["PRODUCT CODE", "ACCOUNT", "AMOUNT PAYABLE", "AMOUNT (Rs)"],
// //                 isHeader: true),
// //             _buildTableRow(["917", "567894356134587", "5510", "0"]),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
// //     return TableRow(
// //       children: cells.map((cell) {
// //         return Padding(
// //           padding: EdgeInsets.all(8),
// //           child: Text(
// //             cell,
// //             textAlign: TextAlign.center,
// //             style: TextStyle(
// //               fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
// //               color: isHeader ? Colors.white : Colors.black,
// //             ),
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }

// //   Widget _buildPaymentMadeBySelection() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
// //           child: Text("Payment made By:"),
// //         ),
// //         Row(
// //           children: [
// //             _buildRadioButton("Self", paymentMadeBy),
// //             _buildRadioButton("Batch", paymentMadeBy),
// //             _buildRadioButton("Third Party", paymentMadeBy),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildRadioButton(String title, String groupValue) {
// //     return Row(
// //       children: [
// //         Radio(
// //           value: title,
// //           groupValue: groupValue,
// //           onChanged: (value) {
// //             setState(() {
// //               if (groupValue == digitalPaymentMode) {
// //                 digitalPaymentMode = value.toString();
// //               } else {
// //                 paymentMadeBy = value.toString();
// //               }
// //             });
// //           },
// //         ),
// //         Text(title),
// //       ],
// //     );
// //   }

// //   Widget _buildRemarksField() {
// //     return Padding(
// //       padding: const EdgeInsets.only(top: 10),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text("Remarks:"),
// //           SizedBox(height: 5),
// //           TextField(
// //             decoration: InputDecoration(border: OutlineInputBorder()),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
