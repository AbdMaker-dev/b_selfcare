import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoveryEmployeeDropdown extends StatefulWidget {
  final MyFlotteCubit cubit;
  final void Function(EmployeeModel) onSelect;

  const RecoveryEmployeeDropdown({
    super.key,
    required this.cubit,
    required this.onSelect,
  });

  @override
  State<RecoveryEmployeeDropdown> createState() =>
      _RecoveryEmployeeDropdownState();
}

class _RecoveryEmployeeDropdownState extends State<RecoveryEmployeeDropdown> {
  final _searchController = TextEditingController();
  final _triggerKey = GlobalKey();
  final _layerLink = LayerLink();

  OverlayEntry? _overlay;
  bool _isOpen = false;
  String _query = '';
  List<EmployeeModel> _employees = [];

  @override
  void dispose() {
    _closeOverlay();
    _searchController.dispose();
    super.dispose();
  }

  String _label(EmployeeModel e) =>
      '${e.firstName ?? ''} ${e.lastName ?? ''}'.trim();

  List<EmployeeModel> get _filtered {
    if (_query.isEmpty) return _employees;
    final q = _query.toLowerCase();
    return _employees
        .where((e) => _label(e).toLowerCase().contains(q))
        .toList();
  }

  void _openOverlay() {
    if (_isOpen) return;
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final size = box.size;

    _overlay = OverlayEntry(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _closeOverlay,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 4),
              child: GestureDetector(
                onTap: () {},
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10.rr),
                  color: Colors.white,
                  child: Container(
                    width: size.width,
                    constraints: BoxConstraints(maxHeight: 280.rh),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.rr),
                      border: Border.all(color: AppColors.gray),
                    ),
                    child: StatefulBuilder(
                      builder: (context, setOverlayState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.rw),
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                style: TextStyle(
                                  fontSize: 13.rsp,
                                  color: AppColors.textHeading,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Rechercher un employé...',
                                  hintStyle: TextStyle(
                                    fontSize: 13.rsp,
                                    color: AppColors.textMuted,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search_rounded,
                                    size: 16.rsp,
                                    color: AppColors.textMuted,
                                  ),
                                  isDense: true,
                                  filled: true,
                                  fillColor: AppColors.grayWh,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(8.rr),
                                    borderSide:
                                        BorderSide(color: AppColors.gray),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(8.rr),
                                    borderSide: BorderSide(
                                        color: AppColors.primary,
                                        width: 1.5),
                                  ),
                                ),
                                onChanged: (v) {
                                  setState(() => _query = v);
                                  setOverlayState(() {});
                                },
                              ),
                            ),
                            const Divider(height: 1),
                            Flexible(
                              child: _filtered.isEmpty
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20.rh),
                                      child: Center(
                                        child: AppText(
                                          'Aucun employé trouvé',
                                          fontSize: 13.rsp,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4.rh),
                                      shrinkWrap: true,
                                      itemCount: _filtered.length,
                                      itemBuilder: (_, i) {
                                        final e = _filtered[i];
                                        final name = _label(e);
                                        final group = e.group?.name;
                                        final msisdns = (e.fleetNumbers ?? [])
                                            .map((f) => f.msisdn ?? '')
                                            .where((s) => s.isNotEmpty)
                                            .join(' · ');
                                        return InkWell(
                                          onTap: () {
                                            widget.onSelect(e);
                                            _closeOverlay();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14.rw,
                                                vertical: 10.rh),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  name.isNotEmpty ? name : '---',
                                                  fontSize: 13.rsp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.textHeading,
                                                ),
                                                if (group != null || msisdns.isNotEmpty)
                                                  SizedBox(height: 2.rh),
                                                if (group != null)
                                                  AppText(
                                                    group,
                                                    fontSize: 12.rsp,
                                                    color: AppColors.textMuted,
                                                  ),
                                                if (msisdns.isNotEmpty)
                                                  AppText(
                                                    msisdns,
                                                    fontSize: 12.rsp,
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlay!);
    setState(() => _isOpen = true);
  }

  void _closeOverlay() {
    _overlay?.remove();
    _overlay = null;
    _searchController.clear();
    setState(() {
      _isOpen = false;
      _query = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyFlotteCubit, MyFlotteState>(
      bloc: widget.cubit,
      buildWhen: (_, state) => state.maybeWhen(
        getEmployeesLoading: () => true,
        getEmployeesLoaded: (_) => true,
        getEmployeesFailed: (_) => true,
        orElse: () => false,
      ),
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          getEmployeesLoading: () => true,
          orElse: () => false,
        );

        _employees = state.maybeWhen(
          getEmployeesLoaded: (data) =>
              (data.data?.employees ?? <EmployeeModel>[])
                  .where((e) => (e.fleetNumbersCount ?? 0) > 0)
                  .toList(),
          orElse: () => _employees,
        );

        final border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.rr),
          borderSide: BorderSide(color: AppColors.gray),
        );

        if (isLoading) {
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: 14.rw, vertical: 13.rh),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.rr),
              border: Border.all(color: AppColors.gray),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 16.rw,
                  height: 16.rh,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: AppColors.primary),
                ),
                SizedBox(width: 10.rw),
                AppText('Chargement...',
                    fontSize: 13.rsp, color: AppColors.textMuted),
              ],
            ),
          );
        }

        return CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            key: _triggerKey,
            onTap: _isOpen ? _closeOverlay : _openOverlay,
            child: InputDecorator(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_search_outlined,
                    size: 16.rsp, color: AppColors.textMuted),
                suffixIcon: Icon(
                  _isOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 18.rsp,
                  color: AppColors.grayAsh,
                ),
                isDense: true,
                border: border,
                enabledBorder: border,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.rr),
                  borderSide:
                      BorderSide(color: AppColors.primary, width: 1.5.rw),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 13.rh, horizontal: 12.rw),
                filled: true,
                fillColor: AppColors.white,
              ),
              child: AppText(
                'Sélectionner un employé...',
                fontSize: 13.rsp,
                color: AppColors.textMuted,
              ),
            ),
          ),
        );
      },
    );
  }
}
