import '../imports.dart';

class SharedModel extends ChangeNotifier {
  double _changedWaterValue = 0.3;
  double _targetWaterValue = 2.5;
  bool _flag = false;

  double get changedWaterValue => _changedWaterValue;
  double get targetWaterValue => _flag ? double.infinity : _targetWaterValue;
  bool get flag => _flag;

  Future<void> loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    _changedWaterValue = prefs.getDouble('changedWaterValue') ?? 0.3;
    _targetWaterValue = prefs.getDouble('targetWaterValue') ?? 2.5;
    _flag = prefs.getBool('flag') ?? false;
    notifyListeners();
  }

  Future<void> updateChangedWaterValue(double newValue) async {
    _changedWaterValue = newValue;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('changedWaterValue', newValue);
    notifyListeners();
  }

  Future<void> updateTargetWaterValue(double newValue) async {
    if(!_flag) {
      _targetWaterValue = newValue;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('targetWaterValue', newValue);
    }
    notifyListeners();
  }

  Future<void> updateFlagValue(bool newValue) async {
    _flag = newValue;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('flag', newValue);
    notifyListeners();
  }
}