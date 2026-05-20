import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/assets.gen.dart';
import 'package:b_selfcare/routers/app_router.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenuList extends StatefulWidget {
  const SideMenuList({super.key});

  @override
  State<SideMenuList> createState() => _SideMenuListState();
}

class _SideMenuListState extends State<SideMenuList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.rh),
        Container(
          width: 193.91.rw,
          height: 65.52.rh,
          decoration: BoxDecoration(color: Colors.transparent),
          child: SvgPicture.asset(Assets.logo.logo, fit: BoxFit.contain),
        ),
        SizedBox(height: 10.rh),
        Divider(
          color: AppColors.white,
          thickness: 1.rw,
          indent: 10.rw,
          endIndent: 10.rw,
          height: 0.rh,
        ),
        SizedBox(height: 20.rh),

        Container(
          height: 40.rh,
          margin: EdgeInsets.symmetric(horizontal: 10.rw),
          padding: EdgeInsets.symmetric(horizontal: 15.rw),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(6.rw),
          ),
          child: Row(
            spacing: 10.rw,
            children: [
              Container(
                width: 10.rw,
                height: 10.rh,
                decoration: BoxDecoration(
                  color: AppColors.greenDull,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greenDull.withValues(alpha: 0.9),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: AppColors.greenDull.withValues(alpha: 0.4),
                      blurRadius: 16,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
              AppText(
                getIt<LayoutCubit>().currentUser?.company?.name ?? "My Company",
                color: AppColors.white,
                fontSize: 14.rsp,
                fontWeight: FontWeight.w500,
                onClick: () => context.router.pushPath('$routeApp/$routeAppDashbord'),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.rh),

        const MenuSeparator(title: 'MON ESPACE'),
        CustomItemMenu(
          title: "Accueil",
          icon: Icons.dashboard,
          isActive: context.router.currentUrl.contains("dashbord"),
          onSelect: () => context.router.pushPath('$routeApp/$routeAppDashbord'),
        ),
        CustomItemMenu(
          title: "Ma flotte",
          icon: Icons.sim_card,
          isActive: context.router.currentUrl.contains("flotte"),
          onSelect: () => context.router.pushPath('$routeApp/$routeAppMyFlotte'),
        ),
        CustomItemMenu(
          title: "Mes groupes",
          icon: Icons.group,
          isActive: context.router.currentUrl.contains("groupes"),
          onSelect: () => context.router.pushPath('$routeApp/$routeAppGroups'),
        ),
        CustomItemMenu(
          title: "Mes campagnes",
          icon: Icons.dashboard,
          isActive: context.router.currentUrl.contains("campagnes"),
          onSelect: () => context.router.pushPath('$routeApp/$routeAppMyCampagnes'),
        ),
        CustomItemMenu(
          title: "Mes produits",
          icon: Icons.card_giftcard_sharp,
          isActive: context.router.currentUrl.contains("products"),
          onSelect: () => context.router.pushPath('$routeApp/$routeAppProducts'),
        ),
      ],
    );
  }
}

class MenuSeparator extends StatelessWidget {
  final String title;
  const MenuSeparator({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.rw, bottom: 5.rh),
      child: Row(
        spacing: 2.rw,
        children: [AppText(title, fontSize: 12.5.rsp, color: AppColors.white)],
      ),
    );
  }
}

class CustomItemMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final Function()? onSelect;
  const CustomItemMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.isActive,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        width: double.infinity,
        height: 42.rh,
        padding: EdgeInsets.symmetric(horizontal: 20.rw),
        decoration: BoxDecoration(
          color: isActive ? AppColors.secondary.withValues(alpha: 0.1) : null,
          border: Border(
            left: BorderSide(
              color: isActive ? AppColors.secondary : Colors.transparent,
              width: 3.rw,
            ),
          ),
        ),
        child: Row(
          spacing: 5.rw,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.secondary : AppColors.white,
              size: 14.rsp,
            ),
            AppText(
              title,
              color: isActive ? AppColors.secondary : AppColors.white,
              fontSize: 14.rsp,
              onClick: onSelect,
            ),
          ],
        ),
      ),
    );
  }
}
