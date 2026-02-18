import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/foundation.dart';
import 'form_field_controller.dart';
import 'package:flutter/material.dart';

class FlutterFlowDropDown<T> extends StatefulWidget {
  const FlutterFlowDropDown({
    super.key,
    this.controller,
    this.multiSelectController,
    this.hintText,
    this.searchHintText,
    required this.options,
    this.optionLabels,
    this.onChanged,
    this.onMultiSelectChanged,
    this.icon,
    this.width,
    this.height,
    this.maxHeight,
    this.fillColor,
    this.searchHintTextStyle,
    this.searchTextStyle,
    this.searchCursorColor,
    required this.textStyle,
    required this.elevation,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.margin,
    this.hidesUnderline = false,
    this.disabled = false,
    this.isOverButton = false,
    this.menuOffset,
    this.isSearchable = false,
    this.isMultiSelect = false,
    this.labelText,
    this.labelTextStyle,
    this.optionsHasValueKeys = false,
  }) : assert(
          isMultiSelect
              ? (controller == null &&
                  onChanged == null &&
                  multiSelectController != null &&
                  onMultiSelectChanged != null)
              : (controller != null &&
                  onChanged != null &&
                  multiSelectController == null &&
                  onMultiSelectChanged == null),
        );

  final FormFieldController<T?>? controller;
  final FormFieldController<List<T>?>? multiSelectController;
  final String? hintText;
  final String? searchHintText;
  final List<T> options;
  final List<String>? optionLabels;
  final Function(T?)? onChanged;
  final Function(List<T>?)? onMultiSelectChanged;
  final Widget? icon;
  final double? width;
  final double? height;
  final double? maxHeight;
  final Color? fillColor;
  final TextStyle? searchHintTextStyle;
  final TextStyle? searchTextStyle;
  final Color? searchCursorColor;
  final TextStyle textStyle;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry margin;
  final bool hidesUnderline;
  final bool disabled;
  final bool isOverButton;
  final Offset? menuOffset;
  final bool isSearchable;
  final bool isMultiSelect;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final bool optionsHasValueKeys;

  @override
  State<FlutterFlowDropDown<T>> createState() => _FlutterFlowDropDownState<T>();
}

class _FlutterFlowDropDownState<T> extends State<FlutterFlowDropDown<T>> {
  bool get isMultiSelect => widget.isMultiSelect;
  FormFieldController<T?> get controller => widget.controller!;
  FormFieldController<List<T>?> get multiSelectController =>
      widget.multiSelectController!;

  T? get currentValue {
    final value = isMultiSelect
        ? multiSelectController.value?.firstOrNull
        : controller.value;
    return widget.options.contains(value) ? value : null;
  }

  Set<T> get currentValues {
    if (!isMultiSelect || multiSelectController.value == null) {
      return {};
    }
    return widget.options
        .toSet()
        .intersection(multiSelectController.value!.toSet());
  }

  Map<T, String> get optionLabels => Map.fromEntries(
        widget.options.asMap().entries.map(
              (option) => MapEntry(
                option.value,
                widget.optionLabels == null ||
                        widget.optionLabels!.length < option.key + 1
                    ? option.value.toString()
                    : widget.optionLabels![option.key],
              ),
            ),
      );

  EdgeInsetsGeometry get horizontalMargin => widget.margin.clamp(
        EdgeInsetsDirectional.zero,
        const EdgeInsetsDirectional.symmetric(horizontal: double.infinity),
      );

  late void Function() _listener;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (isMultiSelect) {
      _listener =
          () => widget.onMultiSelectChanged!(multiSelectController.value);
      multiSelectController.addListener(_listener);
    } else {
      _listener = () => widget.onChanged!(controller.value);
      controller.addListener(_listener);
    }
  }

  @override
  void dispose() {
    if (isMultiSelect) {
      multiSelectController.removeListener(_listener);
    } else {
      controller.removeListener(_listener);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = _buildDropdownWidget();
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
          color: widget.fillColor,
        ),
        child: Padding(
          padding: _useDropdown2() ? EdgeInsets.zero : widget.margin,
          child: widget.hidesUnderline
              ? DropdownButtonHideUnderline(child: dropdownWidget)
              : dropdownWidget,
        ),
      ),
    );
  }

  bool _useDropdown2() =>
      widget.isMultiSelect ||
      widget.isSearchable ||
      !widget.isOverButton ||
      widget.maxHeight != null;

  Widget _buildDropdownWidget() =>
      _useDropdown2() ? _buildDropdown() : _buildLegacyDropdown();

  Widget _buildLegacyDropdown() {
    return DropdownButtonFormField<T>(
      value: currentValue,
      hint: _createHintText(),
      items: _createMenuItems(),
      elevation: widget.elevation.toInt(),
      onChanged: widget.disabled ? null : (value) => controller.value = value,
      icon: widget.icon,
      isExpanded: true,
      dropdownColor: widget.fillColor,
      focusColor: Colors.transparent,
      decoration: InputDecoration(
        labelText: widget.labelText == null || widget.labelText!.isEmpty
            ? null
            : widget.labelText,
        labelStyle: widget.labelTextStyle,
        border: widget.hidesUnderline
            ? InputBorder.none
            : const UnderlineInputBorder(),
      ),
    );
  }

  Text? _createHintText() => widget.hintText != null
      ? Text(widget.hintText!, style: widget.textStyle)
      : null;

  ValueKey _getItemKey(T option) {
    final widgetKey = (widget.key as ValueKey).value;
    return ValueKey('$widgetKey ${widget.options.indexOf(option)}');
  }

  List<DropdownMenuItem<T>> _createMenuItems() => widget.options
      .map(
        (option) => DropdownMenuItem<T>(
            key: widget.optionsHasValueKeys ? _getItemKey(option) : null,
            value: option,
            child: Padding(
              padding: _useDropdown2() ? horizontalMargin : EdgeInsets.zero,
              child: Text(optionLabels[option] ?? '', style: widget.textStyle),
            )),
      )
      .toList();

  List<DropdownItem<T>> _createDropdownItems() => widget.options
      .map(
        (option) => DropdownItem<T>(
          key: widget.optionsHasValueKeys ? _getItemKey(option) : null,
          value: option,
          child: Padding(
            padding: horizontalMargin,
            child: Text(
              optionLabels[option] ?? '',
              style: widget.textStyle,
            ),
          ),
        ),
      )
      .toList();

  List<DropdownItem<T>> _createMultiselectDropdownItems() => widget.options
      .map(
        (item) => DropdownItem<T>(
          key: widget.optionsHasValueKeys ? _getItemKey(item) : null,
          value: item,
          closeOnTap: false,
          onTap: () {
            multiSelectController.value ??= [];
            final isSelected =
                multiSelectController.value?.contains(item) ?? false;
            if (isSelected) {
              multiSelectController.value!.remove(item);
            } else {
              multiSelectController.value!.add(item);
            }
            multiSelectController.update();
            setState(() {});
          },
          child: ValueListenableBuilder<List<T>?>(
            valueListenable: multiSelectController,
            builder: (context, value, _) {
              final isSelected = value?.contains(item) ?? false;
              return Container(
                height: double.infinity,
                padding: horizontalMargin,
                child: Row(
                  children: [
                    if (isSelected)
                      const Icon(Icons.check_box_outlined)
                    else
                      const Icon(Icons.check_box_outline_blank),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        optionLabels[item]!,
                        style: widget.textStyle,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      )
      .toList();

  /// Exposes controller value only when it exists in [widget.options],
  /// so DropdownButton2's assertion (exactly one matching item) is satisfied.
  ValueListenable<T?> _singleValueListenable() =>
      _SingleValueListenable<T>(controller, widget.options);

  ValueListenable<Iterable<T>> _multiValueListenable() =>
      _MultiValueListenable<T>(multiSelectController, widget.options);

  Widget _buildDropdown() {
    final overlayColor = WidgetStateProperty.resolveWith<Color?>((states) =>
        states.contains(WidgetState.focused) ? Colors.transparent : null);
    final iconStyleData = widget.icon != null
        ? IconStyleData(icon: widget.icon!)
        : const IconStyleData();
    return DropdownButton2<T>(
      valueListenable: isMultiSelect ? null : _singleValueListenable(),
      multiValueListenable: isMultiSelect ? _multiValueListenable() : null,
      hint: _createHintText(),
      items: isMultiSelect
          ? _createMultiselectDropdownItems()
          : _createDropdownItems(),
      iconStyleData: iconStyleData,
      buttonStyleData: ButtonStyleData(
        elevation: widget.elevation.toInt(),
        overlayColor: overlayColor,
        padding: widget.margin,
      ),
      menuItemStyleData: MenuItemStyleData(
        overlayColor: overlayColor,
        padding: EdgeInsets.zero,
      ),
      dropdownStyleData: DropdownStyleData(
        elevation: widget.elevation.toInt(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: widget.fillColor,
        ),
        isOverButton: widget.isOverButton,
        offset: widget.menuOffset ?? Offset.zero,
        maxHeight: widget.maxHeight,
        padding: EdgeInsets.zero,
      ),
      onChanged: widget.disabled
          ? null
          : (isMultiSelect ? (_) {} : (val) => widget.controller!.value = val),
      isExpanded: true,
      selectedItemBuilder: (context) => widget.options
          .map(
            (item) => Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  isMultiSelect
                      ? currentValues
                          .where((v) => optionLabels.containsKey(v))
                          .map((v) => optionLabels[v])
                          .join(', ')
                      : optionLabels[item]!,
                  style: widget.textStyle,
                  maxLines: 1,
                )),
          )
          .toList(),
      dropdownSearchData: widget.isSearchable
          ? DropdownSearchData<T>(
              searchController: _textEditingController,
              searchBarWidgetHeight: 50,
              searchBarWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: _textEditingController,
                  cursorColor: widget.searchCursorColor,
                  style: widget.searchTextStyle,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: widget.searchHintText,
                    hintStyle: widget.searchHintTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                final value = item.value;
                return value != null &&
                    (optionLabels[value] ?? '')
                        .toLowerCase()
                        .contains(searchValue.toLowerCase());
              },
            )
          : null,
      onMenuStateChange: widget.isSearchable
          ? (isOpen) {
              if (!isOpen) {
                _textEditingController.clear();
              }
            }
          : null,
    );
  }
}

/// Wraps [FormFieldController<T?>] and only exposes a value when it is in
/// [validValues], so DropdownButton2's unique-value assertion is satisfied.
class _SingleValueListenable<T> implements ValueListenable<T?> {
  _SingleValueListenable(this._controller, this._validValues);

  final FormFieldController<T?> _controller;
  final List<T> _validValues;

  @override
  T? get value {
    final v = _controller.value;
    return _validValues.contains(v) ? v : null;
  }

  @override
  void addListener(VoidCallback listener) =>
      _controller.addListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      _controller.removeListener(listener);
}

/// Wraps [FormFieldController<List<T>?>] as [ValueListenable<Iterable<T>>]
/// for DropdownButton2 multiValueListenable. Only exposes values that are in
/// [validValues] so the package's assertion is satisfied.
class _MultiValueListenable<T> implements ValueListenable<Iterable<T>> {
  _MultiValueListenable(this._controller, this._validValues);

  final FormFieldController<List<T>?> _controller;
  final List<T> _validValues;

  @override
  Iterable<T> get value {
    final list = _controller.value ?? const [];
    return list.where((v) => _validValues.contains(v));
  }

  @override
  void addListener(VoidCallback listener) =>
      _controller.addListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      _controller.removeListener(listener);
}
