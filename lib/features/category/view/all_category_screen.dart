import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/model/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/theme/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/view/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

class AllCategoryScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const AllCategoryScreen({super.key, required this.isBacButtonExist});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('CATEGORY', context),
        isBackButtonExist: widget.isBacButtonExist,
      ),
      body: Consumer<CategoryController>(
        builder: (context, categoryProvider, child) {
          return categoryProvider.categoryList!.isNotEmpty
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 3),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[
                                  Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200]!,
                              spreadRadius: 1,
                              blurRadius: 1,
                            )
                          ],
                        ),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: categoryProvider.categoryList?.length,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            CategoryModel category = categoryProvider.categoryList![index];
                            return InkWell(
                              onTap: () {
                         
                                categoryProvider.selectCategory(index);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BrandAndCategoryProductScreen(
                                      isBrand: false,
                                      id: category.id.toString(),
                                      name: category.name,
                                    ),
                                  ),
                                );
                              },
                              child: CategoryItem(
                                title: category.name,
                                icon: category.icon,
                                isSelected: categoryProvider.categorySelectedIndex == index,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                );
        },
      ),
    );
  }
}


class CategoryItem extends StatefulWidget {
  final String? title;
  final String? icon;
  final bool isSelected;
  const CategoryItem({super.key, required this.title, required this.icon, required this.isSelected});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.isSelected ? 
        Theme.of(context).primaryColor.withOpacity(.13)
        // ColorResources.getPrimary(context)
        
         : null,
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Flexible(
            child: Container(
              height: 210,
              width: 160,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: widget.isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  fit: BoxFit.cover,
                  image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.categoryImageUrl}/${widget.icon}',
                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeEight),
            child: Text(
              widget.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: titilliumSemiBold.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: widget.isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
