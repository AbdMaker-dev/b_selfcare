import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/form_edit_groupe.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/form_import_employe.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/group_employees_dialog.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailGroupe extends StatelessWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;

  const DetailGroupe({super.key, required this.groupe, required this.groupCubit});

  static void show(BuildContext context, {required GroupModel groupe, required GroupCubit groupCubit}) {
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
            height: double.infinity.rh,
            child: DetailGroupe(groupe: groupe, groupCubit: groupCubit),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = groupe.product;

    return Container(
      height: double.infinity.rh,
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
                        'Détail groupe',
                        fontSize: 20.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayAsh,
                        highlight: 'groupe',
                        fontFamily: FontFamily.syne,
                        highlightColor: AppColors.primary,
                        highlightFontSize: 20.rsp,
                      ),
                      SizedBox(height: 4.rh),
                      AppText(
                        '${groupe.name ?? '---'} · ${groupe.employeesCount ?? 0} employé(s)',
                        fontSize: 10.rsp,
                        color: AppColors.textMuted,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 6.rh),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.graySilver),
                    ),
                    child: AppText(
                      'X',
                      fontSize: 13.rsp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
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
                  _HeaderCard(groupe: groupe),
                  SizedBox(height: 16.rh),
                  _SectionInfos(groupe: groupe),
                  if (product != null) ...[
                    SizedBox(height: 16.rh),
                    const DetailDivider(),
                    SizedBox(height: 16.rh),
                    DetailProductSection(product: product),
                  ],
                  SizedBox(height: 16.rh),
                  const DetailDivider(),
                  SizedBox(height: 16.rh),
                  _SectionSmsNotification(groupe: groupe, groupCubit: groupCubit),
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
                SizedBox(width: 8.rw),
                Expanded(
                  child: AppButton(
                    text: 'Employés',
                    type: AppButtonType.outline,
                    fontSize: 13.rsp,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      GroupEmployeesDialog.show(context, groupe: groupe, groupCubit: groupCubit);
                    },
                  ),
                ),
                SizedBox(width: 8.rw),
                Expanded(
                  child: AppButton(
                    text: 'Importer',
                    type: AppButtonType.primary,
                    color: AppColors.primary,
                    fontSize: 13.rsp,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      FormImportEmploye.show(context, groupe: groupe, groupCubit: groupCubit);
                    },
                  ),
                ),
                SizedBox(width: 8.rw),
                Expanded(
                  child: AppButton(
                    text: 'Modifier',
                    type: AppButtonType.secondary,
                    fontSize: 13.rsp,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      FormEditGroupe.show(context, groupe: groupe, groupCubit: groupCubit);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Header card ─────────────────────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  final GroupModel groupe;
  const _HeaderCard({required this.groupe});

  @override
  Widget build(BuildContext context) {
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
          DetailIconBox(icon: Icons.group_outlined),
          SizedBox(width: 14.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  groupe.name ?? '---',
                  fontSize: 16.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
                if (groupe.description?.isNotEmpty == true) ...[
                  SizedBox(height: 4.rh),
                  AppText(groupe.description!, fontSize: 13.rsp, color: AppColors.textMuted),
                ],
              ],
            ),
          ),
          _EmployeeBadge(count: groupe.employeesCount),
        ],
      ),
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

// ─── Section infos générales ─────────────────────────────────────────────────

class _SectionInfos extends StatelessWidget {
  final GroupModel groupe;
  const _SectionInfos({required this.groupe});

  @override
  Widget build(BuildContext context) {
    final count = groupe.employeesCount;
    final quotas = groupe.product?.quotas;
    final pricePerEmployee = (quotas != null && quotas.isNotEmpty)
        ? quotas.fold<num>(0, (s, q) => s + (q.price ?? 0))
        : groupe.product?.price;
    final globalCost = (pricePerEmployee != null && count != null)
        ? pricePerEmployee * count
        : null;

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
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left: DetailInfoItem(
            label: 'Nombre d\'employés',
            value: '${count ?? 0} employé${(count ?? 0) > 1 ? 's' : ''}',
            icon: Icons.people_outline,
          ),
          right: DetailInfoItem(
            label: 'Coût global',
            value: globalCost != null ? AppMoney.format(globalCost) : '---',
            icon: Icons.monetization_on_outlined,
          ),
        ),
      ],
    );
  }
}

// ─── Section Notification SMS interactive ────────────────────────────────────

class _SectionSmsNotification extends StatefulWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;
  const _SectionSmsNotification({required this.groupe, required this.groupCubit});

  @override
  State<_SectionSmsNotification> createState() => _SectionSmsNotificationState();
}

class _SectionSmsNotificationState extends State<_SectionSmsNotification> {
  late bool _enabled;
  late final TextEditingController _templateController;

  @override
  void initState() {
    super.initState();
    _enabled = widget.groupe.smsNotificationEnabled ?? false;
    _templateController = TextEditingController(
      text: widget.groupe.smsNotificationTemplate ?? '',
    );
  }

  @override
  void dispose() {
    _templateController.dispose();
    super.dispose();
  }

  void _save() {
    final id = widget.groupe.id;
    if (id == null) return;
    widget.groupCubit.configurationNotificationGroupe(
      id: id,
      data: {
        'sms_notification_enabled': _enabled,
        'sms_notification_template': _templateController.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupCubit, GroupState>(
      bloc: widget.groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          configNotifGroupeLoaded: (_) {
            widget.groupCubit.getGroups(data: {'page': 1});
          },
          configNotifGroupeFailed: (msg) {
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state is ConfigNotifGroupeLoading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailSectionTitle(label: 'Notification SMS', icon: Icons.sms_outlined),
            SizedBox(height: 14.rh),
            // Toggle activer / désactiver
            GestureDetector(
              onTap: () => setState(() => _enabled = !_enabled),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
                decoration: BoxDecoration(
                  color: AppColors.grayWh,
                  borderRadius: BorderRadius.circular(10.rr),
                  border: Border.all(
                    color: _enabled ? AppColors.success : AppColors.gray,
                  ),
                ),
                child: Row(
                  children: [
                    Switch(
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                      activeTrackColor: AppColors.success.withValues(alpha: 0.3),
                      activeThumbColor: AppColors.success,
                    ),
                    SizedBox(width: 8.rw),
                    AppText(
                      _enabled ? 'Notifications SMS activées' : 'Notifications SMS désactivées',
                      fontSize: 14.rsp,
                      color: _enabled ? AppColors.success : AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            if (_enabled) ...[
              SizedBox(height: 12.rh),
              AppText(
                'Template SMS',
                fontSize: 12.rsp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: 6.rh),
              TextFormField(
                controller: _templateController,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Ex:YAS B2B : Bonjour {prenom}, votre forfait ({ressources}) a été renouvelé avec succès sur le numéro {msisdn}.',
                  hintStyle: TextStyle(fontSize: 13.rsp, color: AppColors.grayAsh),
                  filled: true,
                  fillColor: AppColors.grayWh,
                  contentPadding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.rr),
                    borderSide: BorderSide(color: AppColors.gray),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.rr),
                    borderSide: BorderSide(color: AppColors.gray),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.rr),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ],
            SizedBox(height: 12.rh),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: isLoading ? 'Enregistrement...' : 'Enregistrer la configuration SMS',
                type: AppButtonType.primary,
                fontSize: 13.rsp,
                onPressed: isLoading ? null : _save,
              ),
            ),
          ],
        );
      },
    );
  }
}
