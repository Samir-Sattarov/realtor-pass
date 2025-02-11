import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_style.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final Function(String)? onTap;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final bool isPassword;
  final double? height;
  final String? title;
  final TextEditingController controller;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusBorder;
  final Function(String)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;

  const TextFormFieldWidget({
    Key? key,
    required this.hintText,
    this.onTap,
    this.title,
    this.onChanged,
    this.prefixIcon,
    this.isPassword = false,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.enabledBorder,
    this.focusBorder,
    this.height,
    this.maxLines,
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool obscure = false;
  String errorText = "";

  @override
  void initState() {
    obscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: EdgeInsets.only(left: 5.w, bottom: 6.h),
            child: Text(
              widget.title!,
              style: const TextStyle(
                color: Color(0xff979797),
                fontSize: 14,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines ?? 1,
          onFieldSubmitted: (value) {
            widget.onTap?.call(value);
          },
          onChanged: (value) => widget.onChanged?.call(value),
          validator: (value) {
            final data = widget.validator?.call(value ?? '');

            errorText = data ?? "";
            setState(() {});

            return data;
          },
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          cursorColor: AppStyle.dark,

          obscureText: obscure,
          // cursorWidth: 2,

          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: _suffixIcon(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ),
            errorStyle: const TextStyle(
              height: 0.01,
              fontSize: 0,
              color: Colors.transparent,
            ),
            hintText: widget.hintText.tr(),
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppStyle.grey,
            ),
            filled: true,
            fillColor: const Color(0xffF3F3F3),
            border: widget.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10).r,
                  borderSide: const BorderSide(
                    color: AppStyle.grey,
                    width: 1,
                  ),
                ),
            focusedBorder: widget.focusBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10).r,
                  borderSide: const BorderSide(
                    color: AppStyle.grey,
                    width: 2,
                  ),
                ),
            enabledBorder: widget.enabledBorder,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10).r,
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10).r,
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
          ),
        ),
        if (errorText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 10.w),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }

  _suffixIcon() {
    if (widget.isPassword == false) {
      return const SizedBox();
    } else {
      return IconButton(
        onPressed: () => setState(() => obscure = !obscure),
        icon: obscure
            ? const Icon(
                CupertinoIcons.eye_slash,
                color: Color(0xff626262),
              )
            : const Icon(
                CupertinoIcons.eye,
                color: Color(0xff626262),
              ),
      );
    }
  }
}
