import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveUtils {
  final Box<dynamic> _box;
  static const String BASE_STORAGE = "hive_storage";

  HiveUtils._(this._box);

  static Future<HiveUtils> instance() async {
    final box = await Hive.openBox(BASE_STORAGE);
    return HiveUtils._(box);
  }

  void set<T>({required String key, required String data}) async {
    await _box.put(key, data);
  }

  T? get<T>({required String key}) {
    final data = _box.containsKey(key) ? _box.get(key) : null;
    return data;
  }

  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  Future<void> deleteAll(List<String> keys) async {
    await _box.deleteAll(keys);
  }

  Future<void> reset() async {
    await _box.clear();
    debugPrintStack(label: 'Hive reset');
  }
}
