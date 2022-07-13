import 'package:bwcverification/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final Color textColor;
  final TextAlign? textAlign;
  final VoidCallback function;
  final int? maxLines;
  const CustomButton(
      {Key? key,
      required this.buttonColor,
      required this.text,
      this.textAlign,
      this.maxLines,
      this.textColor = Colors.black,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: buttonColor),
        child: CustomText(
          text: text,
          color: textColor,
          textAlign: textAlign,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
