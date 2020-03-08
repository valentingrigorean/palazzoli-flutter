import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:lightingPalazzoli/data/network/constants/endpoints.dart';
import 'package:lightingPalazzoli/generated/i18n.dart';
import 'package:lightingPalazzoli/models/activity.dart';
import 'package:lightingPalazzoli/models/register.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/ui/register/register_vm.dart';
import 'package:lightingPalazzoli/validators/email_rule.dart';
import 'package:lightingPalazzoli/validators/is_not_null_or_empty_rule.dart';
import 'package:lightingPalazzoli/validators/validator.dart';
import 'package:lightingPalazzoli/widgets/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterFormWidget extends StatefulWidget {
  final Function(Register mailInfo, Completer<bool> completer) onRegister;
  final Function() onSendLatter;
  final RegisterViewModel viewModel;

  const RegisterFormWidget(
      {Key key,
      @required this.viewModel,
      @required this.onRegister,
      @required this.onSendLatter})
      : super(key: key);

  @override
  _RegisterFormWidgetState createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final FocusNode _nodeEmail = FocusNode();
  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodeSurname = FocusNode();
  final FocusNode _nodeBusinessName = FocusNode();
  final FocusNode _nodeCommon = FocusNode();
  final FocusNode _nodeProvince = FocusNode();
  final FocusNode _nodeNation = FocusNode();
  final FocusNode _nodePhone = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String _email;
  String _name;
  String _surname;
  String _businessName;
  Activity _selectedActivity;
  String _common;
  String _province;
  String _nation;
  String _phone;

  bool _isChecked = false;

  bool _isPrivacyValid = true;
  bool _isActivityValid = true;

  @override
  void initState() {
    super.initState();
    FormKeyboardActions.setKeyboardActions(context, _buildConfig(context));
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }

  Widget _buildForm() {
    var localization = S.of(context);
    var theme = PalazzoliTheme.of(context);
    var errorLabelStyle =
        theme.textTheme.body1.copyWith(fontSize: 12, color: Colors.red);

    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CustomTextField(
                focusNode: _nodeEmail,
                nextFocusNode: _nodeName,
                onChanged: (value) => _email = value,
                label: localization.register_email,
                keyboardType: TextInputType.emailAddress,
                validator: Validator<String>([
                  IsNotNullOrEmptyRule(localization.error_field_empty),
                  EmailRule(localization.error_email_invalid)
                ]),
              ),
              CustomTextField(
                focusNode: _nodeName,
                nextFocusNode: _nodeSurname,
                onChanged: (value) => _name = value,
                label: localization.register_name,
                validator: Validator<String>(
                    [IsNotNullOrEmptyRule(localization.error_field_empty)]),
              ),
              CustomTextField(
                focusNode: _nodeSurname,
                nextFocusNode: _nodeBusinessName,
                onChanged: (value) => _surname = value,
                label: localization.register_surname,
                validator: Validator<String>(
                    [IsNotNullOrEmptyRule(localization.error_field_empty)]),
              ),
              CustomTextField(
                focusNode: _nodeBusinessName,
                nextFocusNode: _nodeCommon,
                label: localization.register_businessName,
                onChanged: (text) => _businessName = text,
                validator: Validator<String>(
                    [IsNotNullOrEmptyRule(localization.error_field_empty)]),
              ),
              CustomTextField(
                focusNode: _nodeCommon,
                nextFocusNode: _nodeProvince,
                label: localization.register_common,
                onChanged: (value) => _common = value,
                validator: Validator<String>([
                  IsNotNullOrEmptyRule(localization.error_field_empty),
                ]),
              ),
              CustomTextField(
                focusNode: _nodeProvince,
                nextFocusNode: _nodeNation,
                label: localization.register_province,
                onChanged: (value) => _province = value,
                validator: Validator<String>([
                  IsNotNullOrEmptyRule(localization.error_field_empty),
                ]),
              ),
              CustomTextField(
                focusNode: _nodeNation,
                nextFocusNode: _nodePhone,
                label: localization.register_nation,
                onChanged: (value) => _nation = value,
                validator: Validator<String>([
                  IsNotNullOrEmptyRule(localization.error_field_empty),
                ]),
              ),
              CustomTextField(
                focusNode: _nodePhone,
                label: localization.register_phone,
                onChanged: (value) => _phone = value,
                keyboardType: TextInputType.phone,
                validator: Validator<String>([
                  IsNotNullOrEmptyRule(localization.error_field_empty),
                ]),
              ),
              _buildDropDown(),
              _isActivityValid
                  ? Container(
                      height: 0,
                    )
                  : Text(
                      localization.error_field_empty,
                      style: errorLabelStyle,
                    ),
              _buildCheckBox(),
              _isPrivacyValid
                  ? Container(
                      height: 0,
                    )
                  : Text(
                      localization.register_privacy_required,
                      style: errorLabelStyle,
                    ),
              RaisedButton(
                onPressed: _handleRegisterTap,
                child: Text(localization.register_button),
                textColor: Colors.white,
              ),
              Platform.isIOS
                  ? GestureDetector(
                      onTap: _handleSendLatterTap,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          localization.register_latter,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.body1
                              .copyWith(fontSize: 11, color: Colors.black),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 8,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropDown() {
    var localization = S.of(context);
    var theme = PalazzoliTheme.of(context);
    var labelStyle = theme.textTheme.body1.copyWith(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);

    return Container(
      child: DropdownButton<Activity>(
        isExpanded: true,
        style: labelStyle,
        underline: Container(
          color: Colors.black45,
          height: 1,
        ),
        hint: Text(
          localization.register_selectActivity,
          style: labelStyle,
        ),
        value: _selectedActivity,
        items: widget.viewModel.items.items.map((Activity value) {
          return DropdownMenuItem<Activity>(
            value: value,
            child: Text(
              value.name,
              style: labelStyle,
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedActivity = newValue;
          });
        },
      ),
    );
  }

  Widget _buildCheckBox() {
    var localization = S.of(context);
    var theme = PalazzoliTheme.of(context);
    return Container(
        child: Center(
      child: Row(
        children: <Widget>[
          Checkbox(
            activeColor: theme.backgroundButtonColor,
            value: _isChecked,
            onChanged: _handlePrivacyCheck,
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                  text: localization.register_privacy,
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: localization.register_privacy_underline,
                      recognizer: TapGestureRecognizer()
                        ..onTap = _handlePrivacyTap,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    ));
  }

  void _handlePrivacyCheck(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void _handlePrivacyTap() async {
    const url = Endpoints.privacy;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _handleSendLatterTap() {
    if (!_validateSendLatter()) return;
    widget.onSendLatter();
  }

  bool _validateSendLatter() {
    bool result = true;
    _formKey.currentState.reset();

    if (!_isChecked) result = false;

    setState(() {
      _isPrivacyValid = _isChecked;
      _isActivityValid = true;
    });

    return result;
  }

  void _handleRegisterTap() async {
    if (!_validateRegister()) return;
    if (widget.onRegister == null) return;
    var completer = Completer<bool>();
    widget.onRegister(
        Register(
          email: _email,
          name: _name,
          surname: _surname,
          businessName: _businessName,
          selectActivity: _selectedActivity.id.toString(),
          common: _common,
          province: _province,
          nation: _nation,
          phone: _phone,
        ),
        completer);
    var result = await completer.future;
    if (result) _formKey.currentState.reset();
  }

  bool _validateRegister() {
    bool result = true;

    if (!_formKey.currentState.validate()) result = false;
    if (!_isChecked) result = false;
    if (_selectedActivity == null) result = false;

    setState(() {
      _isPrivacyValid = _isChecked;
      _isActivityValid = _selectedActivity != null;
    });
    return result;
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(nextFocus: true, actions: [
      KeyboardAction(focusNode: _nodeEmail),
      KeyboardAction(focusNode: _nodeName),
      KeyboardAction(focusNode: _nodeSurname),
      KeyboardAction(focusNode: _nodeBusinessName),
      KeyboardAction(focusNode: _nodeCommon),
      KeyboardAction(focusNode: _nodeProvince),
      KeyboardAction(focusNode: _nodeNation),
      KeyboardAction(focusNode: _nodePhone, displayCloseWidget: true),
    ]);
  }
}
