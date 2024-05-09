// import 'package:flutter/material.dart';

// class Home_page extends StatefulWidget {
//   const Home_page({Key? key}) : super(key: key); // Corrected constructor

//   @override
//   State<Home_page> createState() => _Home_pageState();
// }

// class _Home_pageState extends State<Home_page> {
//   String? deviceId;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[200],
//       appBar: AppBar(
//         backgroundColor: Colors.brown[600],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () async {
//                 print("clicked");
//                 print(deviceId);
//                 setState(() {});
//               },
//               child: const Text("click"),
//             ),
//           ),
//           if (deviceId != null)
//             SizedBox(child: Text("$deviceId"))
//           else
//             SizedBox(),
//         ],
//       ),
//     );
//   }
// }
