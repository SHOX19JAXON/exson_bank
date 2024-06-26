import 'package:exson_bank/utils/size/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../utils/colors/app_colors.dart';


class CardNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const CardNumberInput({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  State<CardNumberInput> createState() => _CardNumberInputState();
}

class _CardNumberInputState extends State<CardNumberInput> {
  bool obscure = false;

  var maskFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          spreadRadius: 15,
          blurRadius: 10,
          offset: const Offset(10, 10),
        ),
      ]),
      // padding: EdgeInsets.symmetric(vertical: 5.w),
      child: TextField(
        obscureText: obscure,
        focusNode: widget.focusNode,
        controller: widget.controller,
        inputFormatters: [maskFormatter],
        onChanged: (v) {
          if (v.replaceAll(" ", "").length == 16) {
            widget.focusNode.unfocus();
          }
          setState(() {});
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    widget.controller.clear();
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          hintText: "Card number",
          hintStyle: const TextStyle(color: AppColors.black, fontSize: 14),
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.w, color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        keyboardType: TextInputType.number,
        // maxLines: ,
        textAlign: TextAlign.start,
      ),
    );
  }
}
