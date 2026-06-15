import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/data/models/resource_custom/free_unit_model.dart';
import 'package:b_selfcare/src/data/models/resource_custom/resource_custom_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecoveryResourcePanel extends StatelessWidget {
  final List<FleetNumberModel> numbers;
  final int selectedIndex;
  final Map<int, ResourceCustomModel> resourcesCache;
  final int? loadingNumberId;
  final Map<String, TextEditingController>? unitControllers;
  final TextEditingController? mainCreditController;
  final VoidCallback? onFillAll;
  final bool isCustomAmount;

  const RecoveryResourcePanel({
    super.key,
    required this.numbers,
    required this.selectedIndex,
    required this.resourcesCache,
    required this.loadingNumberId,
    this.unitControllers,
    this.mainCreditController,
    this.onFillAll,
    this.isCustomAmount = false,
  });

  static bool _isDataUnit(FreeUnitModel u) {
    final unit = (u.unit ?? '').toLowerCase();
    return unit.contains('mb') || unit.contains('gb') || unit.contains('byte');
  }

  static int toDisplayAmount(FreeUnitModel u) {
    final raw = u.totalAmount ?? 0;
    final unit = (u.unit ?? '').toLowerCase();
    if (unit.startsWith('min')) return raw ~/ 60;
    if (_isDataUnit(u)) return raw ~/ (1024 * 1024 * 1024);
    return raw;
  }

  static String displayUnit(FreeUnitModel u) {
    final unit = (u.unit ?? '').toLowerCase();
    if (unit.startsWith('min')) return 'min';
    if (_isDataUnit(u)) return 'Go';
    return u.measureUnitLabel ?? u.unit ?? '';
  }

  static String unitLabel(FreeUnitModel u) {
    if (u.walletDescription != null && u.walletDescription!.isNotEmpty) {
      return u.walletDescription!;
    }
    if (u.measureUnitLabel != null && u.measureUnitLabel!.isNotEmpty) {
      return u.measureUnitLabel!;
    }
    switch (u.measureUnit) {
      case '1101':
        return 'SMS';
      case '1106':
        return 'DATA';
      case '1003':
        return 'VOIX';
      default:
        return u.measureUnit ?? '---';
    }
  }

  static IconData unitIcon(FreeUnitModel u) {
    switch (u.measureUnit) {
      case '1101':
        return Icons.sms_outlined;
      case '1106':
        return Icons.wifi_outlined;
      case '1003':
        return Icons.phone_outlined;
      default:
        return Icons.account_balance_wallet_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (numbers.isEmpty) return const SizedBox.shrink();

    final selectedNumber = numbers[selectedIndex];
    final id = selectedNumber.id;
    final isLoading = id != null && loadingNumberId == id;
    final resource = id != null ? resourcesCache[id] : null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayWh,
        borderRadius: BorderRadius.circular(12.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
            child: Row(
              children: [
                AppText(
                  'GETSUBSCRIBERBALANCE CBS',
                  fontSize: 10.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                  fontFamily: FontFamily.syne,
                ),
                const Spacer(),
                if (resource != null && onFillAll != null)
                  GestureDetector(
                    onTap: onFillAll,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.rw, vertical: 4.rh),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20.rr),
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.select_all_rounded,
                              size: 11.rsp, color: AppColors.primary),
                          SizedBox(width: 4.rw),
                          AppText(
                            'Récupérer tout',
                            fontSize: 10.rsp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Divider(height: 1, color: AppColors.gray),

          if (isLoading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.rh),
              child: Center(
                child: CircularProgressIndicator(
                    color: AppColors.primary, strokeWidth: 2),
              ),
            )
          else if (resource == null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.rh),
              child: Center(
                child: AppText('Aucune ressource disponible',
                    fontSize: 13.rsp, color: AppColors.textMuted),
              ),
            )
          else ...[
            Padding(
              padding: EdgeInsets.all(10.rw),
              child: _buildGrid(resource),
            ),

            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.gray)),
              ),
              child: Row(
                children: [
                  AppText(
                    'Estimation récupération',
                    fontSize: 12.rsp,
                    color: AppColors.primary,
                  ),
                  const Spacer(),
                  AppText(
                    isCustomAmount
                        ? '---'
                        : (resource.mainCreditFcfa != null
                            ? '≈ ${_formatFcfa(resource.mainCreditFcfa!)} FCFA'
                            : '---'),
                    fontSize: 12.rsp,
                    fontWeight: FontWeight.w700,
                    color: isCustomAmount
                        ? AppColors.textMuted
                        : AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGrid(ResourceCustomModel resource) {
    final cards = <Widget>[
      ...(resource.freeUnits ?? []).map((u) {
        final key = u.freeUnitType ?? u.measureUnit ?? '';
        return _ResourceCard(
          label: unitLabel(u),
          icon: unitIcon(u),
          maxAmount: toDisplayAmount(u),
          unit: displayUnit(u),
          controller: unitControllers?[key],
        );
      }),
      if (resource.mainCreditFcfa != null)
        _ResourceCard(
          label: 'CRÉDIT',
          icon: Icons.account_balance_wallet_outlined,
          maxAmount: resource.mainCreditFcfa ?? 0,
          unit: 'FCFA',
          controller: mainCreditController,
          formatValue: _formatFcfa,
        ),
    ];

    final rows = <Widget>[];
    for (var i = 0; i < cards.length; i += 2) {
      final isLastOdd = i + 1 >= cards.length;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: isLastOdd ? 0 : 4.rw),
                child: cards[i],
              ),
            ),
            if (!isLastOdd)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 4.rw),
                  child: cards[i + 1],
                ),
              )
            else
              const Expanded(child: SizedBox.shrink()),
          ],
        ),
      );
      if (i + 2 < cards.length) rows.add(SizedBox(height: 8.rh));
    }

    return Column(children: rows);
  }

  static String _formatFcfa(int value) {
    final s = value.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(' ');
      buf.write(s[i]);
    }
    return buf.toString();
  }
}

class _ResourceCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final int maxAmount;
  final String unit;
  final TextEditingController? controller;
  final String Function(int)? formatValue;

  const _ResourceCard({
    required this.label,
    required this.icon,
    required this.maxAmount,
    required this.unit,
    this.controller,
    this.formatValue,
  });

  @override
  State<_ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<_ResourceCard> {
  bool _isOverMax = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onChanged);
    _syncFromController();
  }

  @override
  void didUpdateWidget(_ResourceCard old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller?.removeListener(_onChanged);
      widget.controller?.addListener(_onChanged);
      _syncFromController();
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() => setState(_syncFromController);

  void _syncFromController() {
    final v = int.tryParse(widget.controller?.text ?? '') ?? 0;
    _isOverMax = widget.maxAmount > 0 && v > widget.maxAmount;
  }

  void _setPercent(double pct) {
    final amount = (widget.maxAmount * pct).round();
    widget.controller?.text = amount.toString();
  }

  void _fillMax() {
    widget.controller?.text = widget.maxAmount.toString();
  }

  String get _displayMax {
    if (widget.formatValue != null) return widget.formatValue!(widget.maxAmount);
    return widget.maxAmount.toString();
  }

  double get _currentPercent {
    if (widget.maxAmount <= 0) return 0;
    final v = int.tryParse(widget.controller?.text ?? '') ?? 0;
    return (v / widget.maxAmount).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final hasController = widget.controller != null;
    final valueColor = _isOverMax ? AppColors.orangeFire : AppColors.primary;

    return Container(
      padding: EdgeInsets.fromLTRB(12.rw, 12.rh, 12.rw, 8.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.rr),
        border: Border.all(
          color: _isOverMax ? AppColors.orangeSalmon : AppColors.gray,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête : icône + label + bouton Max
          Row(
            children: [
              Icon(widget.icon, size: 12.rsp, color: AppColors.textMuted),
              SizedBox(width: 5.rw),
              Expanded(
                child: AppText(
                  widget.label,
                  fontSize: 10.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                  fontFamily: FontFamily.syne,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (hasController)
                GestureDetector(
                  onTap: _fillMax,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.rw, vertical: 3.rh),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(20.rr),
                    ),
                    child: AppText(
                      'Max',
                      fontSize: 9.rsp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 14.rh),

          // Grand nombre éditable, centré
          Center(
            child: hasController
                ? TextField(
                    controller: widget.controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34.rsp,
                      fontWeight: FontWeight.w800,
                      color: valueColor,
                      letterSpacing: -0.5,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(bottom: 2.rh),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: valueColor.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                      ),
                    ),
                  )
                : AppText(
                    _displayMax,
                    fontSize: 34.rsp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
          ),

          // Unité + max disponible
          Center(
            child: AppText(
              '${widget.unit}  ·  / $_displayMax disponible',
              fontSize: 10.rsp,
              color: _isOverMax ? AppColors.orangeFire : AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 12.rh),

          // Chips de pourcentage
          if (hasController && widget.maxAmount > 0)
            _PercentChips(
              currentPercent: _currentPercent,
              onSelect: _setPercent,
              isOverMax: _isOverMax,
            ),

          if (_isOverMax)
            Padding(
              padding: EdgeInsets.only(top: 4.rh),
              child: AppText(
                'Dépasse le maximum disponible',
                fontSize: 9.rsp,
                color: AppColors.orangeFire,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

class _PercentChips extends StatelessWidget {
  final double currentPercent;
  final void Function(double) onSelect;
  final bool isOverMax;

  const _PercentChips({
    required this.currentPercent,
    required this.onSelect,
    required this.isOverMax,
  });

  static const _steps = [0.0, 0.25, 0.5, 0.75, 1.0];
  static const _labels = ['0', '25%', '50%', '75%', '100%'];

  bool _isActive(double step) =>
      !isOverMax && (currentPercent - step).abs() < 0.01;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_steps.length, (i) {
        final active = _isActive(_steps[i]);
        return Expanded(
          child: GestureDetector(
            onTap: () => onSelect(_steps[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.only(right: i < _steps.length - 1 ? 4.rw : 0),
              padding: EdgeInsets.symmetric(vertical: 6.rh),
              decoration: BoxDecoration(
                color: active
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(20.rr),
                border: Border.all(
                  color: active
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
              child: Center(
                child: AppText(
                  _labels[i],
                  fontSize: 10.rsp,
                  fontWeight: FontWeight.w700,
                  color: active ? AppColors.white : AppColors.primary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
