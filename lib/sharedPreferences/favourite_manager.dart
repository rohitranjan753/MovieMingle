import 'package:shared_preferences/shared_preferences.dart';

class FavoriteManager {
  static const _favoritesKey = 'favorites';

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.map((idStr) => int.parse(idStr)).toList();
  }

  Future<void> updateFavorites(List<int> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final idStrList = favorites.map((id) => id.toString()).toList();
    await prefs.setStringList(_favoritesKey, idStrList);
  }
}
