import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/dropdown/dropdown_model/dropdown_model_widget.dart';
import '/pages/dropdown/dropdown_number/dropdown_number_widget.dart';
import '/pages/dropdown/dropdown_string/dropdown_string_widget.dart';
import 'dart:ui';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for dropdown_number component.
  late DropdownNumberModel dropdownNumberModel;
  // Model for dropdown_string component.
  late DropdownStringModel dropdownStringModel;
  // Model for dropdown_model component.
  late DropdownModelModel dropdownModelModel;

  @override
  void initState(BuildContext context) {
    dropdownNumberModel = createModel(context, () => DropdownNumberModel());
    dropdownStringModel = createModel(context, () => DropdownStringModel());
    dropdownModelModel = createModel(context, () => DropdownModelModel());
  }

  @override
  void dispose() {
    dropdownNumberModel.dispose();
    dropdownStringModel.dispose();
    dropdownModelModel.dispose();
  }
}
