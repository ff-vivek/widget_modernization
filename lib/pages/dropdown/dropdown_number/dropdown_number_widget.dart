import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/dropdown/base_dropdown/base_dropdown_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dropdown_number_model.dart';
export 'dropdown_number_model.dart';

class DropdownNumberWidget extends StatefulWidget {
  const DropdownNumberWidget({super.key});

  @override
  State<DropdownNumberWidget> createState() => _DropdownNumberWidgetState();
}

class _DropdownNumberWidgetState extends State<DropdownNumberWidget> {
  late DropdownNumberModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropdownNumberModel());
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
        hintText: 'Select Age',
        semantic: 'age_dropdown',
        options: FFAppState().randomAge.map((e) => e.toString()).toList(),
        onSelected: (selectedValue) async {
          _model.selectedAge = functions.convertStringToInt(selectedValue);
          safeSetState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                (String var1) {
                  return "Selected Age: $var1";
                }(_model.selectedAge!.toString()),
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
