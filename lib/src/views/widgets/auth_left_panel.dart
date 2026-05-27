import 'package:b_selfcare/gen/assets.gen.dart';
// import 'package:b_selfcare/generated/l10n.dart';
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
    // final s = S.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 0.0.rw,
        right: 0.0.rw,
        top: 30.rh,
        bottom: 0.rh,
      ),
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset(
              Assets.logo.logo,
              width: 366.rw,
              height: 109.33.rh,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20.rh),
          Padding(
            padding: EdgeInsets.only(left: 100.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.textHighlight(
                  "Votre entreprise,\nVotre flotte,\nVotre contrôle.",
                  fontSize: 49.rsp,
                  color: AppColors.white,
                  highlight: "flotte",
                  highlightColor: AppColors.secondary,
                ),
                SizedBox(height: 15.0.rh),
                AppText(
                  "Gérez vos lignes mobiles, programmez vos dotations et\nsuivez vos dépenses directement depuis votre espace.",
                  color: AppColors.white,
                  fontFamily: "Syne",
                  fontSize: 21.rsp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.rh),

          Expanded(child: LeftLoginDeco()),
        ],
      ),
    );
  }
}
