import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/components/addreceipt/AddReceipt.dart';
import 'package:front/models/button/SizedButton.dart';
import 'package:front/screen/MoneyRequests/AddCashRequest.dart';
import 'package:front/screen/groupscreens/GroupItem.dart';
import '../components/moneyrequests/MoneyRequestList.dart';
import '../entities/Expense.dart';
import '../models/button/ButtonSlideAnimation.dart';
import '../repository/api/ApiMoneyRequest.dart';

class MoneyRequest extends StatefulWidget {
  final groupId;

  const MoneyRequest({super.key, this.groupId});

  @override
  State<MoneyRequest> createState() => _MoneyRequestState();
}

class _MoneyRequestState extends State<MoneyRequest> {
  late List<Expense> requests = [];

  @override
  void initState() {
    super.initState();
    fetchMyGroupPayments();
  }

  void fetchMyGroupPayments() async {
    print("MoneyRequest에서 그룹소비내역 받아오기----");
    final MyGroupPaymentsJson = await getMyGroupPayments(widget.groupId, 0, 50); //받는 수 하드코딩함
    // print(MyGroupPaymentsJson.data);
    if (MyGroupPaymentsJson != null && MyGroupPaymentsJson.data is List) {
      setState(() {
        requests = (MyGroupPaymentsJson.data as List).map((item) => Expense.fromJson(item)).toList();
        //print(requests);
      });
    } else {
      print("정산 데이터를 불러오는 데 실패했습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        await Future.delayed(Duration.zero);
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => GroupItem(groupId: widget.groupId),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(-1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("내 정산 요청"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
              await Future.delayed(Duration.zero);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => GroupItem(groupId: widget.groupId),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var begin = Offset(-1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            },
          ),
          scrolledUnderElevation: 0,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 2.w)),
                Text('정산할 항목들을 선택해주세요'),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                Row(
                  children: [
                    SizedButton(
                      btnText: '영수증 일괄 등록',
                      onPressed: () => buttonSlideAnimation(context, AddReceipt(groupId: widget.groupId)),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5.w)),
                    SizedButton(
                      btnText: '현금 계산 추가',
                      onPressed: () => navigateToAddCashPage(),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                Expanded(
                  // ListView를 Expanded로 감싸기
                  child: SizedBox(
                    width: 400.w,
                    height: 594.h,
                    child: MoneyRequestList(
                      expenses: requests,
                      groupId: widget.groupId,
                      onSuccess: (value) {
                        fetchMyGroupPayments();
                      },
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> navigateToAddCashPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddCashRequest(
                groupId: widget.groupId,
              )),
    );

    if (result == true) {
      fetchMyGroupPayments();
    }
  }

  Future<void> navigateToAddReceiptPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReceipt(groupId: widget.groupId),
      ),
    );

    if (result == true) {
      fetchMyGroupPayments();
    }
  }
}
