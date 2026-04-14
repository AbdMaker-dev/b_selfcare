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
            top: -100.rh,
            child: SvgPicture.asset(
              Assets.images.decoYelow,
              width: 427.6936288034416.rw,
              height: 494.84759050928204.rh,
              fit: BoxFit.fill,
            ) ,
          ),
          Positioned(
            bottom: -150,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              Assets.images.elips,
              width: 491.39.rw,
              height: 467.88.rh,
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
