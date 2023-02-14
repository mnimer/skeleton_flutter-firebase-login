import 'package:flutter/material.dart';

class LoginModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddress widget.
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;

  // State field(s) for password widget.
  TextEditingController? passwordController;
  late bool passwordVisibility = false;
  String? Function(BuildContext, String?)? passwordControllerValidator;

  bool biometric = false;

  // State field(s) for emailAddress-Create widget.
  TextEditingController? emailAddressCreateController;
  String? Function(BuildContext, String?)? emailAddressCreateControllerValidator;
  // State field(s) for password-Create widget.

  TextEditingController? passwordCreateController;
  late bool passwordCreateVisibility = false;
  String? Function(BuildContext, String?)? passwordCreateControllerValidator;

  // State field(s) for Switch widget.
  bool? switchValue;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordCreateVisibility = false;
  }

  void dispose() {
    emailAddressController?.dispose();
    passwordController?.dispose();
    emailAddressCreateController?.dispose();
    passwordCreateController?.dispose();
  }

  /// Additional helper methods are added here.
}
