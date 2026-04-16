import 'package:b_selfcare/gen/assets.gen.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/left_login_deco.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthLeftPanel extends StatelessWidget {
  const AuthLeftPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 0.0.rw,
        right: 0.0.rw,
        top: 100.rh,
        bottom: 0.rh,
      ),
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset(
              Assets.images.logoWithLabel,
              width: 366.rw,
              height: 109.33.rh,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 40.rh),
          Padding(
            padding: EdgeInsets.only(left: 100.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.textHighlight(
                  s.authPanelTitle,
                  fontSize: 69.rsp,
                  color: AppColors.white,
                  highlight: s.authPanelTitleHighlight,
                  highlightColor: AppColors.secondary,
                ),
                SizedBox(height: 20.0.rh),
                AppText(
                  s.authPanelSubtitle,
                  color: AppColors.white,
                  fontFamily: "Syne",
                  fontSize: 21.rsp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          Expanded(child: LeftLoginDeco()),
        ],
      ),
    );
  }
}
