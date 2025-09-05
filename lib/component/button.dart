import 'package:npit_qr/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

enum ButtonVariant { primary, secondary, danger, ghost, outline }

ButtonStyle buttonStyle(ButtonVariant variant) {
  switch (variant) {
    case ButtonVariant.secondary:
      return const ButtonStyle();
    case ButtonVariant.ghost:
      return ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        // textStyle: WidgetStateProperty.all(
        //   TextStyle(
        //     color: Colors.red,
        //     // color: Color.fromARGB(255, 0, 0, 0),
        //   ),
        // ),
      );
    case ButtonVariant.outline:
      return ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(),
        ),
      );
    default:
      return ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 17, 18, 48),
        ),
      );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onPressed,
    this.disabled = false,
    this.loading = false,
    required this.child,
    this.variant = ButtonVariant.primary,
    this.bgColor,
    required this.heigth,
  });

  final Function()? onPressed;
  final bool disabled;
  final bool loading;
  final Widget child;
  final ButtonVariant variant;
  final Color? bgColor;
  final double heigth;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled || loading ? 0.85 : 1.0,
      child: SizedBox(
        width: double.infinity,
        height: heigth ?? 48.00,
        child: ElevatedButton(
          onPressed: disabled || loading
              ? null
              : onPressed, // Replace null with your actual callback function
          style: buttonStyle(variant).copyWith(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: variant == ButtonVariant.outline
                    ? BorderSide(color: Colors.grey.shade300)
                    : BorderSide.none,
              ),
            ),
            elevation: WidgetStateProperty.all(0),
            backgroundColor: bgColor != null
                ? WidgetStateProperty.all(bgColor)
                : buttonStyle(variant).backgroundColor,
          ),
          child: loading
              ? SizedBox(
                  width: size(context).width * 0.055,
                  height: size(context).width * 0.055,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
