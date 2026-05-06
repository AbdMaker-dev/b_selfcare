import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/data_employee_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/source_employe.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab_widget.dart';
import 'package:b_selfcare/src/views/widgets/info_flotte_card.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyFlotteScreen extends StatefulWidget {
  const MyFlotteScreen({super.key});

  @override
  State<MyFlotteScreen> createState() => _MyFlotteScreenState();
}

class _MyFlotteScreenState extends State<MyFlotteScreen> {
  final myFlotte = getIt<MyFlotteCubit>();
  int _currentPage = 1;
  DataEmployeeResponseModel? _cachedData;

  @override
  void initState() {
    super.initState();
    myFlotte.getEmployees(data: {'page': _currentPage});
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    myFlotte.getEmployees(data: {'page': page});
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<MyFlotteCubit, MyFlotteState>(
      bloc: myFlotte,
      listener: (context, state) {
        state.maybeWhen(
          getEmployeesFailed: (message) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: AppColors.error),
          ),
          orElse: () {},
        );
      },
      builder: (context, state) {
        if (state is GetEmployeesLoaded) {
          _cachedData = state.data;
        }

        final isLoading = state is GetEmployeesLoading;
        final employees = _cachedData?.data?.employees ?? [];
        final meta = _cachedData?.data?.meta;
        final total = meta?.total ?? 0;
        final lastPage = meta?.lastPage ?? 1;

        return ListView(
          padding: EdgeInsets.only(bottom: 50.rh),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.textHighlight(
                      s.myFlotte,
                      highlight: s.flotte,
                      fontSize: 22.rsp,
                      highlightColor: Colors.green,
                      fontFamily: FontFamily.syne,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0 ? '$total EMPLOYÉS' : '...',
                      fontSize: 11.rsp,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    AppButton(
                      text: s.simSwap,
                      type: AppButtonType.outline,
                      icon: Icons.swap_horiz,
                      width: 130.rw,
                      height: 38.rh,
                      fontSize: 13.rsp,
                      onPressed: () {},
                    ),
                    SizedBox(width: 10.rw),
                    AppButton(
                      text: '+ Employé',
                      type: AppButtonType.secondary,
                      width: 130.rw,
                      height: 38.rh,
                      fontSize: 13.rsp,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.rh),
            FilterTabsWidget(
              tabs: [
                FilterTab(label: 'Tous', count: total > 0 ? total : null),
                const FilterTab(label: 'Actifs'),
                const FilterTab(label: 'Groupes'),
                const FilterTab(label: 'Sans produit'),
              ],
              onTabChanged: (model) {},
            ),
            SizedBox(height: 20.rh),
            if (isLoading && employees.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.rh),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else ...[
              LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final crossAxisCount = totalWidth > 900 ? 3 : totalWidth > 550 ? 2 : 1;
                  final spacing = 12.rw;
                  final cardWidth = (totalWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

                  final cards = employees.take(6).map((e) {
                    final name = '${e.firstName ?? ''} ${e.lastName ?? ''}'.trim();
                    return InfoFlotteCard(
                      name: name.isNotEmpty ? name : '-',
                      department: e.position ?? '-',
                      forfait: '${e.fleetNumbersCount ?? 0} numéros',
                      phone: e.phone ?? '-',
                      status: e.status == 'active',
                    );
                  }).toList();

                  if (cards.isEmpty) return const SizedBox.shrink();

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 12.rh,
                    children: cards
                        .map((card) => SizedBox(width: cardWidth, child: card))
                        .toList(),
                  );
                },
              ),
              SizedBox(height: 20.rh),
              AppTable(
                title: s.flotteComplete,
                source: SourceEmployes(rows: employees),
                currentPage: _currentPage,
                totalCount: total,
                activePreviousClicked: _currentPage > 1,
                activeNextClicked: _currentPage < lastPage,
                onPreviousClicked: _currentPage > 1 ? () => _fetchPage(_currentPage - 1) : null,
                onNextClicked: _currentPage < lastPage ? () => _fetchPage(_currentPage + 1) : null,
              ),
            ],
          ],
        );
      },
    );
  }
}
