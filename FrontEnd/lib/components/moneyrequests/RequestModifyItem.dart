import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../const/colors/Colors.dart';
import '../../entities/RequestMember.dart';
import 'AmountInputField.dart';

class RequestModifyItem extends StatefulWidget {
  final RequestMember member;
  final bool isLocked;
  final Function(bool) onLockedChanged;
  final Function(int) onAmountChanged;

  const RequestModifyItem({
    Key? key,
    required this.member,
    required this.isLocked,
    required this.onLockedChanged,
    required this.onAmountChanged,
  }) : super(key: key);

  @override
  _RequestModifyItemState createState() => _RequestModifyItemState();
}

class _RequestModifyItemState extends State<RequestModifyItem> {
  late TextEditingController amountController;
  late bool isLocked;

  @override
  void initState() {
    super.initState();
    isLocked = widget.isLocked;
    amountController = TextEditingController(
      text: widget.member.amount.toString(),
    );
  }

  void toggleSettled() {
    widget.onLockedChanged(!isLocked);
    setState(() {
      isLocked = !isLocked;
    });
  }

  // @override
  // void didUpdateWidget(covariant RequestModifyItem oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.isSettledState != widget.isSettledState) {
  //     setState(() {
  //       isSettledState = widget.isSettledState;
  //     });
  //   }
  // }
  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: SizedBox(
          width: 60.w,
          height: 60.h,
          child: Image.network(widget.member.profileUrl, fit: BoxFit.cover),
        ),
      ),
      title: Text(
        widget.member.name,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: AmountInputField(
        controller: amountController,
        onSubmitted: (value) {
          String removeCommaValue = value.replaceAll(',', '');
          widget.onAmountChanged(int.parse(removeCommaValue));
        },
      ),
      trailing: IconButton(
        icon: Icon(isLocked ? Icons.lock : Icons.lock_open),
        onPressed: () {
          toggleSettled();
        },
      ),
    );
  }
}
