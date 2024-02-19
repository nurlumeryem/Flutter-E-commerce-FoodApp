import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_text.dart';

import '../utils/colors.dart';

class CommonTextButton extends StatelessWidget{
  final String text;
  const CommonTextButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.height20),
      child: Center(child: BigText(text: "check out",color:  Colors.white,)),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          offset: Offset(0, 5),
          blurRadius: 10,
          color: AppColors.mainColor.withOpacity(0.3),
        ),],
        borderRadius: BorderRadius.circular(Dimensions.width20),
        color: AppColors.mainColor
      ),
    );
  }
}
