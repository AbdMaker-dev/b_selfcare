import 'package:b_selfcare/src/data/models/flotte_number/flotte_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/flotte_number/flotte_number_cubit.dart';
import 'package:b_selfcare/src/views/pages/numeros/widgets/confirm_suspend_numero.dart';
import 'package:b_selfcare/src/views/pages/numeros/widgets/form_assign_numero.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailNumero extends StatelessWidget {
  final FlotteNumberModel numero;
  final FlotteNumberCubit flotteNumberCubit;

  const DetailNumero({super.key, required this.numero, required this.flotteNumberCubit});

  static void show(
    BuildContext context, {
    required FlotteNumberModel numero,
    required FlotteNumberCubit flotteNumberCubit,
  }) {
    showDetailDialog(
      context,
      width: 620.rw,
      child: DetailNumero(numero: numero, flotteNumberCubit: flotteNumberCubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FlotteNumberCubit, FlotteNumberState>(
      bloc: flotteNumberCubit,
      listener: (context, state) {
        state.maybeWhen(
          assignNumberLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          suspendNumberLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          reactivateNumberLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          orElse: () {},
        );
      },
      child: DetailContainer(children: [
        _Header(numero: numero),
        SizedBox(height: 20.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        _SectionNumero(numero: numero),
        if (numero.employee != null) ...[
          SizedBox(height: 20.rh),
          const DetailDivider(),
          SizedBox(height: 20.rh),
          _SectionEmploye(numero: numero),
        ],
        SizedBox(height: 24.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        _Actions(numero: numero, flotteNumberCubit: flotteNumberCubit),
      ]),
    );
  }
}

class _Header extends StatelessWidget {
  final FlotteNumberModel numero;
  const _Header({required this.numero});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailIconBox(icon: Icons.sim_card_outlined),
        SizedBox(width: 14.rw),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                numero.msisdn ?? '---',
                fontSize: 20.rsp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              if (numero.iccid != null) ...[
                SizedBox(height: 4.rh),
                Row(children: [
                  Icon(Icons.credit_card_outlined, size: 13.rsp, color: AppColors.textMuted),
                  SizedBox(width: 4.rw),
                  AppText('ICCID : ${numero.iccid!}', fontSize: 12.rsp, color: AppColors.textMuted),
                ]),
              ],
            ],
          ),
        ),
        DetailStatusBadge.fromStatus(numero.status == 'UNASSIGNED' ? null : numero.status),
        if (numero.status?.toUpperCase() == 'UNASSIGNED') ...[
          _UnassignedBadge(),
        ],
      ],
    );
  }
}

class _UnassignedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
      decoration: BoxDecoration(
        color: AppColors.grayAsh.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.rr),
        border: Border.all(color: AppColors.grayAsh.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.rw,
            height: 6.rh,
            decoration: BoxDecoration(color: AppColors.grayAsh, shape: BoxShape.circle),
          ),
          SizedBox(width: 5.rw),
          AppText('NON ASSIGNÉ', fontSize: 11.rsp, fontWeight: FontWeight.w700, color: AppColors.grayAsh),
        ],
      ),
    );
  }
}

class _SectionNumero extends StatelessWidget {
  final FlotteNumberModel numero;
  const _SectionNumero({required this.numero});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Informations du numéro', icon: Icons.sim_card_outlined),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'MSISDN', value: numero.msisdn ?? '---', icon: Icons.phone_outlined),
          right: DetailInfoItem(label: 'ICCID', value: numero.iccid ?? '---', icon: Icons.credit_card_outlined),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Date de création', value: AppDate.format(numero.createdAt), icon: Icons.calendar_today_outlined),
          right: DetailInfoItem(label: 'Date d\'assignation', value: AppDate.formatShort(numero.assignmentDate), icon: Icons.event_available_outlined),
        ),
      ],
    );
  }
}

class _SectionEmploye extends StatelessWidget {
  final FlotteNumberModel numero;
  const _SectionEmploye({required this.numero});

  @override
  Widget build(BuildContext context) {
    final emp = numero.employee!;
    final fullName = '${emp.firstName ?? ''} ${emp.lastName ?? ''}'.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Employé assigné', icon: Icons.person_outline),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left: DetailInfoItem(
            label: 'Nom complet',
            value: fullName.isNotEmpty ? fullName : '---',
            icon: Icons.badge_outlined,
          ),
          right: DetailInfoItem(
            label: 'Statut employé',
            value: emp.status ?? '---',
            icon: Icons.info_outline,
          ),
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  final FlotteNumberModel numero;
  final FlotteNumberCubit flotteNumberCubit;
  const _Actions({required this.numero, required this.flotteNumberCubit});

  void _assign(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    FormAssignNumero.show(context, numero: numero, flotteNumberCubit: flotteNumberCubit);
  }

  void _suspend(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    ConfirmSuspendNumero.show(context, numero: numero, flotteNumberCubit: flotteNumberCubit);
  }

  void _reactivate(BuildContext context) {
    if (numero.id == null) return;
    Navigator.of(context, rootNavigator: true).pop();
    flotteNumberCubit.reactivateNumber(id: numero.id!, data: {"reason":""});
  }

  @override
  Widget build(BuildContext context) {
    final status = numero.status?.toUpperCase();

    return BlocBuilder<FlotteNumberCubit, FlotteNumberState>(
      bloc: flotteNumberCubit,
      builder: (context, state) {
        final isLoading = state is AssignNumberLoading || state is SuspendNumberLoading || state is ReactivateNumberLoading;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DetailActionBtn(
              label: 'Fermer',
              type: AppButtonType.outline,
              width: 120,
              onPressed: isLoading ? null : () => Navigator.of(context, rootNavigator: true).pop(),
            ),
            if (status == 'UNASSIGNED') ...[
              SizedBox(width: 10.rw),
              DetailActionBtn(
                label: 'Assigner',
                icon: Icons.person_add_outlined,
                onPressed: isLoading ? null : () => _assign(context),
              ),
            ],
            if (status == 'ACTIVE') ...[
              SizedBox(width: 10.rw),
              DetailActionBtn(
                label: 'Suspendre',
                icon: Icons.pause_circle_outline,
                color: AppColors.warning,
                onPressed: isLoading ? null : () => _suspend(context),
              ),
            ],
            if (status == 'SUSPENDED' || status == 'INACTIVE') ...[
              SizedBox(width: 10.rw),
              DetailActionBtn(
                label: 'Réactiver',
                icon: Icons.replay_rounded,
                color: AppColors.success,
                onPressed: isLoading ? null : () => _reactivate(context),
              ),
            ],
          ],
        );
      },
    );
  }
}
