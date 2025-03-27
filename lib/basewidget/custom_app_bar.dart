import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final bool showActionButton;
  final Function()? onBackPressed;
  final bool centerTitle;
  final double? fontSize;
  final bool showResetIcon;
  final Widget? reset;
  final bool showLogo;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButtonExist = true,
    this.onBackPressed,
    this.centerTitle= false,
    this.showActionButton= true,
    this.fontSize,
    this.showResetIcon = false,  this.reset,  this.showLogo = false});

  @override
  Widget build(BuildContext context) {

    return PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(

          actions: showResetIcon? [reset!]:[],
          
          backgroundColor: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor
          // Theme.of(context).cardColor
          ,
            toolbarHeight: 50,
            iconTheme: IconThemeData(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor : Theme.of(context).cardColor),
            automaticallyImplyLeading: false,
            title: Text(title??'', style: textMedium.copyWith(
                fontSize: Dimensions.fontSizeLarge, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor : Theme.of(context).cardColor),
                maxLines: 1,textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),

            centerTitle: true,
            excludeHeaderSemantics: true,
            titleSpacing: 0,
            elevation: 1,
            clipBehavior: Clip.none,
            shadowColor: Theme.of(context).primaryColor.withOpacity(.1),
            leadingWidth: isBackButtonExist? 50 : 120,
            leading: isBackButtonExist ? IconButton(icon:  Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).primaryColor : Theme.of(context).cardColor),
               onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context)) :

            showLogo?
            Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
              child: SizedBox(child: Image.asset(Images.logoWithNameImage))): const SizedBox())

    );
  }

  @override
  Size get preferredSize =>  Size(MediaQuery.of(Get.context!).size.width, 50);
}