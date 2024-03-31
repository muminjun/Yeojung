import 'package:flutter/material.dart';
import 'package:front/components/groups/GroupYesCal.dart';
import 'package:front/components/groups/GroupNoCal.dart';
import 'package:front/repository/api/ApiMyPage.dart'; // 필요한 경우 경로를 올바르게 수정하세요.

class GroupCheck extends StatelessWidget {
  final int groupId;

  GroupCheck({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getGroupSpend(groupId, {}),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(111111);
          print(snapshot.data);
          print(111111);
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            // 결제 내역이 있을 경우
            return GroupYesCal(groupId: groupId);
          } else if (snapshot.hasData && snapshot.data.isEmpty) {
            // 결제 내역이 없을 경우
            return GroupNoCal(groupId: groupId);
          } else if (snapshot.hasError) {
            // 에러가 발생한 경우
            return Center(child: Text('정산 내역을 불러올 수 없습니다.'));
          }
        }
        // 데이터 로딩 중
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
