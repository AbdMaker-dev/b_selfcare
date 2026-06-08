import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/confirm_disable_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/confirm_remove_number.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/form_assign_employe_numbers.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/form_edit_employe.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailEmploye extends StatelessWidget {
  final EmployeeModel employee;
  final MyFlotteCubit myFlotteCubit;

  const DetailEmploye({super.key, required this.employee, required this.myFlotteCubit});

  static void show(BuildContext context, {required EmployeeModel employee, required MyFlotteCubit myFlotteCubit}) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 650.rw,
            height: double.infinity,
            child: DetailEmploye(employee: employee, myFlotteCubit: myFlotteCubit),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${employee.firstName ?? ''} ${employee.lastName ?? ''}'.trim();
    final isActive = employee.status?.toUpperCase() == 'ACTIVE';

    return BlocListener<MyFlotteCubit, MyFlotteState>(
      bloc: myFlotteCubit,
      listener: (context, state) {
        state.maybeWhen(
          assignNumbersLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          removeNumbersLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          orElse: () {},
        );
      },
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.rr),
            bottomLeft: Radius.circular(12.rr),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(bottom: BorderSide(color: AppColors.gray)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.textHighlight(
                          'Détail employé',
                          fontSize: 24.rsp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayAsh,
                          highlight: 'employé',
                          fontFamily: FontFamily.syne,
                          highlightColor: AppColors.primary,
                          highlightFontSize: 24.rsp,
                        ),
                        SizedBox(height: 4.rh),
                        AppText(
                          '${fullName.isNotEmpty ? fullName : '---'} · ${employee.position ?? '---'}',
                          fontSize: 12.rsp,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.graySilver),
                      ),
                      child: AppText('X', fontSize: 13.rsp, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),

            // SCROLLABLE BODY
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.rw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeaderCard(employee: employee),
                    SizedBox(height: 16.rh),
                    _SectionInfos(employee: employee),
                    if (employee.group != null) ...[
                      SizedBox(height: 16.rh),
                      const DetailDivider(),
                      SizedBox(height: 16.rh),
                      _SectionGroupe(employee: employee),
                    ],
                    if (employee.group?.product != null) ...[
                      SizedBox(height: 16.rh),
                      const DetailDivider(),
                      SizedBox(height: 16.rh),
                      DetailProductSection(product: employee.group!.product!),
                    ],
                    SizedBox(height: 16.rh),
                    const DetailDivider(),
                    SizedBox(height: 16.rh),
                    _SectionNumeros(
                      fleetNumbers: employee.fleetNumbers ?? [],
                      employee: employee,
                      myFlotteCubit: myFlotteCubit,
                    ),
                    SizedBox(height: 16.rh),
                  ],
                ),
              ),
            ),

            // FOOTER
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(top: BorderSide(color: AppColors.gray)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Fermer',
                      type: AppButtonType.outline,
                      fontSize: 13.rsp,
                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                    ),
                  ),
                  if (isActive) ...[
                    SizedBox(width: 8.rw),
                    Expanded(
                      child: AppButton(
                        text: 'Désactiver',
                        type: AppButtonType.primary,
                        color: AppColors.error,
                        fontSize: 13.rsp,
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          ConfirmDisableEmploye.show(context, employee: employee, myFlotteCubit: myFlotteCubit);
                        },
                      ),
                    ),
                  ],
                  SizedBox(width: 8.rw),
                  Expanded(
                    child: AppButton(
                      text: 'Modifier',
                      type: AppButtonType.secondary,
                      fontSize: 13.rsp,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        FormEditEmploye.show(context, employee: employee, myFlotteCubit: myFlotteCubit);
                      },
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

// ─── Header card ─────────────────────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  final EmployeeModel employee;
  const _HeaderCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    final fullName = '${employee.firstName ?? ''} ${employee.lastName ?? ''}'.trim();
    final initials = _initials(employee.firstName, employee.lastName);
    final isActive = employee.status?.toUpperCase() == 'ACTIVE';

    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Avatar(initials: initials, isActive: isActive),
          SizedBox(width: 14.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(fullName.isNotEmpty ? fullName : '---', fontSize: 16.rsp, fontWeight: FontWeight.w700, color: AppColors.primary),
                if (employee.email != null) ...[
                  SizedBox(height: 4.rh),
                  Row(children: [
                    Icon(Icons.email_outlined, size: 13.rsp, color: AppColors.textMuted),
                    SizedBox(width: 4.rw),
                    AppText(employee.email!, fontSize: 12.rsp, color: AppColors.textMuted),
                  ]),
                ],
                if (employee.position != null) ...[
                  SizedBox(height: 3.rh),
                  Row(children: [
                    Icon(Icons.work_outline, size: 13.rsp, color: AppColors.textMuted),
                    SizedBox(width: 4.rw),
                    AppText(employee.position!, fontSize: 12.rsp, color: AppColors.textMuted),
                  ]),
                ],
              ],
            ),
          ),
          DetailStatusBadge.fromStatus(employee.status),
        ],
      ),
    );
  }

  String _initials(String? first, String? last) {
    final f = first?.isNotEmpty == true ? first![0].toUpperCase() : '';
    final l = last?.isNotEmpty == true ? last![0].toUpperCase() : '';
    return '$f$l'.isNotEmpty ? '$f$l' : '?';
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  final bool isActive;
  const _Avatar({required this.initials, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 52.rw,
          height: 52.rh,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.rr),
          ),
          alignment: Alignment.center,
          child: AppText(initials, fontSize: 18.rsp, fontWeight: FontWeight.w700, color: AppColors.primary),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 12.rw,
            height: 12.rh,
            decoration: BoxDecoration(
              color: isActive ? AppColors.success : AppColors.grayAsh,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Section infos ────────────────────────────────────────────────────────────

class _SectionInfos extends StatelessWidget {
  final EmployeeModel employee;
  const _SectionInfos({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Informations personnelles', icon: Icons.person_outline),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Prénom', value: employee.firstName ?? '---', icon: Icons.badge_outlined),
          right: DetailInfoItem(label: 'Nom', value: employee.lastName ?? '---', icon: Icons.badge_outlined),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Email', value: employee.email ?? '---', icon: Icons.email_outlined),
          right: DetailInfoItem(label: 'Téléphone', value: employee.phone ?? '---', icon: Icons.phone_outlined),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Poste', value: employee.position ?? '---', icon: Icons.work_outline),
          right: DetailInfoItem(
            label: 'Numéros assignés',
            value: '${employee.fleetNumbersCount ?? 0} numéro${(employee.fleetNumbersCount ?? 0) > 1 ? 's' : ''}',
            icon: Icons.sim_card_outlined,
          ),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Date d\'ajout', value: AppDate.format(employee.createdAt), icon: Icons.calendar_today_outlined),
          right: DetailInfoItem(label: 'Dernière modification', value: AppDate.format(employee.updatedAt), icon: Icons.update_outlined),
        ),
      ],
    );
  }
}

// ─── Section groupe ───────────────────────────────────────────────────────────

class _SectionGroupe extends StatelessWidget {
  final EmployeeModel employee;
  const _SectionGroupe({required this.employee});

  @override
  Widget build(BuildContext context) {
    final group = employee.group!;
    final schedule = group.campaign;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Groupe', icon: Icons.group_outlined),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Nom du groupe', value: group.name ?? '---', icon: Icons.label_outline),
          right: DetailInfoItem(label: 'Produit', value: group.product?.name ?? '---', icon: Icons.inventory_2_outlined),
        ),
        if (schedule != null) ...[
          SizedBox(height: 12.rh),
          DetailInfoRow(
            left: DetailInfoItem(label: 'Fréquence', value: schedule.frequency ?? '---', icon: Icons.repeat_outlined),
            right: DetailInfoItem(label: 'Date de début', value: AppDate.format(schedule.startDate), icon: Icons.play_circle_outline),
          ),
        ],
        if (group.description?.isNotEmpty == true) ...[
          SizedBox(height: 12.rh),
          DetailInfoItem(label: 'Description du groupe', value: group.description!, icon: Icons.notes_outlined),
        ],
      ],
    );
  }
}

// ─── Section numéros ─────────────────────────────────────────────────────────

class _SectionNumeros extends StatelessWidget {
  final List<FleetNumberModel> fleetNumbers;
  final EmployeeModel employee;
  final MyFlotteCubit myFlotteCubit;
  const _SectionNumeros({required this.fleetNumbers, required this.employee, required this.myFlotteCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DetailSectionTitle(label: 'Numéros fleet (${fleetNumbers.length})', icon: Icons.sim_card_outlined),
            ),
            GestureDetector(
              onTap: () => FormAssignEmployeNumbers.show(context, employee: employee, myFlotteCubit: myFlotteCubit),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 4.rh),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6.rr),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 14.rsp, color: AppColors.primary),
                    SizedBox(width: 4.rw),
                    AppText('Assigner', fontSize: 12.rsp, color: AppColors.primary, fontWeight: FontWeight.w600),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.rh),
        if (fleetNumbers.isEmpty)
          AppText('Aucun numéro assigné', fontSize: 13.rsp, color: AppColors.textMuted)
        else
          Wrap(
            spacing: 10.rw,
            runSpacing: 8.rh,
            children: fleetNumbers
                .map((f) => _NumeroBadge(fleet: f, employee: employee, myFlotteCubit: myFlotteCubit))
                .toList(),
          ),
      ],
    );
  }
}

class _NumeroBadge extends StatelessWidget {
  final FleetNumberModel fleet;
  final EmployeeModel employee;
  final MyFlotteCubit myFlotteCubit;
  const _NumeroBadge({required this.fleet, required this.employee, required this.myFlotteCubit});

  @override
  Widget build(BuildContext context) {
    final isActive = fleet.status?.toUpperCase() == 'ACTIVE';
    final color = isActive ? AppColors.success : AppColors.grayAsh;

    return Container(
      padding: EdgeInsets.only(left: 12.rw, top: 6.rh, bottom: 6.rh, right: 6.rw),
      decoration: BoxDecoration(
        color: AppColors.grayWh,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6.rw, height: 6.rh, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          SizedBox(width: 7.rw),
          AppText(fleet.msisdn ?? '---', fontSize: 13.rsp, fontWeight: FontWeight.w600, color: AppColors.textHeading),
          SizedBox(width: 6.rw),
          GestureDetector(
            onTap: () => ConfirmRemoveNumber.show(context, employee: employee, fleetNumber: fleet, myFlotteCubit: myFlotteCubit),
            child: Icon(Icons.close, size: 15.rsp, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
