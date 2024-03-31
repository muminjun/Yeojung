// // MyGroupRequest.dart 파일 내에서
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:front/entities/Expense.dart';
// import 'package:front/repository/api/ApiMoneyRequest.dart';
// import 'transaction_detail_page.dart'; // 상세보기 페이지 위젯을 import 합니다.
//
// class MyGroupRequest extends StatefulWidget {
//   final int groupId;
//
//   const MyGroupRequest({Key? key, required this.groupId}) : super(key: key);
//
//   @override
//   State<MyGroupRequest> createState() => _MyGroupRequestState();
// }
//
// class _MyGroupRequestState extends State<MyGroupRequest> {
//   late List<Expense> requests = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchMyGroupPayments();
//   }
//
//   void fetchMyGroupPayments() async {
//     final MyGroupPaymentsJson = await getMyGroupPayments(widget.groupId, 0, 10);
//     if (MyGroupPaymentsJson != null && MyGroupPaymentsJson.data is List) {
//       setState(() {
//         requests = (MyGroupPaymentsJson.data as List)
//             .map((item) => Expense.fromJson(item))
//             .toList();
//       });
//     } else {
//       print("정산 데이터를 불러오는 데 실패했습니다.");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('내가 요청한 정산 내역'),
//       ),
//       body: ListView.builder(
//         itemCount: requests.length,
//         itemBuilder: (context, index) {
//           var request = requests[index];
//           return Card(
//             child: ListTile(
//               title: Text(request.transactionSummary),
//               subtitle: Text('${request.transactionDate} - ${request.transactionBalance}'),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => MyGroupRequestDetail(transactionId: request.transactionId),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
