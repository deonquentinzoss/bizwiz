import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/company.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';
  final SharedPreferences _prefs;
  Set<String> _favoriteIds = {};

  FavoritesService(this._prefs) {
    _loadFavorites();
  }

  void _loadFavorites() {
    final favoritesJson = _prefs.getString(_favoritesKey);
    if (favoritesJson != null) {
      final List<dynamic> decoded = jsonDecode(favoritesJson);
      _favoriteIds = decoded.cast<String>().toSet();
    }
  }

  void _saveFavorites() {
    final favoritesJson = jsonEncode(_favoriteIds.toList());
    _prefs.setString(_favoritesKey, favoritesJson);
  }

  bool isFavorite(String companyId) {
    return _favoriteIds.contains(companyId);
  }

  void toggleFavorite(String companyId) {
    if (_favoriteIds.contains(companyId)) {
      _favoriteIds.remove(companyId);
    } else {
      _favoriteIds.add(companyId);
    }
    _saveFavorites();
  }

  Set<String> get favoriteIds => _favoriteIds;

  List<Company> getFavoriteCompanies(List<Company> allCompanies) {
    return allCompanies
        .where((company) => _favoriteIds.contains(company.id))
        .toList();
  }
}
