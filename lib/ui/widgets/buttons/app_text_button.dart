import 'package:flutter/material.dart';
import 'package:flutter_space_x/utils/utils.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const AppTextButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: Size(kMinInteractiveDimension, 32.0),
      ),
      child: Text(
        text.capitalize(),
        style: TextStyle(decoration: TextDecoration.underline),
      ),
    );
  }
}
