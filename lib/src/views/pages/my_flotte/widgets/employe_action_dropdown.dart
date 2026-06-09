import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/form_import_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/form_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/pick_groupe_dialog.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

enum _EmployeAction { create, importEmployes }

class EmployeActionDropdown extends StatelessWidget {
  final MyFlotteCubit myFlotteCubit;
  final VoidCallback onCreated;

  const EmployeActionDropdown({super.key, required this.myFlotteCubit, required this.onCreated});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_EmployeAction>(
      onSelected: (action) => _handle(context, action),
      offset: Offset(0, 55.rh),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.rr),
        side: BorderSide(color: AppColors.gray),
      ),
      elevation: 8,
      color: Colors.white,
      itemBuilder: (_) => [
        _item(
          _EmployeAction.create,
          Icons.person_add_outlined,
          'Créer un employé',
          'Ajouter un nouvel employé',
          AppColors.greenMint,
          AppColors.green,
        ),
        _item(
          _EmployeAction.importEmployes,
          Icons.upload_file_outlined,
          'Importer des employés',
          'Depuis un fichier Excel ou CSV',
          AppColors.amberCream,
          AppColors.amberBrown,
        ),
      ],
      child: Container(
        width: 160.rw,
        height: 50.rh,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(8.rr),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, size: 18.rsp, color: AppColors.primary),
            SizedBox(width: 8.rw),
            AppText('Employé', fontSize: 15.rsp, fontWeight: FontWeight.w600, color: AppColors.primary),
            SizedBox(width: 6.rw),
            Icon(Icons.keyboard_arrow_down_rounded, size: 18.rsp, color: AppColors.primary),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<_EmployeAction> _item(
    _EmployeAction value,
    IconData icon,
    String label,
    String description,
    Color bgColor,
    Color iconColor,
  ) {
    return PopupMenuItem(
      value: value,
      height: 64.rh,
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 8.rh),
      child: Row(
        children: [
          Container(
            width: 36.rw,
            height: 36.rh,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8.rr),
            ),
            child: Icon(icon, color: iconColor, size: 18.rsp),
          ),
          SizedBox(width: 12.rw),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(label, fontSize: 13.rsp, fontWeight: FontWeight.w600, color: AppColors.textHeading),
              AppText(description, fontSize: 11.rsp, color: AppColors.textMuted),
            ],
          ),
        ],
      ),
    );
  }

  void _handle(BuildContext context, _EmployeAction action) {
    switch (action) {
      case _EmployeAction.create:
        FormEmploye.show(context, myFlotteCubit: myFlotteCubit, onCreated: onCreated);
      case _EmployeAction.importEmployes:
        PickGroupeDialog.show(context, onSelected: (groupe, groupCubit) {
          FormImportEmploye.show(context, groupe: groupe, groupCubit: groupCubit);
        });
    }
  }
}
