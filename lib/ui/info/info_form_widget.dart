import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:lightingPalazzoli/generated/i18n.dart';
import 'package:lightingPalazzoli/models/mail_info.dart';
import 'package:lightingPalazzoli/palazzoli_theme.dart';
import 'package:lightingPalazzoli/validators/compare_rule.dart';
import 'package:lightingPalazzoli/validators/email_rule.dart';
import 'package:lightingPalazzoli/validators/is_not_null_or_empty_rule.dart';
import 'package:lightingPalazzoli/validators/validator.dart';
import 'package:lightingPalazzoli/widgets/custom_radio.dart';
import 'package:lightingPalazzoli/widgets/custom_text_field.dart';

class InfoFormWidget extends StatefulWidget {
  final String productCode;
  final Function(MailInfo mailInfo, Completer<bool> completer) onSend;

  const InfoFormWidget({Key key, this.productCode, @required this.onSend})
      : super(key: key);

  @override
  _InfoFormWidgetState createState() => _InfoFormWidgetState();
}

class _InfoFormWidgetState extends State<InfoFormWidget> {
  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodeSurname = FocusNode();
  final FocusNode _nodeEmail = FocusNode();
  final FocusNode _nodeConfirmEmail = FocusNode();
  final FocusNode _nodePhone = FocusNode();
  final FocusNode _nodeMessage = FocusNode();
  final _formKey = GlobalKey<FormState>();

  String _firstName;
  String _lastName;
  String _email;
  String _phone;
  String _message;

  int _type = InfoTypePrice;

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

    var messageStyle = theme.textTheme.body1.copyWith(
        fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black);

    return Card(
      margin: const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomTextField(
                focusNode: _nodeName,
                nextFocusNode: _nodeSurname,
                onChanged: (value) => _firstName = value,
                label: localization.info_label_name,
                validator: Validator<String>(
                    [IsNotNullOrEmptyRule(localization.error_field_empty)]),
              ),
              CustomTextField(
                focusNode: _nodeSurname,
                nextFocusNode: _nodeEmail,
                onChanged: (value) => _lastName = value,
                label: localization.info_hint_surname,
                validator: Validator<String>(
                    [IsNotNullOrEmptyRule(localization.error_field_empty)]),
              ),
              CustomTextField(
                focusNode: _nodeEmail,
                nextFocusNode: _nodeConfirmEmail,
                label: localization.info_hint_email,
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) => _email = text,
                validator: Validator<String>([
                  IsNotNullOrEmptyRule(localization.error_field_empty),
                  EmailRule(localization.error_email_invalid)
                ]),
              ),
              CustomTextField(
                focusNode: _nodeConfirmEmail,
                nextFocusNode: _nodePhone,
                label: localization.info_hint_confirm_email,
                keyboardType: TextInputType.emailAddress,
                validator: Validator<String>([
                  IsNotNullOrEmptyRule(localization.error_field_empty),
                  CompareRule(localization.error_email_not_the_same, _getEmail)
                ]),
              ),
              CustomTextField(
                focusNode: _nodePhone,
                nextFocusNode: _nodeMessage,
                label: localization.info_hint_phone,
                onChanged: (value) => _phone = value,
                keyboardType: TextInputType.phone,
                validator: Validator<String>([
                  IsNotNullOrEmptyRule(localization.error_field_empty),
                ]),
              ),
              _buildRadioGroup(),
              Theme(
                data: theme
                    .toThemeData()
                    .copyWith(primaryColor: theme.selectedTabBarColor),
                child: TextField(
                  maxLines: 5,
                  focusNode: _nodeMessage,
                  style: messageStyle,
                  onChanged: (value) => _message = value,
                  decoration: InputDecoration(
                      hintText: localization.info_hint_message,
                      border: OutlineInputBorder()),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (widget.onSend != null) {
                        var completer = Completer<bool>();
                        widget.onSend(
                            MailInfo(
                                firstName: _firstName,
                                lastName: _lastName,
                                email: _email,
                                phone: _phone,
                                type: _type,
                                codeProduct: widget.productCode,
                                message: _message),
                            completer);
                        var result = await completer.future;
                        if (result) _formKey.currentState.reset();
                      }
                    }
                  },
                  child: Text(localization.general_send),
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioGroup() {
    var localization = S.of(context);
    return Row(
      children: <Widget>[
        CustomRadio(
            text: localization.info_price_quotation,
            value: InfoTypePrice,
            groupValue: _type,
            onChanged: _handleType),
        const SizedBox(
          width: 8,
        ),
        CustomRadio(
            text: localization.info_hint_message,
            value: InfoTypeMessage,
            groupValue: _type,
            onChanged: _handleType),
      ],
    );
  }

  void _handleType(int value) {
    setState(() {
      _type = value;
    });
  }

  String _getEmail() => _email;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(nextFocus: true, actions: [
      KeyboardAction(focusNode: _nodeName),
      KeyboardAction(focusNode: _nodeSurname),
      KeyboardAction(focusNode: _nodeEmail),
      KeyboardAction(focusNode: _nodeConfirmEmail),
      KeyboardAction(focusNode: _nodePhone),
      KeyboardAction(focusNode: _nodeMessage, displayCloseWidget: true),
    ]);
  }
}
