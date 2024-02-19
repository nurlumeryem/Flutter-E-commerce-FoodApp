import 'package:flutter/material.dart';
import 'package:food_app/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumn extends StatelessWidget{
  const AppColumn({super.key, required text});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: "Çin Mutfağı" , size: Dimensions.font20),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children:
              List.generate(5, (index) {return Icon(Icons.star, color: AppColors.mainColor, size: 15,);}
              ),
            ),
            SizedBox(width: 10,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "345"),
            SizedBox(width: 10,),
            SmallText(text: "Yorum"),

          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconColor:AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.3km",
                iconColor:AppColors.mainColor),
            IconAndTextWidget(icon: Icons.watch_later_outlined,
                text: "30-45 dk",
                iconColor:AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
