import 'dart:async';
import 'dart:typed_data';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/group/data_import_response_model.dart';
import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_html/html.dart' as html;

class FormImportEmploye extends StatefulWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;

  const FormImportEmploye({super.key, required this.groupe, required this.groupCubit});

  static void show(BuildContext context, {required GroupModel groupe, required GroupCubit groupCubit}) {
    showDetailDialog(
      context,
      width: 650.rw,
      child: FormImportEmploye(groupe: groupe, groupCubit: groupCubit),
    );
  }

  @override
  State<FormImportEmploye> createState() => _FormImportEmployeState();
}

class _FormImportEmployeState extends State<FormImportEmploye> {
  Uint8List? _file;
  String? _fileName;

  void _pickFile() {
    final input = html.FileUploadInputElement()
      ..accept = '.xlsx,.xls,.csv';
    input.click();
    input.onChange.listen((_) {
      final file = input.files?.first;
      if (file == null) return;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((_) {
        final result = reader.result;
        if (result is Uint8List && mounted) {
          setState(() {
            _file = result;
            _fileName = file.name;
          });
        }
      });
    });
  }

  void _submit() {
    if (_file == null || _fileName == null) return;
    final id = widget.groupe.id;
    if (id == null) return;
    widget.groupCubit.importEmployeInGroupe(
      id: id,
      file: _file!,
      fileName: _fileName!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupCubit, GroupState>(
      bloc: widget.groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          importEmployeLoaded: (data) {
            Navigator.of(context, rootNavigator: true).pop();
            _showResult(context, data);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state is ImportEmployeLoading;

        return DetailContainer(children: [
          // Header
          Row(children: [
            DetailIconBox(icon: Icons.upload_file_outlined),
            SizedBox(width: 14.rw),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('Importer des employés', fontSize: 17.rsp, fontWeight: FontWeight.w700, color: AppColors.primary),
                  SizedBox(height: 3.rh),
                  AppText(
                    'Groupe : ${widget.groupe.name ?? '---'}',
                    fontSize: 12.rsp,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ]),
          SizedBox(height: 20.rh),
          const DetailDivider(),
          SizedBox(height: 20.rh),

          // Zone de sélection fichier
          GestureDetector(
            onTap: isLoading ? null : _pickFile,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 28.rh, horizontal: 20.rw),
              decoration: BoxDecoration(
                color: _file != null
                    ? AppColors.success.withValues(alpha: 0.05)
                    : AppColors.grayWh,
                borderRadius: BorderRadius.circular(10.rr),
                border: Border.all(
                  color: _file != null ? AppColors.success : AppColors.gray,
                  style: BorderStyle.solid,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    _file != null ? Icons.check_circle_outline : Icons.cloud_upload_outlined,
                    size: 36.rsp,
                    color: _file != null ? AppColors.success : AppColors.grayAsh,
                  ),
                  SizedBox(height: 10.rh),
                  if (_file != null) ...[
                    AppText(_fileName!, fontSize: 13.rsp, fontWeight: FontWeight.w600, color: AppColors.textHeading),
                    SizedBox(height: 4.rh),
                    AppText(
                      '${(_file!.lengthInBytes / 1024).toStringAsFixed(1)} Ko',
                      fontSize: 11.rsp,
                      color: AppColors.textMuted,
                    ),
                  ] else ...[
                    AppText('Cliquez pour sélectionner un fichier', fontSize: 13.rsp, color: AppColors.textMuted),
                    SizedBox(height: 4.rh),
                    AppText('Formats acceptés : .xlsx, .xls, .csv', fontSize: 11.rsp, color: AppColors.grayAsh),
                  ],
                ],
              ),
            ),
          ),

          if (_file != null) ...[
            SizedBox(height: 10.rh),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => setState(() { _file = null; _fileName = null; }),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close, size: 13.rsp, color: AppColors.error),
                    SizedBox(width: 4.rw),
                    AppText('Supprimer le fichier', fontSize: 11.rsp, color: AppColors.error),
                  ],
                ),
              ),
            ),
          ],

          SizedBox(height: 24.rh),
          const DetailDivider(),
          SizedBox(height: 20.rh),

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
              AppButton(
                text: 'Fichier exemple',
                type: AppButtonType.outline,
                icon: Icons.download,
                width: 180.rw,
                height: 60.rh,
                fontSize: 15.rsp,
                onPressed: isLoading ? null : () => getIt<MyFlotteCubit>().downloadFileEmployes(),
              ),
              SizedBox(width: 10.rw),
              DetailActionBtn(
                label: isLoading ? 'Import...' : 'Importer',
                icon: isLoading ? null : Icons.upload_rounded,
                type: AppButtonType.primary,
                onPressed: (_file != null && !isLoading) ? _submit : null,
              ),
            ],
          ),
        ]);
      },
    );
  }

  static void _showResult(BuildContext context, DataImportResponseModel data) {
    final import = data.dataImport;
    showDetailDialog(
      context,
      width: 520.rw,
      child: DetailContainer(children: [
        Row(children: [
          Container(
            padding: EdgeInsets.all(10.rw),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.rr),
            ),
            child: Icon(Icons.check_circle_outline, color: AppColors.success, size: 26.rsp),
          ),
          SizedBox(width: 14.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('Import terminé', fontSize: 17.rsp, fontWeight: FontWeight.w700, color: AppColors.textHeading),
                if (data.message != null) ...[
                  SizedBox(height: 3.rh),
                  AppText(data.message!, fontSize: 12.rsp, color: AppColors.textMuted),
                ],
              ],
            ),
          ),
        ]),
        SizedBox(height: 20.rh),
        const DetailDivider(),
        SizedBox(height: 16.rh),
        if (import != null) ...[
          DetailInfoRow(
            left: DetailInfoItem(
              label: 'Employés importés',
              value: '${import.totalCount ?? 0}',
              icon: Icons.people_outline,
            ),
            right: DetailInfoItem(
              label: 'Statut',
              value: import.status ?? '---',
              icon: Icons.info_outline,
            ),
          ),
          if (import.importId != null) ...[
            SizedBox(height: 12.rh),
            DetailInfoItem(
              label: 'ID d\'import',
              value: import.importId!,
              icon: Icons.tag_outlined,
            ),
          ],
          SizedBox(height: 20.rh),
          const DetailDivider(),
          SizedBox(height: 16.rh),
        ],
        Align(
          alignment: Alignment.centerRight,
          child: DetailActionBtn(
            label: 'Fermer',
            type: AppButtonType.outline,
            width: 120,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ),
      ]),
    );
  }
}
