import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_restaurant/core/constants/general_const.dart';

class CustomSocialMediaBlock extends StatelessWidget {
  final String? text;
  final void Function()? onTapFacebook;
  final void Function()? onTapGoogle;
  final EdgeInsets? margin;
  const CustomSocialMediaBlock({
    super.key,
    this.text,
    this.onTapFacebook,
    this.onTapGoogle,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: MediaQuery.sizeOf(context).width,
      margin: margin ?? const EdgeInsets.all(10),
      child: Column(
        children: [
          //text section
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(text ?? '')),
          // social media icons section
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: onTapFacebook,
                    child: Container(
                        width: 92,
                        height: 62,
                        decoration: _iconBoxDecoration(),
                        child: SvgPicture.asset(
                          GOOGLE_ICON,
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        ))),
                const SizedBox(
                  width: 30,
                ),
                InkWell(
                    onTap: onTapFacebook,
                    child: Container(
                        width: 92,
                        height: 62,
                        decoration: _iconBoxDecoration(),
                        child: SvgPicture.asset(
                          FACEBOOK_ICON,
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        ))),
              ],
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration _iconBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color.fromRGBO(255, 255, 255, 1),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(0,0,0,0.05,),
              offset: Offset(0, 1),
              blurRadius: 8)
        ]);
  }
}
