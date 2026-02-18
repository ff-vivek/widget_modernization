import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/dropdown/base_dropdown/base_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dropdown_string_model.dart';
export 'dropdown_string_model.dart';

class DropdownStringWidget extends StatefulWidget {
  const DropdownStringWidget({super.key});

  @override
  State<DropdownStringWidget> createState() => _DropdownStringWidgetState();
}

class _DropdownStringWidgetState extends State<DropdownStringWidget> {
  late DropdownStringModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropdownStringModel());
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
        hintText: 'Select Colors',
        semantic: 'color_dropdown',
        options: FFAppState().colors,
        onSelected: (selectedValue) async {
          _model.selectedColor = selectedValue;
          safeSetState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                (String var1) {
                  return "Selected Color: $var1";
                }(_model.selectedColor!),
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
