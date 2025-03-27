import 'dart:async';  

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/widget/category_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/widget/category_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/view/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  final bool isHomePage;
  const CategoryView({super.key, required this.isHomePage});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late int _currentPage = 0;
  Timer? _timer; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    
    if (_timer == null || !_timer!.isActive) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentPage = (_currentPage + 1) % context.read<CategoryController>().categoryList!.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, categoryProvider, child) {
       
        if (categoryProvider.categoryList == null || categoryProvider.categoryList!.isEmpty) {
          return const CategoryShimmer();
        }

        return Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 3),
              child: InkWell(
                key: UniqueKey(),  
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => BrandAndCategoryProductScreen(
                  //       isBrand: false,
                  //       id: categoryProvider.categoryList![_currentPage].id.toString(),
                  //       name: categoryProvider.categoryList![_currentPage].name,
                  //     ),
                  //   ),
                  // );
                },
                child: CategoryWidget(
                  category: categoryProvider.categoryList![_currentPage],
                  index: _currentPage,
                  length: categoryProvider.categoryList!.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }
}




