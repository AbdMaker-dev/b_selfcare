import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/data/models/resource_custom/resource_custom_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/pages/recovery_resource/widgets/recovery_history_panel.dart';
import 'package:b_selfcare/src/views/pages/recovery_resource/widgets/recovery_left_panel.dart';
import 'package:b_selfcare/src/views/pages/recovery_resource/widgets/recovery_resource_panel.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class RecoveryResourceScreen extends StatefulWidget {
  const RecoveryResourceScreen({super.key});

  @override
  State<RecoveryResourceScreen> createState() => _RecoveryResourceScreenState();
}

class _RecoveryResourceScreenState extends State<RecoveryResourceScreen> {
  final _cubit = getIt<MyFlotteCubit>();

  EmployeeModel? _selectedEmployee;
  int _selectedNumberIndex = 0;

  final Map<int, ResourceCustomModel> _resourcesCache = {};
  int? _loadingNumberId;

  final Map<String, TextEditingController> _unitControllers = {};
  final TextEditingController _mainCreditController = TextEditingController();
  bool _isCustomAmount = false;

  List<FleetNumberModel> get _numbers =>
      _selectedEmployee?.fleetNumbers ?? [];

  FleetNumberModel? get _selectedNumber =>
      _numbers.isNotEmpty ? _numbers[_selectedNumberIndex] : null;

  @override
  void initState() {
    super.initState();
    _mainCreditController.addListener(_updateIsCustomAmount);
    _cubit.getEmployees(data: {'page': 1});
  }

  @override
  void dispose() {
    for (final c in _unitControllers.values) {
      c.dispose();
    }
    _mainCreditController.dispose();
    super.dispose();
  }

  void _updateIsCustomAmount() {
    final id = _selectedNumber?.id;
    if (id == null) {
      if (_isCustomAmount) setState(() => _isCustomAmount = false);
      return;
    }
    final resource = _resourcesCache[id];
    if (resource == null) {
      if (_isCustomAmount) setState(() => _isCustomAmount = false);
      return;
    }

    bool modified = false;

    for (final u in resource.freeUnits ?? []) {
      final key = u.freeUnitType ?? u.measureUnit ?? '';
      final controller = _unitControllers[key];
      if (controller == null) continue;
      final max = RecoveryResourcePanel.toDisplayAmount(u);
      if ((int.tryParse(controller.text) ?? 0) != max) {
        modified = true;
        break;
      }
    }

    if (!modified) {
      final maxCredit = resource.mainCreditFcfa ?? 0;
      if ((int.tryParse(_mainCreditController.text) ?? 0) != maxCredit) {
        modified = true;
      }
    }

    if (modified != _isCustomAmount) setState(() => _isCustomAmount = modified);
  }

  void _selectEmployee(EmployeeModel e) {
    _clearControllers();
    setState(() {
      _selectedEmployee = e;
      _selectedNumberIndex = 0;
      _resourcesCache.clear();
      _loadingNumberId = null;
    });
    _loadForIndex(0);
  }

  void _selectNumber(int index) {
    setState(() => _selectedNumberIndex = index);
    _loadForIndex(index);
  }

  void _loadForIndex(int index) {
    final numbers = _selectedEmployee?.fleetNumbers ?? [];
    if (index >= numbers.length) return;
    final id = numbers[index].id;
    if (id == null) return;

    if (!_resourcesCache.containsKey(id)) {
      setState(() => _loadingNumberId = id);
      _cubit.getResourceEmploye(fleetNumberId: id);
    } else {
      _refreshControllers();
    }

    _cubit.historiqueRecoveryEmployee(
        fleetNumberId: id, data: {'page': 1});
  }

  void _clearEmployee() {
    _clearControllers();
    setState(() {
      _selectedEmployee = null;
      _selectedNumberIndex = 0;
      _resourcesCache.clear();
      _loadingNumberId = null;
    });
    _cubit.getEmployees(data: {'page': 1});
  }

  void _clearControllers() {
    for (final c in _unitControllers.values) {
      c.dispose();
    }
    _unitControllers.clear();
    _mainCreditController.text = '';
    _isCustomAmount = false;
  }

  void _fillAll() {
    final id = _selectedNumber?.id;
    if (id == null) return;
    final resource = _resourcesCache[id];
    if (resource == null) return;

    for (final u in resource.freeUnits ?? []) {
      final key = u.freeUnitType ?? u.measureUnit ?? '';
      final controller = _unitControllers[key];
      if (controller != null) {
        controller.text =
            RecoveryResourcePanel.toDisplayAmount(u).toString();
      }
    }
    _mainCreditController.text = (resource.mainCreditFcfa ?? 0).toString();
  }

  void _refreshControllers() {
    final id = _selectedNumber?.id;
    if (id == null) return;
    final resource = _resourcesCache[id];
    if (resource == null) return;

    for (final c in _unitControllers.values) {
      c.dispose();
    }
    _unitControllers.clear();

    for (final u in resource.freeUnits ?? []) {
      final key = u.freeUnitType ?? u.measureUnit ?? '';
      if (key.isEmpty) continue;
      final amount = RecoveryResourcePanel.toDisplayAmount(u);
      final controller = TextEditingController(text: amount.toString());
      controller.addListener(_updateIsCustomAmount);
      _unitControllers[key] = controller;
    }

    _mainCreditController.text = (resource.mainCreditFcfa ?? 0).toString();
    setState(() => _isCustomAmount = false);
  }

  void _launch() {
    AppConfirmDialog.show(
      context: context,
      title: 'Confirmer la récupération',
      message:
          'Cette opération est irréversible. Les ressources de l\'employé seront converties en FCFA via revokeBundle CBS.',
      confirmLabel: 'Lancer revokeBundle',
      isDanger: true,
      onConfirm: _doLaunch,
    );
  }

  void _doLaunch() {
    final id = _selectedNumber?.id;
    if (id == null) return;
    final resource = _resourcesCache[id];
    final body = {
      'main_credit_fcfa': int.tryParse(_mainCreditController.text) ?? 0,
      'bundles': (resource?.freeUnits ?? [])
          .map((u) {
            final key = u.freeUnitType ?? u.measureUnit ?? '';
            final controller = _unitControllers[key];
            final inputAmount = int.tryParse(controller?.text ?? '') ?? 0;

            final rawUnit = (u.unit ?? '').toLowerCase();
            final String convertedUnit;
            final int convertedAmount;

            if (rawUnit.startsWith('min')) {
              convertedUnit = u.unit ?? rawUnit;
              convertedAmount = inputAmount;
            } else if (rawUnit.contains('mb') ||
                rawUnit.contains('gb') ||
                rawUnit.contains('byte')) {
              convertedUnit = 'MB_GB';
              convertedAmount = inputAmount * 1024; // Go → MB
            } else {
              convertedUnit = u.unit ?? rawUnit;
              convertedAmount = inputAmount;
            }

            return {
              'free_unit_type': u.freeUnitType,
              'amount': convertedAmount,
              'unit': convertedUnit,
            };
          })
          .toList(),
    };
    _cubit.recoveryConfirmEmployee(fleetNumberId: id, data: body);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFlotteCubit, MyFlotteState>(
      bloc: _cubit,
      listener: (context, state) {
        state.maybeWhen(
          getResourceEmployeLoaded: (data) {
            final model = data.data;
            if (model == null) return;
            final matchId = _numbers
                    .where((n) =>
                        n.msisdn == model.msisdn || n.id == _loadingNumberId)
                    .map((n) => n.id)
                    .whereType<int>()
                    .firstOrNull ??
                _loadingNumberId;
            if (matchId != null) {
              setState(() {
                _resourcesCache[matchId] = model;
                _loadingNumberId = null;
              });
              _refreshControllers();
            }
          },
          recoveryConfirmEmployeeLoaded: (_) {
            final id = _selectedNumber?.id;
            if (id != null) {
              _clearControllers();
              setState(() {
                _resourcesCache.remove(id);
                _loadingNumberId = id;
              });
              _cubit.getResourceEmploye(fleetNumberId: id);
              _cubit.historiqueRecoveryEmployee(
                  fleetNumberId: id, data: {'page': 1});
            }
          },
          orElse: () {},
        );
      },
      child: ListView(
        padding: EdgeInsets.only(bottom: 50.rh),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText.textHighlight(
                'Récupération resources',
                highlight: 'resources',
                fontSize: 24.rsp,
                fontFamily: FontFamily.montserrat,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                highlightColor: AppColors.greenDull,
                highlightFontSize: 24.rsp,
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: 24.rh),

          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 700;

              final leftPanel = Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.rr),
                  border: Border.all(color: AppColors.gray),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.rw, vertical: 10.rh),
                      decoration: BoxDecoration(
                        color: AppColors.grayWh,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.rr),
                          topRight: Radius.circular(12.rr),
                        ),
                        border: Border(
                            bottom: BorderSide(color: AppColors.gray)),
                      ),
                      child: Row(
                        children: [
                          AppText(
                            'Lancer récupération',
                            fontSize: 13.rsp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                          const Spacer(),
                          AppText(
                            'revokeBundle CBS SOAP',
                            fontSize: 11.rsp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textBody,
                            fontFamily: FontFamily.syne,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(14.rw),
                      child: RecoveryLeftPanel(
                        cubit: _cubit,
                        selectedEmployee: _selectedEmployee,
                        selectedNumberIndex: _selectedNumberIndex,
                        numbers: _numbers,
                        onSelectEmployee: _selectEmployee,
                        onSelectNumber: _selectNumber,
                        onClear: _clearEmployee,
                        onLaunch:
                            (_selectedEmployee == null || _numbers.isEmpty)
                                ? null
                                : _launch,
                        resourcePanel: _selectedEmployee == null
                            ? null
                            : RecoveryResourcePanel(
                                numbers: _numbers,
                                selectedIndex: _selectedNumberIndex,
                                resourcesCache: _resourcesCache,
                                loadingNumberId: _loadingNumberId,
                                unitControllers: _unitControllers.isEmpty
                                    ? null
                                    : _unitControllers,
                                mainCreditController: _mainCreditController,
                                onFillAll: _unitControllers.isEmpty
                                    ? null
                                    : _fillAll,
                                isCustomAmount: _isCustomAmount,
                              ),
                      ),
                    ),
                  ],
                ),
              );

              final historyPanel = _selectedEmployee == null
                  ? null
                  : RecoveryHistoryPanel(
                      cubit: _cubit,
                      fleetNumberId: _selectedNumber?.id,
                    );

              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: leftPanel),
                    if (historyPanel != null) ...[
                      SizedBox(width: 16.rw),
                      Expanded(flex: 7, child: historyPanel),
                    ],
                  ],
                );
              }
              return Column(
                children: [
                  leftPanel,
                  if (historyPanel != null) ...[
                    SizedBox(height: 16.rh),
                    historyPanel,
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
