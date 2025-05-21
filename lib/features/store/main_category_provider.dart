import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/category_api_service.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/category_model.dart';


class MainCategoryProvider with ChangeNotifier {
  final MainCategoryApiService _apiService = MainCategoryApiService();
  List<MainCategory> _mainCategories = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String _error = '';
  int _currentPage = 1;
  int _lastPage = 1;
  bool _hasMore = true;

  List<MainCategory> get mainCategories => _mainCategories;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String get error => _error;
  bool get hasMore => _hasMore;

  Future<void> fetchMainCategories() async {
    _currentPage = 1;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.fetchMainCategories(page: _currentPage);
      _mainCategories = response.data;
      _lastPage = response.lastPage;
      _hasMore = response.nextPageUrl != null;
      _error = '';
    } catch (e) {
      _error = e.toString();
      _mainCategories = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreCategories() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      _currentPage++;
      final response = await _apiService.fetchMainCategories(page: _currentPage);
      _mainCategories.addAll(response.data);
      _hasMore = response.nextPageUrl != null;
      _error = '';
    } catch (e) {
      _error = e.toString();
      _currentPage--; // Revert page increment if failed
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}

// class MainCategoryProvider with ChangeNotifier {
//   final MainCategoryApiService _apiService = MainCategoryApiService();
//   List<MainCategory> _mainCategories = [];
//   bool _isLoading = false;
//   String _error = '';

//   List<MainCategory> get mainCategories => _mainCategories;
//   bool get isLoading => _isLoading;
//   String get error => _error;

//   Future<void> fetchMainCategories() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _mainCategories = await _apiService.fetchMainCategories();
//       _error = '';
//     } catch (e) {
//       _error = e.toString();
//       _mainCategories = [];
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }