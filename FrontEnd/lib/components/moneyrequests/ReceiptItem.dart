import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/components/moneyrequests/ReceiptMemberList.dart';
import 'package:front/components/moneyrequests/RequestMemberList.dart';
import 'package:front/entities/RequestReceiptDetail.dart';
import 'package:front/entities/RequestReceiptSub.dart';
import 'package:front/models/FlutterToastMsg.dart';
import 'package:front/repository/api/ApiMoneyRequest.dart';
import 'package:intl/intl.dart';

import '../../const/colors/Colors.dart';
import '../../entities/RequestReceipt.dart';
import '../../entities/RequestReceiptDetailMember.dart';
import '../../repository/api/ApiGroup.dart';
import '../../repository/api/ApiReceipt.dart';

class ReceiptItem extends StatefulWidget {
  final int groupId;
  final int paymentId;
  final RequestReceiptSub requestReceiptSub;
  final bool isSplit;

  const ReceiptItem(
      {Key? key,
      required this.requestReceiptSub,
      required this.groupId,
      required this.paymentId,
      this.isSplit = false})
      : super(key: key);

  @override
  _ReceiptItemState createState() => _ReceiptItemState();
}

class _ReceiptItemState extends State<ReceiptItem> {
  late RequestReceiptDetail requestReceiptDetail;
  bool isLoaded = false;
  bool isEditable = true;

  @override
  void initState() {
    super.initState();
    checkIfEditable();
  }

  void fetchReceiptDetailData({required Function onSuccess}) async {
    print('requestReceiptDetail 받아오기----');
    final response = await getReceiptDetail(widget.groupId, widget.paymentId,
        widget.requestReceiptSub.receiptDetailId);
    print(response.data);
    var tempRequestReceiptDetail = RequestReceiptDetail.fromJson(response.data);

    // if (tempRequestReceiptDetail.memberList == null ||
    //     tempRequestReceiptDetail.memberList!.isEmpty) {
    //   final groupMemberResponse = await getGroupMemberList(widget.groupId);
    //   final groupMembers =
    //       groupMemberResponse.data['groupMembersDtos'] as List<dynamic>;
    //   final memberList = groupMembers
    //       .map((memberJson) => RequestReceiptDetailMember(
    //           receiptDetailId: widget.requestReceiptSub.receiptDetailId,
    //           memberId: memberJson['kakaoId'] as String,
    //           name: memberJson['name'] as String,
    //           thumbnailImage: memberJson['thumbnailImage'] as String,
    //           amountDue: 0))
    //       .toList();
    //   tempRequestReceiptDetail.memberList = memberList;
    // }

    setState(() {
      requestReceiptDetail = tempRequestReceiptDetail;
      isLoaded = true;
    });
    onSuccess();
  }

  void checkIfEditable() async {
    bool canEdit =
        await getMoneyRequestIsLock(widget.groupId, widget.paymentId);
    setState(() {
      isEditable = !canEdit;
    });
  }

  void _showDetailsSheet() {
    if (isEditable)
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              if (!isLoaded) {
                fetchReceiptDetailData(onSuccess: () {
                  setModalState(() {
                    isLoaded = true;
                  });
                });
              }
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.requestReceiptSub.menu,
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '가격 ',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${NumberFormat('#,###').format(widget.requestReceiptSub.price)}원',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    isLoaded
                        ? ReceiptMemberList(
                            groupId: widget.groupId,
                            paymentId: widget.paymentId,
                            requestReceiptDetail: requestReceiptDetail,
                            modalCallback: (bool value) {
                              fetchReceiptDetailData(onSuccess: () {
                                setModalState(() {
                                  isLoaded = true;
                                });
                              });
                            },
                      isSplit: widget.isSplit,
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
              );
            },
          );
        },
      );
    else
      FlutterToastMsg("상세항목 설정이 필요하시면 정산 수정하기에서 lock를 해제해주세요.");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showDetailsSheet,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.requestReceiptSub.menu,
                    style: TextStyle(
                        color: Color(0xff201F22),
                        // fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.requestReceiptSub.count.toString(),
                    style: TextStyle(
                        color: Color(0xff201F22),
                        // fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${NumberFormat('#,###').format(widget.requestReceiptSub.price)}원',
                    style:
                        TextStyle(color: RECEIPT_TEXT_COLOR),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.w),
            height: 1,
            color: GREY_COLOR,
          ),
        ],
      ),
    );
  }
}
