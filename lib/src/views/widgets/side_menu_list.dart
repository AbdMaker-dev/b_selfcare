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
  final bool collapsed;
  const SideMenuList({super.key, this.collapsed = false});

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
    final collapsed = widget.collapsed;

    return Column(
      children: [
        SizedBox(height: 10.rh),
        if (!collapsed)
          Container(
            width: 193.91.rw,
            height: 65.52.rh,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: SvgPicture.asset(Assets.logo.logo, fit: BoxFit.contain),
          )
        else
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.rh),
            child: SvgPicture.asset(
              Assets.logo.logo,
              fit: BoxFit.contain,
              height: 36.rh,
            ),
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

        if (!collapsed)
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
                _GlowDot(),
                Expanded(
                  child: AppText(
                    getIt<LayoutCubit>().currentUser?.company?.name ?? "My Company",
                    color: AppColors.white,
                    fontSize: 16.rsp,
                    fontWeight: FontWeight.w500,
                    onClick: () => context.router.pushPath('$routeApp/$routeAppDashbord'),
                  ),
                ),
              ],
            ),
          )
        else
          Tooltip(
            message: getIt<LayoutCubit>().currentUser?.company?.name ?? "My Company",
            child: Container(
              width: 36.rw,
              height: 36.rh,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(6.rw),
              ),
              child: Center(child: _GlowDot()),
            ),
          ),

        SizedBox(height: 20.rh),

        MenuSeparator(title: 'MON ESPACE', collapsed: collapsed),
        CustomItemMenu(
          title: "Accueil",
          icon: Icons.dashboard,
          isActive: context.router.currentUrl.contains("dashbord"),
          collapsed: collapsed,
          onSelect: () => context.router.pushPath('$routeApp/$routeAppDashbord'),
        ),
        CustomItemMenu(
          title: "Ma flotte",
          icon: Icons.sim_card,
          isActive: context.router.currentUrl.contains("flotte"),
          collapsed: collapsed,
          onSelect: () => context.router.pushPath('$routeApp/$routeAppMyFlotte'),
        ),
        CustomItemMenu(
          title: "Mes groupes",
          icon: Icons.group,
          isActive: context.router.currentUrl.contains("groupes"),
          collapsed: collapsed,
          onSelect: () => context.router.pushPath('$routeApp/$routeAppGroups'),
        ),
        CustomItemMenu(
          title: "Mes campagnes",
          icon: Icons.dashboard,
          isActive: context.router.currentUrl.contains("campagnes"),
          collapsed: collapsed,
          onSelect: () => context.router.pushPath('$routeApp/$routeAppMyCampagnes'),
        ),
        CustomItemMenu(
          title: "Mes produits",
          icon: Icons.card_giftcard_sharp,
          isActive: context.router.currentUrl.contains("products"),
          collapsed: collapsed,
          onSelect: () => context.router.pushPath('$routeApp/$routeAppProducts'),
        ),

        SizedBox(height: 20.rh),
        MenuSeparator(title: 'COMPTE', collapsed: collapsed),
        CustomItemMenu(
          title: "Utilisateurs",
          icon: Icons.manage_accounts,
          isActive: context.router.currentUrl.contains("users"),
          collapsed: collapsed,
          onSelect: () => context.router.pushPath('$routeApp/$routeAppUsers'),
        ),
      ],
    );
  }
}

class _GlowDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class MenuSeparator extends StatelessWidget {
  final String title;
  final bool collapsed;
  const MenuSeparator({super.key, required this.title, this.collapsed = false});

  @override
  Widget build(BuildContext context) {
    if (collapsed) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.rh, horizontal: 8.rw),
        child: Divider(
          color: AppColors.white.withValues(alpha: 0.3),
          thickness: 1,
          height: 0,
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(left: 10.rw, bottom: 5.rh),
      child: Row(
        spacing: 2.rw,
        children: [AppText(title, fontSize: 15.rsp, color: AppColors.white)],
      ),
    );
  }
}

class CustomItemMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final bool collapsed;
  final Function()? onSelect;
  const CustomItemMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.isActive,
    this.collapsed = false,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    if (collapsed) {
      return Tooltip(
        message: title,
        child: InkWell(
          onTap: onSelect,
          child: Container(
            width: double.infinity,
            height: 45.rh,
            decoration: BoxDecoration(
              color: isActive ? AppColors.secondary.withValues(alpha: 0.1) : null,
              border: Border(
                left: BorderSide(
                  color: isActive ? AppColors.secondary : Colors.transparent,
                  width: 3.rw,
                ),
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: isActive ? AppColors.secondary : AppColors.white,
                size: 20.rsp,
              ),
            ),
          ),
        ),
      );
    }

    return InkWell(
      onTap: onSelect,
      child: Container(
        width: double.infinity,
        height: 45.rh,
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
              size: 15.rsp,
            ),
            AppText(
              title,
              color: isActive ? AppColors.secondary : AppColors.white,
              fontSize: 16.rsp,
              onClick: onSelect,
            ),
          ],
        ),
      ),
    );
  }
}
