import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:front/const/colors/Colors.dart';

class FinalButton extends StatefulWidget {
  final String btnText;
  final VoidCallback? onPressed;

  const FinalButton({
    required this.btnText,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<FinalButton> createState() => _ButtonState();
}

class _ButtonState extends State<FinalButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: STATE_COLOR,
        minimumSize: Size(
          298.w,
          45.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
      ),
      child: Text(widget.btnText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
