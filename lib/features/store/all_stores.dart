import 'dart:convert';
import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/view/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/theme/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/main_category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/seller_shop_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/store/shop_products.dart'; 
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:provider/provider.dart';

// // import 'package:flutter_sixvalley_ecommerce/features/splash/provider/splash_provider.dart';
// // import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
// // import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
// // import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
// // import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
// // import 'package:provider/provider.dart';

// class AllSellerScreen extends StatefulWidget {
//   final bool isBacButtonExist;
//   const AllSellerScreen({super.key, required this.isBacButtonExist});

//   @override
//   State<AllSellerScreen> createState() => _AllSellerScreenState();
// }

// class _AllSellerScreenState extends State<AllSellerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ShopProvider>(context, listen: false).getSellerList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: getTranslated('stores', context),
//         isBackButtonExist: widget.isBacButtonExist,
//       ),
//       body: Consumer<ShopProvider>(
//         builder: (context, sellerProvider, child) {
//           return sellerProvider.sellerList != null && sellerProvider.sellerList!.isNotEmpty
//               ? GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.8,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: sellerProvider.sellerList?.length,
//                   padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                   itemBuilder: (context, index) {
//                     Seller seller = sellerProvider.sellerList![index];
//                     return InkWell(
//                       onTap: () {
//                         sellerProvider.selectSeller(index);
//                         // Navigate to seller details or products page
//                       },
//                       child: SellerItem(
//                         seller: seller,
//                         isSelected: sellerProvider.sellerSelectedIndex == index,
//                       ),
//                     );
//                   },
//                 )
//               : Center(
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
//                   )
//                   );
//         },
//       ),
//     );
//   }
// }

// class SellerItem extends StatelessWidget {
//   final Seller seller;
//   final bool isSelected;
//   const SellerItem({super.key, required this.seller, required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     bool isClosed = seller.shop?.temporaryClose ?? false; 

//     return Material(
//       color: Colors.transparent, 
//       child: InkWell(
//         onTap: () {
//           if (!isClosed) { 
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => ShopProductViewList(
//                   scrollController: ScrollController(),
//                   sellerId: seller.id!, 
//                   sellerName:seller.lName!,
//                 ),
//               ),
//             );
//           }
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: isSelected ? Theme.of(context).primaryColor.withOpacity(.13) : null,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     height: 210,
//                     width: 165,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 2,
//                         color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: FadeInImage.assetNetwork(
//                         placeholder: Images.placeholder,
//                         fit: BoxFit.cover,
//                         image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/${seller.image}',
//                         imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
//                       ),
//                     ),
//                   ),
//                   if (isClosed) 
//                     Container(
//                       height: 210,
//                       width: 165,
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.5), 
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Container(
//                           height: 60,
//                           width: 60,
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.7), 
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Center(
//                             child: Text(
//                               'Closed',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               Text(
//                 seller.shop?.name ?? '',
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//                 style: titilliumSemiBold.copyWith(
//                   fontSize: Dimensions.fontSizeDefault,
//                   color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class SellerItem extends StatelessWidget {
// //   final Seller seller;
// //   final bool isSelected;
// //   const SellerItem({super.key, required this.seller, required this.isSelected});

// //   @override
// //   Widget build(BuildContext context) {
// //     bool isClosed = seller.shop?.temporaryClose ?? false; 

// //     return Container(
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(10),
// //         color: isSelected ? Theme.of(context).primaryColor.withOpacity(.13) : null,
// //       ),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //         children: [
// //           Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               Container(
// //                 height: 100,
// //                 width: 100,
// //                 decoration: BoxDecoration(
// //                   border: Border.all(
// //                     width: 2,
// //                     color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
// //                   ),
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: ClipRRect(
// //                   borderRadius: BorderRadius.circular(10),
// //                   child: FadeInImage.assetNetwork(
// //                     placeholder: Images.placeholder,
// //                     fit: BoxFit.cover,
// //                     image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.sellerImageUrl}/${seller.image}',
// //                     imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, fit: BoxFit.cover),
// //                   ),
// //                 ),
// //               ),
// //               if (isClosed) 
// //                 Container(
// //                   height: 100,
// //                   width: 100,
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.5), 
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   child: Center(
// //                     child: Container(
// //                       height: 60,
// //                       width: 60,
// //                       padding: const EdgeInsets.all(8),
// //                       decoration: BoxDecoration(
// //                         color: Colors.white.withOpacity(0.7), 
// //                         shape: BoxShape.circle,
// //                       ),
// //                       child: Center(
// //                         child: Text(
// //                           'Closed',
// //                           style: TextStyle(
// //                             color: Colors.black,
// //                             fontSize: 12,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //             ],
// //           ),
// //           Text(
// //             seller.shop?.name ?? '',
// //             maxLines: 2,
// //             overflow: TextOverflow.ellipsis,
// //             textAlign: TextAlign.center,
// //             style: titilliumSemiBold.copyWith(
// //               fontSize: Dimensions.fontSizeDefault,
// //               color: isSelected ? Theme.of(context).highlightColor : Theme.of(context).hintColor,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';
// class AllSellerScreen extends StatelessWidget {
//   final bool isBacButtonExist;
//    AllSellerScreen({super.key, required this.isBacButtonExist});
//   final List<Map<String, String>> categories = [
//     {'title': 'Supermarkets', 'image': 'https://thumb.ac-illust.com/9d/9d138995ea00773f5a1f944c2518e12d_w.jpeg'},
//     {'title': 'Pharmacies', 'image': 'https://www.creativefabrica.com/wp-content/uploads/2022/10/01/Pharmacy-icon-vector-for-web-Graphics-39720410-1-1-580x386.jpg'},
//     {'title': 'Pet Shops', 'image': 'https://cdn0.iconfinder.com/data/icons/petshop-filled-outline/512/pet_shop_care_food_business_buying_animal-1024.png'},
//     {'title': 'Restaurants', 'image': 'https://media.istockphoto.com/id/981368726/vector/restaurant-food-drinks-logo-fork-knife-background-vector-image.jpg?s=612x612&w=0&k=20&c=9M26CBkCyEBqUPs3Ls5QCjYLZrB9sxwrSFmnAmNCopI='},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title:  'Order Now'
//         // getTranslated('stores', context)
//         ,
//         isBackButtonExist: isBacButtonExist,
//       ),  
//       body: Padding(
//         padding: const EdgeInsets.only(top: 20),
//         child: GridView.builder(
//           padding: EdgeInsets.all(10),
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//           ),
//           itemCount: categories.length,
//           itemBuilder: (ctx, index) => GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ShopListScreen(
//                     category: categories[index]['title']!, isBacButtonExist: true,
//                   ),
//                 ),
//               );
//             },
//             child:  Column(
//           children: [
//             Container(
//         width: 90,
//         height: 90,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: Colors.purple, 
//             width: 2,
//           ),
//         ),
//         child: CircleAvatar(
//           radius: 35,
//           backgroundImage: NetworkImage(categories[index]['image']!),
//           backgroundColor: Colors.transparent,
//         ),
//             ),
//             SizedBox(height: 5),
//             Text(categories[index]['title']!),
//           ],
//         ),
        
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ShopListScreen extends StatelessWidget {
//   final String category;
//    final bool isBacButtonExist;
//   ShopListScreen({required this.category, required this.isBacButtonExist});

//   final List<Map<String, String>> shops = [
//     {'name': 'BPK Pet Shop', 'image': 'https://cdn.iconscout.com/icon/premium/png-512-thumb/pet-shop-4059255-3378593.png?f=webp&w=512'},
//     {'name': 'Afro Pets', 'image': 'https://www.creativefabrica.com/wp-content/uploads/2021/01/18/Pet-shop-vector-icon-logos-template-Graphics-7854595-1-1-580x387.jpg'},
//     {'name': 'Furchild', 'image': 'https://images-platform.99static.com//LJAKjZ2EIFZStiejX1LWKjuDdEo=/97x85:913x901/fit-in/590x590/99designs-contests-attachments/102/102284/attachment_102284279'},
//   ];

//   @override
//  Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: CustomAppBar(
//       title: category,
//       isBackButtonExist: isBacButtonExist,
//     ), 
//     body: Padding(
//       padding: const EdgeInsets.only(top: 20),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Number of columns
//           childAspectRatio: 0.8, // Adjust this value to control card proportions
//           crossAxisSpacing: 16, // Horizontal spacing between items
//           mainAxisSpacing: 16, // Vertical spacing between items
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: shops.length,
//         itemBuilder: (ctx, index) {
//           return GestureDetector(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => ProductCategoryScreen(shopName: shops[index]['name']!, isBacButtonExist: true),
//               ),
//             ),
//             child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 side: BorderSide(
//                   color: Colors.purple, 
//                   width: 1.5,       
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
//                       child: Image.network(
//                         shops[index]['image']!,
                        
//                         width: double.infinity,
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Text(
//                             shops[index]['name']!,
//                             style: TextStyle(
//                               fontSize: 16, 
//                               fontWeight: FontWeight.bold,
//                               color: Colors.purple
//                             ),
//                           ),
//                         ),                  
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }
// }

// class ProductCategoryScreen extends StatelessWidget {
//   final String shopName;
//   final bool isBacButtonExist;
//   ProductCategoryScreen({required this.shopName, required this.isBacButtonExist});

//   final List<Map<String, String>> categories = [
//   {
//     'name': 'Dog Food & Treats',
//     'image': 'https://cdn5.vectorstock.com/i/1000x1000/90/19/dry-food-for-dog-line-icon-vector-36149019.jpg' 
//   },
//   {
//     'name': 'Dog Toys & Accessories',
//     'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHZ_JqPL32qwlYQsF6Ea8IHIMaTHaVOjBbCQ&s' 
//   },
//   {
//     'name': 'Dog Grooming',
//     'image': 'https://cdn-icons-png.flaticon.com/512/8818/8818011.png' 
//   },
//   {
//     'name': 'Cat Toys & Accessories',
//     'image': 'https://cdn-icons-png.flaticon.com/512/87/87969.png' 
//   },
// ];



//   @override
//       Widget build(BuildContext context) {
//         return Scaffold(
//           appBar: CustomAppBar(
//             title:  shopName,
//             isBackButtonExist: isBacButtonExist,
//           ), 
//           body: GridView.builder(
//             padding: EdgeInsets.all(10),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 10,
//               childAspectRatio: 0.8,
//             ),
//             itemCount: categories.length,
//             itemBuilder: (ctx, index) => GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => ProductListScreen(
//             category: categories[index]['name']!,
//             isBacButtonExist: true,
//           ),
//         ),
//       ),
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(
//             color: Colors.purple,
//             width: 1,
//           ),
        
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Image.network(
//                 categories[index]['image']!,
                
//                 fit: BoxFit.fitHeight,
//                 width: double.infinity,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Text(
//                 categories[index]['name']!,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.purple),
//                 maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),

//           ),
//         );
//       }
// }

// class ProductListScreen extends StatelessWidget {
//   final String category;
//   final bool isBacButtonExist;
//   ProductListScreen({required this.category, required this.isBacButtonExist});

//   final List<Map<String, dynamic>> products = [
//     {'name': 'Pet Shampoo', 'price': 52.5},
//     {'name': 'Hair Serum', 'price': 30.0},
//     {'name': 'Glossy Coat', 'price': 22.5},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title:  category,
//         isBackButtonExist: isBacButtonExist,
//       ), 
//       body: GridView.builder(
//         padding: EdgeInsets.all(10),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//           childAspectRatio: 0.8,
//         ),
//         itemCount: products.length,
//          itemBuilder: (ctx, index) => Card(
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(12),
//     side: BorderSide(
//       color: Colors.purple,
//       width: 1.2,
//     ),
//   ),
//   elevation: 1,
//   child: Stack(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Image.network(
//                 'https://previews.123rf.com/images/yupiramos/yupiramos1802/yupiramos180224760/96068778-pet-shampoo-bottle-icon-vector-illustration-design.jpg',
//                 fit: BoxFit.contain,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.star, color: Colors.orange, size: 16),
//                 Text(' 0.0 ', style: TextStyle(fontWeight: FontWeight.w500)),
//                 Text('(1)', style: TextStyle(fontSize: 12, color: Colors.grey)),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Text(products[index]['name'], style: TextStyle(fontWeight: FontWeight.w500)),
//             const SizedBox(height: 2),
//             Text(
//               'AED ${products[index]['price']}',
//               style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//       // Favorite Icon
//         Positioned(
//           top: 8,
//           right: 8,
//           child: CircleAvatar(
//             radius: 16,
//             backgroundColor: Colors.white,
//             child: Icon(Icons.favorite_border, color: Colors.purple),
//           ),
//         ),
//       ],
//     ),
//   ),

//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_sixvalley_ecommerce/basewidget/custom_app_bar.dart';

// class AllSellerScreen extends StatelessWidget {
//   final bool isBacButtonExist;
//   AllSellerScreen({super.key, required this.isBacButtonExist});

//   final List<Map<String, String>> categories = [
//     {'title': 'Supermarkets', 'image': 'https://thumb.ac-illust.com/9d/9d138995ea00773f5a1f944c2518e12d_w.jpeg'},
//     {'title': 'Pharmacies', 'image': 'https://www.creativefabrica.com/wp-content/uploads/2022/10/01/Pharmacy-icon-vector-for-web-Graphics-39720410-1-1-580x386.jpg'},
//     {'title': 'Pet Shops', 'image': 'https://cdn0.iconfinder.com/data/icons/petshop-filled-outline/512/pet_shop_care_food_business_buying_animal-1024.png'},
//     {'title': 'Restaurants', 'image': 'https://media.istockphoto.com/id/981368726/vector/restaurant-food-drinks-logo-fork-knife-background-vector-image.jpg?s=612x612&w=0&k=20&c=9M26CBkCyEBqUPs3Ls5QCjYLZrB9sxwrSFmnAmNCopI='},
//     {'title': 'Baby Care', 'image': 'https://cdn-icons-png.flaticon.com/512/3281/3281289.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Order Now',
//         isBackButtonExist: isBacButtonExist,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
            
            
//             // SizedBox(height: 24),
            
           
            
//             SizedBox(height: 16),
            
//             // Categories Grid
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 16,
//                   crossAxisSpacing: 16,
//                   childAspectRatio: 0.9,
//                 ),
//                 itemCount: categories.length,
//                 itemBuilder: (ctx, index) => GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ShopListScreen(
//                           category: categories[index]['title']!, 
//                           isBacButtonExist: true,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 8,
//                           offset: Offset(0, 4),
//                         )
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.grey[100],
//                           ),
//                           child: Center(
//                             child: Image.network(
//                               categories[index]['image']!,
//                               width: 40,
//                               height: 40,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 12),
//                         Text(
//                           categories[index]['title']!,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ShopListScreen extends StatefulWidget {
//   final String category;
//   final bool isBacButtonExist;
//   ShopListScreen({required this.category, required this.isBacButtonExist});

//   @override
//   _ShopListScreenState createState() => _ShopListScreenState();
// }

// class _ShopListScreenState extends State<ShopListScreen> {
//   String selectedCategory = 'All';
  
//   final List<String> categories = ['All', 'Pet Shops', 'Restaurants', 'Baby Care'];
  
//   final List<Map<String, dynamic>> shops = [
//     {
//       'name': 'BPK Pet Shop', 
//       'image': 'https://cdn.iconscout.com/icon/premium/png-512-thumb/pet-shop-4059255-3378593.png?f=webp&w=512', 
//       'rating': '4.9',  
//       'type': 'Pet Shops',
//       'products': 125,
//       'reviews': 342,
//     },
//     {
//       'name': 'Afro Pets', 
//       'image': 'https://www.creativefabrica.com/wp-content/uploads/2021/01/18/Pet-shop-vector-icon-logos-template-Graphics-7854595-1-1-580x387.jpg', 
//       'rating': '4.7',  
//       'type': 'Pet Shops',
//       'products': 89,
//       'reviews': 215,
//     },
//     {
//       'name': 'Furchild', 
//       'image': 'https://images-platform.99static.com//LJAKjZ2EIFZStiejX1LWKjuDdEo=/97x85:913x901/fit-in/590x590/99designs-contests-attachments/102/102284/attachment_102284279', 
//       'rating': '4.8',  
//       'type': 'Pet Shops',
//       'products': 156,
//       'reviews': 421,
//     },
//     {
//       'name': 'Baby Care Center', 
//       'image': 'https://cdn-icons-png.flaticon.com/512/3281/3281289.png', 
//       'rating': '4.5', 
//       'type': 'Baby Care',
//       'products': 78,
//       'reviews': 132,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> filteredShops = selectedCategory == 'All' 
//         ? shops 
//         : shops.where((shop) => shop['type'] == selectedCategory).toList();

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: widget.category,
//         isBackButtonExist: widget.isBacButtonExist,
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 8,
//                     offset: Offset(0, 4),
//                   )
//                 ],
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search for any product or shop',
//                   prefixIcon: Icon(Icons.search, color: Colors.grey),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//                 ),
//               ),
//             ),
//           ),
//           // Horizontal categories
//           Container(
//             height: 60,
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8.0),
//                   child: FilterChip(
//                     label: Text(
//                       categories[index],
//                       style: TextStyle(
//                         color: selectedCategory == categories[index] 
//                             ? Colors.white 
//                             : Colors.black,
//                       ),
//                     ),
//                     selected: selectedCategory == categories[index],
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedCategory = categories[index];
//                       });
//                     },
//                     selectedColor: Colors.purple,
//                     backgroundColor: Colors.grey[200],
//                     shape: StadiumBorder(
//                       side: BorderSide(
//                         color: selectedCategory == categories[index]
//                             ? Colors.purple
//                             : Colors.grey[300]!,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
          
//           Divider(height: 1, thickness: 1, color: Colors.grey[200]),
          
//           // Shops list
//           Expanded(
//             child: ListView.separated(
//               padding: EdgeInsets.all(16),
//               itemCount: filteredShops.length,
//               separatorBuilder: (context, index) => SizedBox(height: 16),
//               itemBuilder: (context, index) {
//                 return Container(
//                   height: 120, // Fixed height for all shop cards
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       )
//                     ],
//                   ),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ProductCategoryScreen(
//                             shopName: filteredShops[index]['name']!,
//                             isBacButtonExist: true,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.stretch, // This makes children fill the height
//                         children: [
//                           // Shop image - now fills available height
//                           Container(
//                             width: 90, // Slightly wider image
//                             margin: EdgeInsets.only(right: 12),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               image: DecorationImage(
//                                 image: NetworkImage(filteredShops[index]['image']!),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
                          
//                           // Shop details
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space evenly
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       filteredShops[index]['name']!,
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(height: 6),
//                                     Row(
//                                       children: [
//                                         Icon(Icons.star, color: Colors.amber, size: 18),
//                                         SizedBox(width: 4),
//                                         Text(
//                                           filteredShops[index]['rating']!,
//                                           style: TextStyle(fontWeight: FontWeight.w500),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
                                
//                                 // Reviews and Products tabs
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[100],
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       // Reviews tab
//                                       Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                         child: RichText(
//                                           text: TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: filteredShops[index]['reviews'].toString(),
//                                                 style: TextStyle(
//                                                   color: Colors.purple,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               TextSpan(
//                                                 text: ' reviews',
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       // Divider
//                                       Container(
//                                         height: 16,
//                                         width: 1,
//                                         color: Colors.purple,
//                                         margin: EdgeInsets.symmetric(horizontal: 4),
//                                       ),
//                                       // Products tab
//                                       Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                         child: RichText(
//                                           text: TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: filteredShops[index]['products'].toString(),
//                                                 style: TextStyle(
//                                                   color: Colors.purple,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               TextSpan(
//                                                 text: ' products',
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class ProductCategoryScreen extends StatelessWidget {
//   final String shopName;
//   final bool isBacButtonExist;
//   ProductCategoryScreen({required this.shopName, required this.isBacButtonExist});

//   final List<Map<String, String>> categories = [
//     {'name': 'Dog Food & Treats', 'image': 'https://cdn5.vectorstock.com/i/1000x1000/90/19/dry-food-for-dog-line-icon-vector-36149019.jpg'},
//     {'name': 'Dog Toys & Accessories', 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHZ_JqPL32qwlYQsF6Ea8IHIMaTHaVOjBbCQ&s'},
//     {'name': 'Dog Grooming', 'image': 'https://cdn-icons-png.flaticon.com/512/8818/8818011.png'},
//     {'name': 'Cat Toys & Accessories', 'image': 'https://cdn-icons-png.flaticon.com/512/87/87969.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: shopName,
//         isBackButtonExist: isBacButtonExist,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 16,
//             crossAxisSpacing: 16,
//             childAspectRatio: 0.85,
//           ),
//           itemCount: categories.length,
//           itemBuilder: (ctx, index) => Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ProductListScreen(
//                       category: categories[index]['name']!,
//                       isBacButtonExist: true,
//                     ),
//                   ),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Center(
//                         child: Image.network(
//                           categories[index]['image']!,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       categories[index]['name']!,
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'View Products',
//                       style: TextStyle(
//                         color: Colors.purple,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProductListScreen extends StatelessWidget {
//   final String category;
//   final bool isBacButtonExist;
//   ProductListScreen({required this.category, required this.isBacButtonExist});

//   final List<Map<String, dynamic>> products = [
//     {'name': 'Pet Shampoo', 'price': 52.5, 'image': 'https://previews.123rf.com/images/yupiramos/yupiramos1802/yupiramos180224760/96068778-pet-shampoo-bottle-icon-vector-illustration-design.jpg'},
//     {'name': 'Hair Serum', 'price': 30.0, 'image': 'https://cdn-icons-png.flaticon.com/512/3079/3079165.png'},
//     {'name': 'Glossy Coat', 'price': 22.5, 'image': 'https://cdn-icons-png.flaticon.com/512/3281/3281289.png'},
//     {'name': 'Pet Brush', 'price': 15.0, 'image': 'https://cdn-icons-png.flaticon.com/512/2965/2965878.png'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: category,
//         isBackButtonExist: isBacButtonExist,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 16,
//             crossAxisSpacing: 16,
//             childAspectRatio: 0.75,
//           ),
//           itemCount: products.length,
//           itemBuilder: (ctx, index) => Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Container(
//                           height: 125,
//                           child: Image.network(
//                             products[index]['image'],
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                       Spacer(), 
//                       SizedBox(height: 8), 
//                       Text(
//                         products[index]['name'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: 5), 
//                       Row(
//                         children: [
//                           Icon(Icons.star, color: Colors.amber, size: 16),
//                           SizedBox(width: 4),
//                           Text(
//                             '4.5',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'AED ${products[index]['price']}',
//                         style: TextStyle(
//                           color: Colors.purple,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     height: 35,
//                     width: 35,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purple.withOpacity(0.2)),
//                     child: IconButton(
//                       padding: EdgeInsets.zero,
//                       icon: Icon(Icons.favorite_border, color: Colors.grey),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_sixvalley_ecommerce/features/store/main_category_provider.dart';
// import 'package:provider/provider.dart';























class MainCategoriesScreen extends StatefulWidget {
  const MainCategoriesScreen({super.key});

  @override
  State<MainCategoriesScreen> createState() => _MainCategoriesScreenState();
}

class _MainCategoriesScreenState extends State<MainCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MainCategoryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.mainCategories.isEmpty && !provider.isLoading) {
        provider.fetchMainCategories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainCategoryProvider = Provider.of<MainCategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor,
        title: const Text('Categories'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(mainCategoryProvider),
    );
  }

  Widget _buildBody(MainCategoryProvider provider) {
  if (provider.isLoading && provider.mainCategories.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }

  if (provider.error.isNotEmpty && provider.mainCategories.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: ${provider.error}'),
          ElevatedButton(
            onPressed: provider.fetchMainCategories,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  !provider.isLoadingMore &&
                  provider.hasMore) {
                provider.loadMoreCategories();
              }
              return false;
            },
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8, // Adjusted aspect ratio for better image display
              ),
              itemCount: provider.mainCategories.length + (provider.hasMore ? 1 : 0),
              itemBuilder: (ctx, index) {
                if (index >= provider.mainCategories.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                final category = provider.mainCategories[index];
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias, // This ensures the image respects the card's rounded corners
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SellerByCategoryScreen(categoryId: category.id!),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: category.icon != null && category.icon!.isNotEmpty
                              ? Image.network(
                                  'https://pgmart.shop/storage/app/public/category/${category.icon}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: const Center(
                                        child: Icon(Icons.category, size: 40, color: Colors.purple),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child: Icon(Icons.category, size: 40, color: Colors.purple),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category.name ?? 'Unknown',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
}




class Seller {
  final int id;
  final int sellerId;
  final int categoryId;
  final String name;
  final String slug;
  final String address;
  final String contact;
  final String? image;
  final String? banner;
  final String? bottomBanner;
  final String? offerBanner;
  final DateTime? vacationStartDate;
  final DateTime? vacationEndDate;
  final String? vacationNote;
  final bool vacationStatus;
  final bool temporaryClose;
  final DateTime createdAt;
  final DateTime updatedAt;

  Seller({
    required this.id,
    required this.sellerId,
    required this.categoryId,
    required this.name,
    required this.slug,
    required this.address,
    required this.contact,
    this.image,
    this.banner,
    this.bottomBanner,
    this.offerBanner,
    this.vacationStartDate,
    this.vacationEndDate,
    this.vacationNote,
    required this.vacationStatus,
    required this.temporaryClose,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      sellerId: json['seller_id'],
      categoryId: json['category_id'],
      name: json['name'],
      slug: json['slug'],
      address: json['address'],
      contact: json['contact'],
      image: json['image'],
      banner: json['banner'],
      bottomBanner: json['bottom_banner'],
      offerBanner: json['offer_banner'],
      vacationStartDate: json['vacation_start_date'] != null 
          ? DateTime.parse(json['vacation_start_date']) 
          : null,
      vacationEndDate: json['vacation_end_date'] != null 
          ? DateTime.parse(json['vacation_end_date']) 
          : null,
      vacationNote: json['vacation_note'],
      vacationStatus: json['vacation_status'] ?? false,
      temporaryClose: json['temporary_close'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class SellerByCategoryProvider with ChangeNotifier {
  List<Seller> sellers = [];
  bool isLoading = false;
  bool isLoadMore = false;
  String error = '';
  int currentPage = 1;
  int lastPage = 1;
  bool hasMorePages = true;

  int? _selectedSellerIndex;
  
  int? get selectedSellerIndex => _selectedSellerIndex;
  
  void selectSeller(int index) {
    _selectedSellerIndex = index;
    notifyListeners();
  }

  Future<void> fetchSellersByCategory(int categoryId, {bool loadMore = false}) async {
    if (loadMore) {
      if (!hasMorePages) return;
      isLoadMore = true;
    } else {
      isLoading = true;
      currentPage = 1;
      sellers.clear();
    }
    
    error = '';
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://pgmart.shop/api/v3/seller/vendors/by-category?page=$currentPage'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'category_id': categoryId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> sellersData = data['data'];
        
        sellers.addAll(sellersData.map((e) => Seller.fromJson(e)).toList());
        
        currentPage = data['current_page'] ?? currentPage;
        lastPage = data['last_page'] ?? lastPage;
        hasMorePages = data['next_page_url'] != null;
      } else {
        error = 'Failed to load sellers';
      }
    } catch (e) {
      error = 'An error occurred: $e';
    }

    isLoading = false;
    isLoadMore = false;
    notifyListeners();
  }

  Future<void> loadMore(int categoryId) async {
    if (isLoadMore || !hasMorePages) return;
    currentPage++;
    await fetchSellersByCategory(categoryId, loadMore: true);
  }
}

class SellerByCategoryScreen extends StatelessWidget {
  final int categoryId;

  const SellerByCategoryScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SellerByCategoryProvider()..fetchSellersByCategory(categoryId),
      child: Scaffold(
        appBar: CustomAppBar(
        title: getTranslated('sellers', context),
        isBackButtonExist: true,
      ),
       
        body: Consumer<SellerByCategoryProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading && provider.sellers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error.isNotEmpty && provider.sellers.isEmpty) {
              return Center(child: Text(provider.error));
            }

            if (provider.sellers.isEmpty) {
              return const Center(child: Text('No sellers found.'));
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification.metrics.pixels == 
                    scrollNotification.metrics.maxScrollExtent) {
                  provider.loadMore(categoryId);
                }
                return false;
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.84,
                  ),
                  itemCount: provider.sellers.length + (provider.hasMorePages ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= provider.sellers.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    final seller = provider.sellers[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: provider.selectedSellerIndex == index
                                  ? const BorderSide(color: Colors.purple, width: 2)
                                  : BorderSide.none,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                provider.selectSeller(index);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ShopCategoriesScreen(shopId: seller.id),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: seller.image != null
                                    ? Image.network(
                                        'https://pgmart.shop/storage/app/public/shop/${seller.image}',
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(Icons.store, size: 60, color: Colors.purple),
                                      )
                                    : const Icon(Icons.store, size: 60, color: Colors.purple),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          seller.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );

                   
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



class ShopCategoriesScreen extends StatefulWidget {
  final int shopId;

  const ShopCategoriesScreen({super.key, required this.shopId});

  @override
  State<ShopCategoriesScreen> createState() => _ShopCategoriesScreenState();
}

class _ShopCategoriesScreenState extends State<ShopCategoriesScreen> {
  bool isLoading = true;
  bool isLoadMore = false;
  String error = '';
  List<dynamic> categories = [];
  int currentPage = 1;
  int lastPage = 1;
  bool hasMore = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchShopCategories();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
      if (hasMore && !isLoadMore) {
        loadMoreCategories();
      }
    }
  }

  Future<void> fetchShopCategories() async {
    try {
      final response = await http.post(
        Uri.parse('https://pgmart.shop/api/v3/seller/category/Byshop?page=$currentPage'),
        headers: {'Accept': 'application/json'},
        body: {'shop_id': widget.shopId.toString()}, 
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          categories = data['data'];
          currentPage = data['current_page'];
          lastPage = data['last_page'];
          hasMore = currentPage < lastPage;
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load categories';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  Future<void> loadMoreCategories() async {
    if (!hasMore || isLoadMore) return;
    
    setState(() {
      isLoadMore = true;
    });

    try {
      final nextPage = currentPage + 1;
      final response = await http.post(
        Uri.parse('https://pgmart.shop/api/v3/seller/category/Byshop?page=$nextPage'),
        headers: {'Accept': 'application/json'},
        body: {'shop_id': widget.shopId.toString()}, 
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          categories.addAll(data['data']);
          currentPage = data['current_page'];
          lastPage = data['last_page'];
          hasMore = currentPage < lastPage;
          isLoadMore = false;
        });
      } else {
        setState(() {
          isLoadMore = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoadMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shop Categories',
        // title: getTranslated('sellers', context),
        isBackButtonExist: true,
      ),
     
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : categories.isEmpty
                  ? const Center(child: Text('No categories found.'))
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: categories.length + (hasMore ? 1 : 0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          if (index >= categories.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          
                          final category = categories[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryProductScreen(
                                    categoryId: category['id'],
                                    categoryName: category['name'],
                                  ),
                                ),
                              );
                            },
                            child:  Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, 
    children: [
     
      Expanded(
        flex: 3, 
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: category['icon'] != null
              ? ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    'https://pgmart.shop/storage/app/public/shopcategory/${category['icon']}',
                    fit: BoxFit.cover, 
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.category, size: 50, color: Colors.purple),
                    ),
                  ),
                )
              : Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(Icons.category, size: 50, color: Colors.purple),
                  ),
                ),
        ),
      ),
      // Text section
      Expanded(
        flex: 1, 
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text(
              category['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    ],
  ),
)
                            
                          );
                        },
                      ),
                    ),
    );
  }
}











class Product {
  final int id;
  final String name;
  final double unitPrice;
  final String? thumbnail;
  final String slug;
  final int wishListCount;

  Product({
    required this.id,
    required this.name,
    required this.unitPrice,
    this.thumbnail,
    required this.slug,
    required this.wishListCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      unitPrice: (json['unit_price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'],
      slug: json['slug'] ?? '',
      wishListCount: json['wish_list_count'] ?? 0,
    );
  }
}


class PaginatedProductResponse {
  final int currentPage;
  final int lastPage;
  final List<Product> products;
  final String? nextPageUrl;

  PaginatedProductResponse({
    required this.currentPage,
    required this.lastPage,
    required this.products,
    this.nextPageUrl,
  });

  factory PaginatedProductResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>;
    return PaginatedProductResponse(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url'],
      products: data.map((e) => Product.fromJson(e)).toList(),
    );
  }
}


class CategoryProductScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  List<Product> products = [];
  bool isLoading = false;
  bool isInitialLoading = true;
  String error = '';
  int currentPage = 1;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchProductsByCategory();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        fetchProductsByCategory();
      }
    });
  }

  Future<void> fetchProductsByCategory() async {
    if (!hasMore) return;

    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final url =
          'https://pgmart.shop/api/v1/categories/products/${widget.categoryId}?page=$currentPage';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final paginatedResponse =
            PaginatedProductResponse.fromJson(data);

        setState(() {
          products.addAll(paginatedResponse.products);
          currentPage++;
          hasMore = paginatedResponse.nextPageUrl != null;
          isInitialLoading = false;
        });
      } else {
        setState(() {
          error =
              'Failed to load products. Status code: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        title: widget.categoryName,
        isBackButtonExist: true,
      ),
      
      body: isInitialLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error))
              : products.isEmpty
                  ? const Center(child: Text('No products found.'))
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              itemCount: products.length +
                                  (isLoading ? 1 : 0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) {
                                if (index >= products.length) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                final product = products[index];
                                final imageUrl = product.thumbnail != null
                                    ? 'https://pgmart.shop/storage/app/public/product/thumbnail/${product.thumbnail}'
                                    : null;

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                          productId: product.id,
                                          slug: product.slug,
                                          isFromWishList: product.wishListCount != 0,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (imageUrl != null)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              imageUrl,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) =>
                                                  const Icon(
                                                      Icons.image_not_supported,
                                                      size: 50,
                                                      color: Colors.grey),
                                            ),
                                          )
                                        else
                                          const Icon(Icons.image,
                                              size: 50, color: Colors.grey),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(
                                            product.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'AED ${product.unitPrice.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (isLoading && products.isNotEmpty)
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ),
                        ],
                      ),
                    ),
    );
  }
}




