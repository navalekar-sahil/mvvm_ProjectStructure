import 'package:flutter/material.dart';
import 'package:mvvm/res/color.dart';

class regulerButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final IconData? trailingIcon; // Add trailingIcon parameter
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final bool isEnabled;
  final bool loading;

  const regulerButton({
    required this.text,
    this.icon,
    this.trailingIcon, // Initialize trailingIcon parameter
    this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.borderRadius = 10.0,
    this.isEnabled = true,
    this.loading=false,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<regulerButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isEnabled ? widget.onPressed : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          widget.isEnabled ? widget.backgroundColor : Colors.grey,
        ),
        elevation: MaterialStateProperty.all(0), // Set elevation to 0
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            side: BorderSide(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null)
            Icon(widget.icon, color: widget.textColor),
          if (widget.icon != null) SizedBox(width: 8),

          widget.loading? const SizedBox(height:20,width:20,child: CircularProgressIndicator(color: AppColors.white,strokeWidth: 2,)) : Text(
            widget.text,
            style: TextStyle(color: widget.textColor, fontSize: 16),
          ),

          if (widget.trailingIcon != null) SizedBox(width: 8),
          if (widget.trailingIcon != null)
            Icon(widget.trailingIcon, color: widget.textColor),
        ],
      ),
    );
  }
}
