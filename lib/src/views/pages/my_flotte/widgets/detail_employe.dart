import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/confirm_disable_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/form_edit_employe.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';

class DetailEmploye extends StatelessWidget {
  final EmployeeModel employee;
  final MyFlotteCubit myFlotteCubit;

  const DetailEmploye({super.key, required this.employee, required this.myFlotteCubit});

  static void show(BuildContext context, {required EmployeeModel employee, required MyFlotteCubit myFlotteCubit}) {
    showDetailDialog(
      context,
      width: 680.rw,
      child: DetailEmploye(employee: employee, myFlotteCubit: myFlotteCubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DetailContainer(children: [
      _Header(employee: employee),
      SizedBox(height: 20.rh),
      const DetailDivider(),
      SizedBox(height: 20.rh),
      _SectionInfos(employee: employee),
      if (employee.group != null) ...[
        SizedBox(height: 20.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        _SectionGroupe(employee: employee),
      ],
      if (employee.group?.product != null) ...[
        SizedBox(height: 20.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        DetailProductSection(product: employee.group!.product!),
      ],
      if (employee.fleetNumbers?.isNotEmpty == true) ...[
        SizedBox(height: 20.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        _SectionNumeros(fleetNumbers: employee.fleetNumbers!),
      ],
      SizedBox(height: 24.rh),
      const DetailDivider(),
      SizedBox(height: 20.rh),
      _Actions(employee: employee, myFlotteCubit: myFlotteCubit),
    ]);
  }
}

class _Header extends StatelessWidget {
  final EmployeeModel employee;
  const _Header({required this.employee});

  @override
  Widget build(BuildContext context) {
    final fullName = '${employee.firstName ?? ''} ${employee.lastName ?? ''}'.trim();
    final initials = _initials(employee.firstName, employee.lastName);
    final isActive = employee.status?.toUpperCase() == 'ACTIVE';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Avatar(initials: initials, isActive: isActive),
        SizedBox(width: 14.rw),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(fullName.isNotEmpty ? fullName : '---', fontSize: 18.rsp, fontWeight: FontWeight.w700, color: AppColors.primary),
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

class _SectionNumeros extends StatelessWidget {
  final List<FleetNumberModel> fleetNumbers;
  const _SectionNumeros({required this.fleetNumbers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Numéros fleet (${fleetNumbers.length})', icon: Icons.sim_card_outlined),
        SizedBox(height: 10.rh),
        Wrap(
          spacing: 10.rw,
          runSpacing: 8.rh,
          children: fleetNumbers.map((f) => _NumeroBadge(fleet: f)).toList(),
        ),
      ],
    );
  }
}

class _NumeroBadge extends StatelessWidget {
  final FleetNumberModel fleet;
  const _NumeroBadge({required this.fleet});

  @override
  Widget build(BuildContext context) {
    final isActive = fleet.status?.toUpperCase() == 'ACTIVE';
    final color = isActive ? AppColors.success : AppColors.grayAsh;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 8.rh),
      decoration: BoxDecoration(
        color: AppColors.grayWh,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.rw, height: 6.rh,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 7.rw),
          AppText(fleet.msisdn ?? '---', fontSize: 13.rsp, fontWeight: FontWeight.w600, color: AppColors.textHeading),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  final EmployeeModel employee;
  final MyFlotteCubit myFlotteCubit;
  const _Actions({required this.employee, required this.myFlotteCubit});

  @override
  Widget build(BuildContext context) {
    final isActive = employee.status?.toUpperCase() == 'ACTIVE';

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DetailActionBtn(
          label: 'Fermer', type: AppButtonType.outline, width: 120.rw,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
        if (isActive) ...[
          SizedBox(width: 10.rw),
          DetailActionBtn(
            label: 'Désactiver', type: AppButtonType.primary, color: AppColors.error,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              ConfirmDisableEmploye.show(context, employee: employee, myFlotteCubit: myFlotteCubit);
            },
          ),
        ],
        SizedBox(width: 10.rw),
        DetailActionBtn(
          label: 'Modifier', type: AppButtonType.secondary,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            FormEditEmploye.show(context, employee: employee, myFlotteCubit: myFlotteCubit);
          },
        ),
      ],
    );
  }
}
