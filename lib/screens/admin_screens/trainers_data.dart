// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class ManageTrainersTab extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.builder(
// //       padding: EdgeInsets.all(16),
// //       itemCount: 5,
// //       itemBuilder: (context, index) {
// //         return Card(
// //           color: Color(0xFFCDEAC0),
// //           margin: EdgeInsets.only(bottom: 12),
// //           child: InkWell(
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => TrainerDetailsPage(
// //                     trainer: {
// //                       "name": "Trainer ${index + 1}",
// //                       "expertise": "Swimming",
// //                       "performance": "Excellent",
// //                       "productivity": "High",
// //                       "learnersCount": 20,
// //                     },
// //                   ),
// //                 ),
// //               );
// //             },
// //             child: ListTile(
// //               leading: CircleAvatar(
// //                 backgroundColor: Color(0xFF92C287),
// //                 child: Icon(Icons.person, color: Colors.white),
// //               ),
// //               title: Text("Trainer ${index + 1}", style: TextStyle(fontWeight: FontWeight.bold)),
// //               subtitle: Text("Expertise: Swimming"),
// //               trailing: Icon(Icons.arrow_forward_ios, size: 16),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
//
// class TrainerDetailPage extends StatelessWidget {
//   final Map<String, String> trainerInfo;
//
//   const TrainerDetailPage({Key? key, required this.trainerInfo}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF659F62),
//         title: Text(trainerInfo['name'] ?? 'Trainer Details', style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Name: ${trainerInfo['name']}", style: TextStyle(fontSize: 18)),
//             SizedBox(height: 10),
//             Text("Work: ${trainerInfo['work']}", style: TextStyle(fontSize: 18)),
//             SizedBox(height: 10),
//             Text("Email: ${trainerInfo['email']}", style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }
// }
