import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:front/components/button/ButtonMiddle.dart';
import 'package:front/components/groups/GroupList.dart';

import '../components/moneyrequests/MoneyRequestList.dart';
import '../models/Expense.dart';

class MoneyRequest extends StatefulWidget {
  const MoneyRequest({super.key});



  @override
  State<MoneyRequest> createState() => _MoneyRequestState();
}

final List<dynamic> rawData = [
  {"장소": "초돈2", "금액": 78000, "날짜": "2024-05-01", "정산올림": true, "영수증존재": true},
  {"장소": "초돈3", "금액": 20000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈4", "금액": 30000, "날짜": "2024-05-01", "정산올림": true, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
  {"장소": "초돈5", "금액": 50000, "날짜": "2024-05-01", "정산올림": false, "영수증존재": true},
];

class _MoneyRequestState extends State<MoneyRequest> {
  @override
  Widget build(BuildContext context) {

    List<Expense> expenses = rawData.map((data) => Expense(
      place: data['장소'],
      amount: data['금액'],
      date: data['날짜'],
      isSettled: data['정산올림'],
      isReceipt: data['영수증존재'],
    )).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("내 정산 요청"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text('정산할 항목들을 선택해주세요'),
                Padding(padding: EdgeInsets.all(5)),
                Row(
                  children: [
                    ButtonMiddle(btnText: '영수증 일괄 등록',onPressed: (){print('object');},),
                    Padding(padding: EdgeInsets.all(10)),
                    ButtonMiddle(btnText: '현금 계산 추가',onPressed: (){print('object');},),
                  ],
                ),
                Expanded(
                  // ListView를 Expanded로 감싸기
                    child: SizedBox(width:368, child:MoneyRequestList(expenses: expenses),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}