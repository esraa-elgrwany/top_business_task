import 'dart:convert';
import 'package:test_task/core/cache/shared_preferences.dart';

class WishlistLocalManager {
  static const String _wishlistKey = "user_favorites_slugs";

  static List<String> getFavoriteSlugs() {
    final dynamic rawData = CacheData.getData(key: _wishlistKey);

    if (rawData == null) return [];

    if (rawData is String) {
      try {
        final List<dynamic> decodedList = jsonDecode(rawData);
        return decodedList.map((item) => item.toString()).toList();
      } catch (e) {
        print("Error decoding cached wishlist items: $e");
        return [];
      }
    }
    return [];
  }

  static Future<bool> toggleFavorite(String slug) async {
    final List<String> favorites = getFavoriteSlugs();

    bool isFavorited;
    if (favorites.contains(slug)) {
      favorites.remove(slug);
      isFavorited = false;
    } else {
      favorites.add(slug);
      isFavorited = true;
    }

    await CacheData.saveData(data: favorites, key: _wishlistKey);
    return isFavorited;
  }
  static bool isProductFavorited(String slug) {
    return getFavoriteSlugs().contains(slug);
  }
}