import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/dropdown/base_dropdown/base_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dropdown_model_model.dart';
export 'dropdown_model_model.dart';

class DropdownModelWidget extends StatefulWidget {
  const DropdownModelWidget({super.key});

  @override
  State<DropdownModelWidget> createState() => _DropdownModelWidgetState();
}

class _DropdownModelWidgetState extends State<DropdownModelWidget> {
  late DropdownModelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropdownModelModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return wrapWithModel(
      model: _model.baseDropdownModel,
      updateCallback: () => safeSetState(() {}),
      child: BaseDropdownWidget(
        hintText: 'Select User',
        semantic: 'user_model_dropdown',
        options: FFAppState().users.map((e) => e.name).toList(),
        onSelected: (selectedValue) async {
          _model.selectedUser = FFAppState()
              .users
              .where((e) => e.name == selectedValue)
              .toList()
              .firstOrNull;
          safeSetState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                (String var1, String var2) {
                  return "Selected User: $var1, $var2";
                }(_model.selectedUser!.name, _model.selectedUser!.phoneNumber),
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
        },
      ),
    );
  }
}
