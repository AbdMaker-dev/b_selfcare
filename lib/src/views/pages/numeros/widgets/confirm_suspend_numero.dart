import 'package:b_selfcare/src/data/models/flotte_number/flotte_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/flotte_number/flotte_number_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmSuspendNumero extends StatefulWidget {
  final FlotteNumberModel numero;
  final FlotteNumberCubit flotteNumberCubit;

  const ConfirmSuspendNumero({
    super.key,
    required this.numero,
    required this.flotteNumberCubit,
  });

  static void show(
    BuildContext context, {
    required FlotteNumberModel numero,
    required FlotteNumberCubit flotteNumberCubit,
  }) {
    showDetailDialog(
      context,
      width: 460.rw,
      child: ConfirmSuspendNumero(numero: numero, flotteNumberCubit: flotteNumberCubit),
    );
  }

  @override
  State<ConfirmSuspendNumero> createState() => _ConfirmSuspendNumeroState();
}

class _ConfirmSuspendNumeroState extends State<ConfirmSuspendNumero> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.numero.id == null) return;
    final reason = _reasonController.text.trim();
    widget.flotteNumberCubit.suspendNumber(
      id: widget.numero.id!,
      data: reason.isNotEmpty ? {'reason': reason} : {"reason":""},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FlotteNumberCubit, FlotteNumberState>(
      bloc: widget.flotteNumberCubit,
      listener: (context, state) {
        state.maybeWhen(
          suspendNumberLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          orElse: () {},
        );
      },
      child: BlocBuilder<FlotteNumberCubit, FlotteNumberState>(
        bloc: widget.flotteNumberCubit,
        builder: (context, state) {
          final isLoading = state is SuspendNumberLoading;

          return DetailContainer(children: [
            // Header
            Row(children: [
              Container(
                padding: EdgeInsets.all(10.rw),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.rr),
                ),
                child: Icon(Icons.pause_circle_outline, color: AppColors.warning, size: 24.rsp),
              ),
              SizedBox(width: 14.rw),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText('Suspendre le numéro', fontSize: 16.rsp, fontWeight: FontWeight.w700, color: AppColors.textHeading),
                    SizedBox(height: 3.rh),
                    AppText(widget.numero.msisdn ?? '---', fontSize: 13.rsp, color: AppColors.textMuted),
                  ],
                ),
              ),
            ]),
            SizedBox(height: 20.rh),
            const DetailDivider(),
            SizedBox(height: 20.rh),

            // Raison (optionnelle)
            AppText('Raison (optionnelle)', fontSize: 12.rsp, fontWeight: FontWeight.w600, color: AppColors.textHeading),
            SizedBox(height: 8.rh),
            TextField(
              controller: _reasonController,
              enabled: !isLoading,
              maxLines: 3,
              minLines: 2,
              decoration: InputDecoration(
                hintText: 'Ex : Perte, vol, départ employé...',
                contentPadding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.rr)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.rr),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.rr),
                  borderSide: const BorderSide(color: Color(0xFF1565C0)),
                ),
              ),
            ),
            SizedBox(height: 24.rh),
            const DetailDivider(),
            SizedBox(height: 16.rh),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DetailActionBtn(
                  label: 'Annuler',
                  type: AppButtonType.outline,
                  width: 120,
                  onPressed: isLoading ? null : () => Navigator.of(context, rootNavigator: true).pop(),
                ),
                SizedBox(width: 10.rw),
                DetailActionBtn(
                  label: 'Suspendre',
                  icon: Icons.pause_circle_outline,
                  color: AppColors.warning,
                  onPressed: isLoading ? null : _submit,
                ),
              ],
            ),
          ]);
        },
      ),
    );
  }
}
