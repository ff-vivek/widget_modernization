import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'base_dropdown_model.dart';
export 'base_dropdown_model.dart';

class BaseDropdownWidget extends StatefulWidget {
  const BaseDropdownWidget({
    super.key,
    required this.options,
    required this.hintText,
    this.semantic,
    required this.onSelected,
  });

  final List<String>? options;
  final String? hintText;
  final String? semantic;
  final Future Function(String selectedValue)? onSelected;

  @override
  State<BaseDropdownWidget> createState() => _BaseDropdownWidgetState();
}

class _BaseDropdownWidgetState extends State<BaseDropdownWidget> {
  late BaseDropdownModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BaseDropdownModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget!.semantic!,
      explicitChildNodes: true,
      identifier: (String var1) {
        return "drop_down$var1";
      }(widget!.semantic!),
      child: FlutterFlowDropDown<String>(
        controller: _model.dropDownValueController ??=
            FormFieldController<String>(
          _model.dropDownValue ??= '',
        ),
        options: List<String>.from(widget!.options!),
        optionLabels: widget!.options!,
        onChanged: (val) async {
          safeSetState(() => _model.dropDownValue = val);
          await widget.onSelected?.call(
            _model.dropDownValue!,
          );
        },
        width: double.infinity,
        height: 60.0,
        textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.inter(
                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
            ),
        hintText: widget!.hintText,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: FlutterFlowTheme.of(context).secondaryText,
          size: 24.0,
        ),
        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        elevation: 2.0,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 8.0,
        margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
        hidesUnderline: true,
        isOverButton: false,
        isSearchable: false,
        isMultiSelect: false,
      ),
    );
  }
}
