import 'package:flutter/material.dart';
import 'package:sickness_manager/app/presentation/presentation.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onSubmitted,
    this.obscureText = false,
  });

  final String labelText;
  final String? errorText;
  final Function(String)? onSubmitted;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.horizontalMd,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onSubmitted: widget.onSubmitted,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        cursorColor: AppColors.black,
        decoration: InputDecoration(
          labelText: widget.labelText,
          errorText: widget.errorText,
          labelStyle: TextStyles.body,
          errorStyle: TextStyles.footnote.copyWith(color: AppColors.orange),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white),
            borderRadius: BorderRadius.circular(Dimensions.xs),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white),
            borderRadius: BorderRadius.circular(Dimensions.xs),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white),
            borderRadius: BorderRadius.circular(Dimensions.xs),
          ),
          filled: true,
          fillColor: AppColors.white,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon:
              widget.obscureText
                  ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.black,
                    ),
                    onPressed: _toggleObscureText,
                  )
                  : null,
        ),
        style: TextStyles.body,
      ),
    );
  }
}
