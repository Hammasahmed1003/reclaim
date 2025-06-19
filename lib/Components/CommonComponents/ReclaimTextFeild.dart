
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class ReclaimTextField extends StatefulWidget {
  final String hintText;
  final Color hintColor;
  final Color filledColor;
  final Color activeBorderColor;
  final TextEditingController controller;
  final bool isPassword;

   ReclaimTextField({
    super.key,
    required this.hintText,
    required this.filledColor,
    this.hintColor =  Colors.white,
    required this.activeBorderColor,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<ReclaimTextField> createState() => _ReclaimTextFieldState();
}

class _ReclaimTextFieldState extends State<ReclaimTextField> {
  bool _isObscure = true; // Password visibility state

  @override
  Widget build(BuildContext context) {
    return TextField(
     
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscure : false,
      style: TextStyle(fontSize: 16.sp, color: Colors.black), // Adjust text style
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: widget.hintColor),
        filled: true,
        fillColor: widget.filledColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: widget.activeBorderColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide:const BorderSide(color: Reclaimcolors.BorderColor, width: 1),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    _isObscure ? ReclaimIcon.openEye : ReclaimIcon.eyeClosed,
                    height: 20.h,
                    colorFilter:const ColorFilter.mode(Reclaimcolors.BasicBlue, BlendMode.srcIn),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
