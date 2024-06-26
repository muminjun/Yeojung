import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/const/colors/Colors.dart';
import 'package:front/providers/store.dart';
import 'package:intl/intl.dart';

class MySpendItem extends StatefulWidget {
  final Map<String, dynamic> spend;

  const MySpendItem({
    required this.spend,
    super.key,
  });

  @override
  State<MySpendItem> createState() => _MySpendItemState();
}

class _MySpendItemState extends State<MySpendItem> {
  var userManager = UserManager();

  @override
  void initState() {
    super.initState();
    userManager.loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    // 거래 금액 문자열 생성
    String transactionAmount = widget.spend['transactionTypeName'] == '출금'
        ? '-${NumberFormat('#,###').format(widget.spend['transactionBalance'])}원'
        : '${NumberFormat('#,###').format(widget.spend['transactionBalance'])}원';

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(widget.spend['transactionSummary'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "거래시간",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      '${widget.spend['transactionDate']} ${widget.spend['transactionTime']}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "거래금액",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      transactionAmount,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: widget.spend['transactionTypeName'] == '출금' ? RECEIPT_TEXT_COLOR : TEXT_COLOR,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "거래 후 잔액",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      '${NumberFormat('#,###').format(widget.spend['transactionAfterBalance'])}원',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
