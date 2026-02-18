import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/dropdown/base_dropdown/base_dropdown_widget.dart';
import 'dropdown_model_widget.dart' show DropdownModelWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DropdownModelModel extends FlutterFlowModel<DropdownModelWidget> {
  ///  Local state fields for this component.

  UserStruct? selectedUser;
  void updateSelectedUserStruct(Function(UserStruct) updateFn) {
    updateFn(selectedUser ??= UserStruct());
  }

  ///  State fields for stateful widgets in this component.

  // Model for base_dropdown component.
  late BaseDropdownModel baseDropdownModel;

  @override
  void initState(BuildContext context) {
    baseDropdownModel = createModel(context, () => BaseDropdownModel());
  }

  @override
  void dispose() {
    baseDropdownModel.dispose();
  }
}
