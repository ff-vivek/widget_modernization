import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<int> _randomAge = [21, 30, 40, 50];
  List<int> get randomAge => _randomAge;
  set randomAge(List<int> value) {
    _randomAge = value;
  }

  void addToRandomAge(int value) {
    randomAge.add(value);
  }

  void removeFromRandomAge(int value) {
    randomAge.remove(value);
  }

  void removeAtIndexFromRandomAge(int index) {
    randomAge.removeAt(index);
  }

  void updateRandomAgeAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    randomAge[index] = updateFn(_randomAge[index]);
  }

  void insertAtIndexInRandomAge(int index, int value) {
    randomAge.insert(index, value);
  }

  List<String> _colors = ['Red', 'Yellow', 'Green', 'Cyan', 'Blue', 'Voilet'];
  List<String> get colors => _colors;
  set colors(List<String> value) {
    _colors = value;
  }

  void addToColors(String value) {
    colors.add(value);
  }

  void removeFromColors(String value) {
    colors.remove(value);
  }

  void removeAtIndexFromColors(int index) {
    colors.removeAt(index);
  }

  void updateColorsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    colors[index] = updateFn(_colors[index]);
  }

  void insertAtIndexInColors(int index, String value) {
    colors.insert(index, value);
  }

  List<UserStruct> _users = [
    UserStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Vivke\",\"phoneNumber\":\"7021730766\"}')),
    UserStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Abhishek\",\"phoneNumber\":\"+65789245232\"}')),
    UserStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Ayush\",\"phoneNumber\":\"9876543456\"}')),
    UserStruct.fromSerializableMap(
        jsonDecode('{\"name\":\"Bhavik\",\"phoneNumber\":\"\"}'))
  ];
  List<UserStruct> get users => _users;
  set users(List<UserStruct> value) {
    _users = value;
  }

  void addToUsers(UserStruct value) {
    users.add(value);
  }

  void removeFromUsers(UserStruct value) {
    users.remove(value);
  }

  void removeAtIndexFromUsers(int index) {
    users.removeAt(index);
  }

  void updateUsersAtIndex(
    int index,
    UserStruct Function(UserStruct) updateFn,
  ) {
    users[index] = updateFn(_users[index]);
  }

  void insertAtIndexInUsers(int index, UserStruct value) {
    users.insert(index, value);
  }
}
