import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/seller_repository.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/seller_shop_model.dart';

class ShopProvider with ChangeNotifier {
  final SellerRepository? sellerRepository;

  ShopProvider({required this.sellerRepository});

  List<Seller>? _sellerList;
  int _sellerSelectedIndex = -1;

  List<Seller>? get sellerList => _sellerList;
  int get sellerSelectedIndex => _sellerSelectedIndex;

  Future<void> getSellerList() async {
    ApiResponse apiResponse = await sellerRepository!.getAllSellers();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _sellerList = [];
      // Parse the response data correctly
      var responseData = apiResponse.response!.data;
      if (responseData['sellers'] != null) {
        responseData['sellers'].forEach((seller) {
          _sellerList!.add(Seller.fromJson(seller));
        });
      }
      notifyListeners();
    } else {
      // Handle error
      print("Failed to load sellers: ${apiResponse.error}");
    }
  }

  void selectSeller(int index) {
    _sellerSelectedIndex = index;
    notifyListeners();
  }
}