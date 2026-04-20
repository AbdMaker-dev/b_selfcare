import 'package:b_selfcare/gen/assets.gen.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LeftLoginDeco extends StatelessWidget {
  const LeftLoginDeco({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.loose,
        children: [
          Positioned(
            top: -90.rh,
            child: SvgPicture.asset(
              Assets.images.decoYelow,
              width: 450.39.rw,
              height: 400.8779021606497.rh,
              fit: BoxFit.fill,
            ) ,
          ),


          Positioned(
            bottom: -650.rh,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              Assets.images.elips,
              width: 957.rw,
              height: 957.rh,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 50.rh,
            bottom: 0,
            child: Image.asset(
              "assets/images/smiley-man-with-old-phone 1.png",
              width: 536.rw,
              height: 590.rh,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
