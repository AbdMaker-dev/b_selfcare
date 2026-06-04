import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/confirm_dialog.dart';
import 'package:b_selfcare/src/views/widgets/dashboard_app_bar.dart';
import 'package:b_selfcare/src/views/widgets/side_menu_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final LayoutCubit _cubit = getIt<LayoutCubit>();

  Widget _buildSideMenu({required bool collapsed}) {
    return AnimatedContainer(
      width: collapsed ? 65.rw : 252.rw,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(color: AppColors.primary),
      padding: EdgeInsets.only(bottom: 10.rh),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100.rh),
                  child: BlocSelector<LayoutCubit, LayoutState, AppMainRouteChange?>(
                    bloc: _cubit,
                    selector: (state) => state.map(
                      initial: (_) => null,
                      routeChanged: (v) => v,
                    ),
                    builder: (context, state) => SideMenuList(collapsed: collapsed),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _UserFooter(cubit: _cubit, collapsed: collapsed),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isCollapsed = screenWidth >= 600 && screenWidth < 1024;

    final mainContent = Column(
      children: [
        DashboardAppBar(
          companyName: _cubit.currentUser?.company?.name ?? '—',
          solde: _cubit.currentUser?.company?.formattedBalance ?? '—',
          isActif: _cubit.currentUser?.company?.status == 'ACTIVE',
          onActualiser: () {},
          onRecharger: () {},
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 25.rh),
            child: const AutoRouter(),
          ),
        ),
      ],
    );

    if (isMobile) {
      return Scaffold(
        backgroundColor: AppColors.background,
        drawer: Drawer(
          width: 252.rw,
          backgroundColor: AppColors.primary,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 100.rh),
                child: BlocSelector<LayoutCubit, LayoutState, AppMainRouteChange?>(
                  bloc: _cubit,
                  selector: (state) => state.map(
                    initial: (_) => null,
                    routeChanged: (v) => v,
                  ),
                  builder: (context, state) => const SideMenuList(),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _UserFooter(cubit: _cubit, collapsed: false),
              ),
            ],
          ),
        ),
        body: mainContent,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            _buildSideMenu(collapsed: isCollapsed),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}

class _UserFooter extends StatelessWidget {
  final LayoutCubit cubit;
  final bool collapsed;
  const _UserFooter({required this.cubit, this.collapsed = false});

  @override
  Widget build(BuildContext context) {
    final user = cubit.currentUser;
    final fullName = user?.fullName ?? '—';
    final role = user?.roles.firstOrNull?.displayName ?? user?.roles.firstOrNull?.name ?? '—';

    final logoutButton = IconButton(
      onPressed: () => AppConfirmDialog.show(
        context: context,
        title: 'Se déconnecter',
        message: 'Voulez-vous vraiment quitter votre session ?',
        confirmLabel: 'Déconnecter',
        cancelLabel: 'Annuler',
        isDanger: true,
        onConfirm: () async {
          await cubit.logout();
          if (context.mounted) {
            context.router.replaceAll([const LoginRoute()]);
          }
        },
      ),
      icon: Icon(Icons.logout, color: AppColors.secondary, size: 20.rsp),
      tooltip: 'Se déconnecter',
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.12))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh),
      child: collapsed
          ? Center(child: logoutButton)
          : Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        fullName,
                        fontSize: 16.rsp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(height: 2.rh),
                      AppText(
                        role,
                        fontSize: 14.rsp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ],
                  ),
                ),
                logoutButton,
              ],
            ),
    );
  }
}
