import 'package:flutter/material.dart';
import 'package:food_app/widgets/big_text.dart';

import '../utils/colors.dart';

class  CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool backButtonExist;
  final Function? onBackPressed;
  const  CustomAppBar({super.key,
    required this.title,
    this.backButtonExist =true,
    this.onBackPressed
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
     title: BigText(text: title, color: Colors.white,),
      centerTitle: true,
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      leading: backButtonExist?IconButton(
          onPressed: ()=>onBackPressed!=null?onBackPressed!():
          Navigator.pushReplacementNamed(context,"/initial"),
          icon: Icon(Icons.arrow_back_ios)):SizedBox(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(500, 50);
}
