import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/data_employee_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/pages/numeros/numeros_content.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/confirm_disable_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/detail_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/form_edit_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/form_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/source_employe.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
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

class _MyFlotteScreenState extends State<MyFlotteScreen>
    with TickerProviderStateMixin {
  final myFlotte = getIt<MyFlotteCubit>();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Onglets pilules ─────────────────────────────────────────────
        AnimatedBuilder(
          animation: _tabController,
          builder: (context, _) {
            final current = _tabController.index;
            return Row(
              children: [
                _PillTab(
                  label: 'Ma Flotte',
                  icon: Icons.people_outline,
                  isActive: current == 0,
                  onTap: () => _tabController.animateTo(0),
                ),
                SizedBox(width: 10.rw),
                _PillTab(
                  label: 'Mes Numéros',
                  icon: Icons.sim_card_outlined,
                  isActive: current == 1,
                  onTap: () => _tabController.animateTo(1),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 20.rh),

        // ─── Contenu des onglets ─────────────────────────────────────────
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _EmployesTab(myFlotte: myFlotte, s: s),
              const NumerosContent(),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Onglet Employés ─────────────────────────────────────────────────────────

class _EmployesTab extends StatefulWidget {
  final MyFlotteCubit myFlotte;
  final S s;
  const _EmployesTab({required this.myFlotte, required this.s});

  @override
  State<_EmployesTab> createState() => _EmployesTabState();
}

class _EmployesTabState extends State<_EmployesTab> {
  int _currentPage = 1;
  DataEmployeeResponseModel? _cachedData;

  @override
  void initState() {
    super.initState();
    widget.myFlotte.getEmployees(data: {'page': _currentPage});
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    widget.myFlotte.getEmployees(data: {'page': page});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyFlotteCubit, MyFlotteState>(
      bloc: widget.myFlotte,
      listener: (context, state) {
        state.maybeWhen(
          getEmployeesFailed: (message) {},
          disableEmployeeLoaded: (_) => widget.myFlotte.getEmployees(data: {'page': _currentPage}),
          disableEmployeeFailed: (message) {},
          removeNumbersLoaded: (_) => widget.myFlotte.getEmployees(data: {'page': _currentPage}),
          removeNumbersFailed: (message) {},
          assignNumbersLoaded: (_) => widget.myFlotte.getEmployees(data: {'page': _currentPage}),
          assignNumbersFailed: (message) {},
          downloadFileEmployesFailed: (message) {},
          orElse: () {},
        );
      },
      builder: (context, state) {
        if (state is GetEmployeesLoaded) _cachedData = state.data;

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
                /*Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.textHighlight(
                      widget.s.myFlotte,
                      highlight: widget.s.flotte,
                      fontSize: 22.rsp,
                      highlightColor: Colors.green,
                      fontFamily: FontFamily.syne,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0 ? '$total EMPLOYÉS' : '...',
                      fontSize: 14.rsp,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),*/
                const Spacer(),
                Row(
                  children: [
                    AppButton(
                      text: 'Fichier exemple',
                      type: AppButtonType.outline,
                      icon: Icons.download,
                      width: 180.rw,
                      height: 60.rh,
                      fontSize: 15.rsp,
                      onPressed: () => widget.myFlotte.downloadFileEmployes(),
                    ),
                    SizedBox(width: 10.rw),
                    AppButton(
                      text: 'Employé',
                      icon: Icons.add_circle_outline,
                      type: AppButtonType.secondary,
                      width: 140.rw,
                      height: 60.rh,
                      fontSize: 15.rsp,
                      onPressed: () => FormEmploye.show(
                        context,
                        myFlotteCubit: widget.myFlotte,
                        onCreated: () => widget.myFlotte.getEmployees(data: {'page': _currentPage}),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.rh),
            AppSearchInput(
              onChanged: (value) => widget.myFlotte.getEmployees(data: {'search': value}),
            ),
            SizedBox(height: 20.rh),
            FilterTabsWidget(
              tabs: [
                FilterTab(label: 'Tous', count: total > 0 ? total : null),
                const FilterTab(label: 'Active'),
                const FilterTab(label: 'Inactive'),
              ],
              onTabChanged: (model) {
                model.label == 'Tous'
                    ? widget.myFlotte.getEmployees(data: {'page': _currentPage})
                    : widget.myFlotte.getEmployees(data: {'status': model.label.toUpperCase()});
              },
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
                      fleetNumbers: e.fleetNumbers?.map((f) => f.msisdn ?? '').toList() ?? [],
                      status: e.status == 'active' || e.status == 'ACTIVE',
                      onTap: () => DetailEmploye.show(context, employee: e, myFlotteCubit: widget.myFlotte),
                    );
                  }).toList();

                  if (cards.isEmpty) return const SizedBox.shrink();

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 12.rh,
                    children: cards.map((card) => SizedBox(width: cardWidth, child: card)).toList(),
                  );
                },
              ),
              SizedBox(height: 20.rh),
              AppTable(
                title: widget.s.flotteComplete,
                source: SourceEmployes(
                  rows: employees,
                  onDetail: (e) => DetailEmploye.show(context, employee: e, myFlotteCubit: widget.myFlotte),
                  onEdit: (e) => FormEditEmploye.show(
                    context,
                    employee: e,
                    myFlotteCubit: widget.myFlotte,
                    onUpdated: () => widget.myFlotte.getEmployees(data: {'page': _currentPage}),
                  ),
                  onDisable: (e) => ConfirmDisableEmploye.show(context, employee: e, myFlotteCubit: widget.myFlotte),
                ),
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

// ─── Onglet Numéros ───────────────────────────────────────────────────────────


// ─── Pilule d'onglet ──────────────────────────────────────────────────────────

class _PillTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _PillTab({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.grayWh,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.gray,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.rw, vertical: 10.rh),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16.rsp,
                color: isActive ? AppColors.white : AppColors.textMuted,
              ),
              SizedBox(width: 7.rw),
              AppText(
                label,
                fontSize: 14.rsp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.white : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
