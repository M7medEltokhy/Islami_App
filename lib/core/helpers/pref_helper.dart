import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  PrefHelper._();

  static const _kLastPage       = 'last_page';
  static const _kLastSurahIndex = 'last_surah_index';
  static const _kIsFirstOpen    = 'is_first_open';

  // ─── Onboarding ─────────────────────────────────────
  static Future<bool> checkAndSetFirstOpen() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool(_kIsFirstOpen) ?? true;
    if (isFirst) await prefs.setBool(_kIsFirstOpen, false);
    return isFirst;
  }


  // ─── Save ───────────────────────────────────────────
  static Future<void> saveLastPosition({
    required int page,
    required int surahIndex,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setInt(_kLastPage, page),
      prefs.setInt(_kLastSurahIndex, surahIndex),
    ]);
  }

  // ─── Load ───────────────────────────────────────────
  static Future<int?> loadLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kLastPage);
  }

  static Future<int?> loadLastSurahIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kLastSurahIndex);
  }

  static Future<({int page, int surahIndex})?> loadLastPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final page       = prefs.getInt(_kLastPage);
    final surahIndex = prefs.getInt(_kLastSurahIndex);
    if (page == null || surahIndex == null) return null;
    return (page: page, surahIndex: surahIndex);
  }

  // ─── Clear ──────────────────────────────────────────
  static Future<void> clearLastPosition() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove(_kLastPage),
      prefs.remove(_kLastSurahIndex),
    ]);
  }
}