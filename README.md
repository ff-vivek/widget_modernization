# WidgetModernization

A new Flutter project.

## Getting Started

FlutterFlow projects are built to run on the Flutter _stable_ release.

---

## FlutterFlowDropDown (`lib/flutter_flow/flutter_flow_drop_down.dart`) – Summary of Changes

`FlutterFlowDropDown` was updated to work with **dropdown_button2 3.0.0-beta.24**, which introduced breaking API changes. Below is a concise summary of what changed and why.

### 1. Value API: `value` → `valueListenable` / `multiValueListenable`

- **Before:** `DropdownButton2` took a single `value: T?`.
- **After:** It uses listenables:
  - **Single-select:** `valueListenable: ValueListenable<T?>`
  - **Multi-select:** `multiValueListenable: ValueListenable<Iterable<T>>`

The widget now passes the existing `FormFieldController<T?>` (single) or a wrapper for `FormFieldController<List<T>?>` (multi) so the dropdown stays in sync with the controller.

### 2. Items API: `DropdownMenuItem<T>` → `DropdownItem<T>`

- **Before:** The dropdown used Flutter’s `DropdownMenuItem<T>` for `items`.
- **After:** It uses the package’s `DropdownItem<T>` (with `value`, `child`, `onTap`, `closeOnTap`, etc.).

New helpers were added:

- **Single-select:** `_createDropdownItems()` → `List<DropdownItem<T>>`
- **Multi-select:** `_createMultiselectDropdownItems()` → `List<DropdownItem<T>>` with `closeOnTap: false`, `onTap` toggling selection, and `ValueListenableBuilder` so checkmarks update when the selection changes.

The legacy path (non–DropdownButton2) still uses `DropdownButtonFormField` and `DropdownMenuItem<T>` via `_createMenuItems()`.

### 3. DropdownSearchData parameter renames

For the searchable dropdown config, parameter names were aligned with the new package API:

- `searchInnerWidget` → **`searchBarWidget`**
- `searchInnerWidgetHeight` → **`searchBarWidgetHeight`**

### 4. Search match callback: `searchMatchFn` signature

- **Before:** Callback received a `DropdownMenuItem<T>` (e.g. `item.value`).
- **After:** It receives a `DropdownItem<T>`. The implementation uses `item.value` and null-checks before matching against `optionLabels` and the search string.

### 5. Assertion fix: value must exist in current options

`DropdownButton2` asserts that the value from the listenable is either `null` or exactly one of the current `items`. If the controller ever held a value not in the current options (e.g. options changed or initial value not in the list), the assertion failed.

To satisfy this:

- **Single-select:** A **`_SingleValueListenable<T>`** wraps the controller and exposes `value` only when it is in the current `widget.options`; otherwise it exposes `null`. Listeners are forwarded to the real controller; `onChanged` still updates the real controller.
- **Multi-select:** **`_MultiValueListenable<T>`** was updated to take the list of valid options and expose only values that are in that list (filtering out any that are no longer in options).

So the dropdown always sees only `null` or values that exist in the current items, while the underlying controllers can still hold any value and are updated on user selection as before.
