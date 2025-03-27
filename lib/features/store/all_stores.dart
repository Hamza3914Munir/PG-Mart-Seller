import 'package:flutter/material.dart';
// import 'package:flutter_sixvalley_ecommerce/features/shop/widget/shop_product_view_list.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/seller_shop_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/shop_products.dart'; 
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';

import 'package:flutter_sixvalley_ecommerce/features/splash/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:provider/provider.dart';

class AllSellerScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const AllSellerScreen({super.key, required this.isBacButtonExist});

  @override
  State<AllSellerScreen> createState() => _AllSellerScreenState();
}

class _AllSellerScreenState extends State<AllSellerScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ShopProvider>(context, listen: false).getSellerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated('stores', context),
        isBackButtonExist: widget.isBacButtonExist,
      ),
      body: Consumer<ShopProvider>(
        builder: (context, sellerProvider, child) {
          return sellerProvider.sellerList != null && sellerProvider.sellerList!.isNotEmpty
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: sellerProvider.sellerList?.length,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  itemBuilder: (context, index) {
                    Seller seller = sellerProvider.sellerList![index];
                    return InkWell(
                      onTap: () {
                        sellerProvider.selectSeller(index);
                        // Navigate to seller details or products page
                      },
                      child: SellerItem(
                        seller: seller,
                        isSelected: sellerProvider.sellerSelectedIndex == index,
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  )
                  );
        },
      ),
    );
  }
}

class SellerItem extends StatelessWidget {
  final Seller seller;
  final bool isSelected;
  const SellerItem({super.key, required this.seller, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    bool isClosed = seller.shop?.temporaryClose ?? false; 

    return Material(
      color: Colors.transparent, 
      child: InkWell(
        onTap: () {
          if (!isClosed) { 
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ShopProductViewList(
                  scrollController: ScrollController(),
                  sellerId: seller.id!, 
                  sellerName:seller.lName!,
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(.13) : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.placeholder,
                        fit: BoxFit.cover,
                        image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/${seller.image}',
                        imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  if (isClosed) 
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5), 
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7), 
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              'Closed',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Text(
                seller.shop?.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SellerItem extends StatelessWidget {
//   final Seller seller;
//   final bool isSelected;
//   const SellerItem({super.key, required this.seller, required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     bool isClosed = seller.shop?.temporaryClose ?? false; 

//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: isSelected ? Theme.of(context).primaryColor.withOpacity(.13) : null,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     width: 2,
//                     color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: FadeInImage.assetNetwork(
//                     placeholder: Images.placeholder,
//                     fit: BoxFit.cover,
//                     image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/${seller.image}',
//                     imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
//                   ),
//                 ),
//               ),
//               if (isClosed) 
//                 Container(
//                   height: 100,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.5), 
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Container(
//                       height: 60,
//                       width: 60,
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.7), 
//                         shape: BoxShape.circle,
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Closed',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           Text(
//             seller.shop?.name ?? '',
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//             style: titilliumSemiBold.copyWith(
//               fontSize: Dimensions.fontSizeDefault,
//               color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }