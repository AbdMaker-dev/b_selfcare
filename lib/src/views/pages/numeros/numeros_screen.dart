import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/flotte_number/data_flotte_number_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/flotte_number/flotte_number_cubit.dart';
import 'package:b_selfcare/src/views/pages/numeros/widgets/confirm_suspend_numero.dart';
import 'package:b_selfcare/src/views/pages/numeros/widgets/detail_numero.dart';
import 'package:b_selfcare/src/views/pages/numeros/widgets/form_assign_numero.dart';
import 'package:b_selfcare/src/views/pages/numeros/widgets/source_numeros.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:b_selfcare/src/views/widgets/table/title_table.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NumerosScreen extends StatefulWidget {
  const NumerosScreen({super.key});

  @override
  State<NumerosScreen> createState() => _NumerosScreenState();
}

class _NumerosScreenState extends State<NumerosScreen> {
  final _cubit = getIt<FlotteNumberCubit>();
  int _currentPage = 1;
  String _selectedStatus = 'ALL';
  DataFlotteNumberResponseModel? _cachedData;

  static const _filters = <TableFilter>[
    (label: 'Tous',        value: 'ALL'),
    (label: 'Actifs',      value: 'ACTIVE'),
    (label: 'Inactifs',    value: 'INACTIVE'),
    (label: 'Suspendus',   value: 'SUSPENDED'),
    (label: 'Non assignés',value: 'UNASSIGNED'),
  ];

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch({String? search}) {
    final params = <String, dynamic>{'page': _currentPage};
    if (_selectedStatus != 'ALL') params['status'] = _selectedStatus;
    if (search != null && search.isNotEmpty) params['search'] = search;
    _cubit.getNumbers(data: params);
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    _fetch();
  }

  void _onFilterChanged(String value) {
    setState(() {
      _selectedStatus = value;
      _currentPage = 1;
    });
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlotteNumberCubit, FlotteNumberState>(
      bloc: _cubit,
      listener: (context, state) {
        state.maybeWhen(
          assignNumberLoaded: (_) => _fetch(),
          suspendNumberLoaded: (_) => _fetch(),
          reactivateNumberLoaded: (_) => _fetch(),
          orElse: () {},
        );
      },
      builder: (context, state) {
        if (state is GetNumbersLoaded) _cachedData = state.data;

        final isLoading = state is GetNumbersLoading;
        final numbers = _cachedData?.data?.numbers ?? [];
        final meta = _cachedData?.data?.meta;
        final total = meta?.total ?? 0;
        final lastPage = meta?.lastPage ?? 1;

        return ListView(
          padding: EdgeInsets.only(bottom: 50.rh),
          children: [
            // ─── En-tête ────────────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.textHighlight(
                      'Mes Numéros',
                      highlight: 'Numéros',
                      fontSize: 22.rsp,
                      highlightColor: Colors.green,
                      fontFamily: FontFamily.fraunces,
                      fontStyle: FontStyle.italic,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0 ? '$total NUMÉROS' : '...',
                      fontSize: 14.5.rsp,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.rh),

            // ─── Recherche ───────────────────────────────────────────────
            AppSearchInput(
              onChanged: (value) => _fetch(search: value),
            ),
            SizedBox(height: 20.rh),

            // ─── Table ───────────────────────────────────────────────────
            if (isLoading && numbers.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.rh),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else
              AppTable(
                title: 'Liste des numéros fleet',
                source: SourceNumeros(
                  rows: numbers,
                  onDetail: (n) => DetailNumero.show(
                    context,
                    numero: n,
                    flotteNumberCubit: _cubit,
                  ),
                  onAssign: (n) => FormAssignNumero.show(
                    context,
                    numero: n,
                    flotteNumberCubit: _cubit,
                  ),
                  onSuspend: (n) => ConfirmSuspendNumero.show(
                    context,
                    numero: n,
                    flotteNumberCubit: _cubit,
                  ),
                  onReactivate: (n) {
                    if (n.id != null) _cubit.reactivateNumber(id: n.id!, data: {"reason":""});
                  },
                ),
                filters: _filters,
                selectedFilter: _selectedStatus,
                onFilterChanged: _onFilterChanged,
                currentPage: _currentPage,
                totalCount: total,
                activePreviousClicked: _currentPage > 1,
                activeNextClicked: _currentPage < lastPage,
                onPreviousClicked: _currentPage > 1 ? () => _fetchPage(_currentPage - 1) : null,
                onNextClicked: _currentPage < lastPage ? () => _fetchPage(_currentPage + 1) : null,
              ),
          ],
        );
      },
    );
  }
}
