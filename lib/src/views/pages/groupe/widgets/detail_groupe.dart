import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/form_edit_groupe.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/form_import_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';

class DetailGroupe extends StatelessWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;

  const DetailGroupe({super.key, required this.groupe, required this.groupCubit});

  static void show(BuildContext context, {required GroupModel groupe, required GroupCubit groupCubit}) {
    showDetailDialog(
      context,
      width: 680.rw,
      child: DetailGroupe(groupe: groupe, groupCubit: groupCubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = groupe.product;

    return DetailContainer(children: [
      _Header(groupe: groupe),
      SizedBox(height: 20.rh),
      const DetailDivider(),
      SizedBox(height: 20.rh),
      _SectionInfos(groupe: groupe),
      if (product != null) ...[
        SizedBox(height: 20.rh),
        const DetailDivider(),
        SizedBox(height: 20.rh),
        DetailProductSection(product: product),
      ],
      SizedBox(height: 24.rh),
      const DetailDivider(),
      SizedBox(height: 20.rh),
      _Actions(groupe: groupe, groupCubit: groupCubit),
    ]);
  }
}

class _Header extends StatelessWidget {
  final GroupModel groupe;
  const _Header({required this.groupe});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailIconBox(icon: Icons.group_outlined),
        SizedBox(width: 14.rw),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(groupe.name ?? '---', fontSize: 18.rsp, fontWeight: FontWeight.w700, color: AppColors.primary),
              if (groupe.description?.isNotEmpty == true) ...[
                SizedBox(height: 4.rh),
                AppText(groupe.description!, fontSize: 13.rsp, color: AppColors.textMuted),
              ],
            ],
          ),
        ),
        _EmployeeBadge(count: groupe.employeesCount),
      ],
    );
  }
}

class _EmployeeBadge extends StatelessWidget {
  final int? count;
  const _EmployeeBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.rr),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 14.rsp, color: AppColors.primary),
          SizedBox(width: 5.rw),
          AppText(
            '${count ?? 0} employé${(count ?? 0) > 1 ? 's' : ''}',
            fontSize: 12.rsp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _SectionInfos extends StatelessWidget {
  final GroupModel groupe;
  const _SectionInfos({required this.groupe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Informations générales', icon: Icons.info_outline),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Nom du groupe', value: groupe.name ?? '---', icon: Icons.label_outline),
          right: DetailInfoItem(
            label: 'Description',
            value: groupe.description?.isNotEmpty == true ? groupe.description! : 'Aucune description',
            icon: Icons.notes_outlined,
          ),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(label: 'Date de création', value: AppDate.format(groupe.createdAt), icon: Icons.calendar_today_outlined),
          right: DetailInfoItem(label: 'Dernière modification', value: AppDate.format(groupe.updatedAt), icon: Icons.update_outlined),
        ),
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;
  const _Actions({required this.groupe, required this.groupCubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DetailActionBtn(
          label: 'Fermer',
          type: AppButtonType.outline,
          width: 130.rw,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
        /*SizedBox(width: 10.rw),
        DetailActionBtn(
          label: 'Supprimer',
          type: AppButtonType.outline,
          color: AppColors.error,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            ConfirmDeleteGroupe.show(context, groupe: groupe, groupCubit: groupCubit);
          },
        ),*/
        SizedBox(width: 10.rw),
        DetailActionBtn(
          label: 'Importer',
          icon: Icons.upload_file_outlined,
          type: AppButtonType.secondary,
          color: AppColors.primary,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            FormImportEmploye.show(context, groupe: groupe, groupCubit: groupCubit);
          },
        ),
        SizedBox(width: 10.rw),
        DetailActionBtn(
          label: 'Modifier',
          type: AppButtonType.secondary,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            FormEditGroupe.show(context, groupe: groupe, groupCubit: groupCubit);
          },
        ),
      ],
    );
  }
}
