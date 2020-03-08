import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/validators/validator.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String label;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final Validator<String> validator;
  final ValueChanged<String> onChanged;

  const CustomTextField(
      {Key key,
      this.hint,
      this.label,
      this.keyboardType,
      this.focusNode,
      this.nextFocusNode,
      this.validator,
      this.onChanged})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (widget.onChanged != null) widget.onChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = PalazzoliTheme.of(context);
    var labelStyle = theme.textTheme.body1.copyWith(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);

    var hintStyle = labelStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: theme.unselectedTabBarColor);

    return TextFormField(
      style: hintStyle.copyWith(color: Colors.black),
      validator: widget.validator?.validate,
      controller: _controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      onFieldSubmitted: (_) =>
          _fieldFocusChanged(widget.focusNode, widget.nextFocusNode),
      decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: labelStyle,
          hintText: widget.hint,
          hintStyle: hintStyle),
    );
  }

  void _fieldFocusChanged(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
  }
}
