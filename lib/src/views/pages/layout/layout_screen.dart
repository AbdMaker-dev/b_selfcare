import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            AnimatedContainer(
              width: 252.rw,
              duration: const Duration(milliseconds: 50),
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
                            bloc: getIt<LayoutCubit>(),
                            selector: (state){
                              return state.map(
                                initial: (value){
                                  return null;
                                },
                                routeChanged: (value){
                                  return value;
                                },
                              );
                            },
                            builder: (context, state){
                              return SideMenuList();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AppButton(
                      text: "Se Deconnecter",
                      type: AppButtonType.primary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 1476.rw,
              height: 1223.rh,
              child: Column(
                children: [
                  DashboardAppBar(
                    companyName: 'CORTECH GROUP',
                    solde: '2 850 000 Fcfa',
                    isActif: false,
                    onActualiser: () {},
                    onRecharger: () {},
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 25.rh),
                      child: AutoRouter(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
