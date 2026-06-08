import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigNotifGroupe extends StatefulWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;

  const ConfigNotifGroupe({
    super.key,
    required this.groupe,
    required this.groupCubit,
  });

  static void show(
    BuildContext context, {
    required GroupModel groupe,
    required GroupCubit groupCubit,
  }) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder: (_, _, _) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 650.rw,
            height: double.infinity,
            child: ConfigNotifGroupe(groupe: groupe, groupCubit: groupCubit),
          ),
        ),
      ),
    );
  }

  @override
  State<ConfigNotifGroupe> createState() => _ConfigNotifGroupeState();
}

class _ConfigNotifGroupeState extends State<ConfigNotifGroupe> {
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

  void _submit() {
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
    return BlocListener<GroupCubit, GroupState>(
      bloc: widget.groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          configNotifGroupeLoaded: (_) =>
              Navigator.of(context, rootNavigator: true).pop(),
          configNotifGroupeFailed: (message) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: AppColors.error),
            );
          },
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
                          'Notification SMS',
                          fontSize: 24.rsp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grayAsh,
                          highlight: 'SMS',
                          fontFamily: FontFamily.syne,
                          highlightColor: AppColors.primary,
                          highlightFontSize: 24.rsp,
                        ),
                        SizedBox(height: 4.rh),
                        AppText(
                          '${widget.groupe.name ?? '---'} · Configuration notification',
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
                child: BlocBuilder<GroupCubit, GroupState>(
                  bloc: widget.groupCubit,
                  builder: (context, state) {
                    final isLoading = state is ConfigNotifGroupeLoading;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Activation toggle
                        DetailSectionTitle(
                          label: 'Activation',
                          icon: Icons.notifications_outlined,
                        ),
                        SizedBox(height: 14.rh),
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
                                  _enabled
                                      ? 'Notifications SMS activées'
                                      : 'Notifications SMS désactivées',
                                  fontSize: 14.rsp,
                                  color: _enabled ? AppColors.success : AppColors.textMuted,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20.rh),
                        const DetailDivider(),
                        SizedBox(height: 20.rh),

                        // Template message
                        DetailSectionTitle(
                          label: 'Message template',
                          icon: Icons.sms_outlined,
                        ),
                        SizedBox(height: 14.rh),
                        TextFormField(
                          controller: _templateController,
                          maxLines: 6,
                          keyboardType: TextInputType.multiline,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            hintText:
                                'Ex : YAS B2B : Bonjour {prenom}, votre forfait ({ressources}) a été renouvelé avec succès sur le numéro {msisdn}.',
                            hintStyle: TextStyle(fontSize: 13.rsp, color: AppColors.grayAsh),
                            filled: true,
                            fillColor: AppColors.grayWh,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14.rw,
                              vertical: 12.rh,
                            ),
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
                        SizedBox(height: 16.rh),
                      ],
                    );
                  },
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
              child: BlocBuilder<GroupCubit, GroupState>(
                bloc: widget.groupCubit,
                builder: (context, state) {
                  final isLoading = state is ConfigNotifGroupeLoading;
                  return Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Annuler',
                          type: AppButtonType.outline,
                          fontSize: 13.rsp,
                          onPressed: isLoading
                              ? null
                              : () => Navigator.of(context, rootNavigator: true).pop(),
                        ),
                      ),
                      SizedBox(width: 8.rw),
                      Expanded(
                        flex: 2,
                        child: AppButton(
                          text: isLoading ? 'Enregistrement...' : 'Enregistrer la configuration',
                          type: AppButtonType.primary,
                          fontSize: 13.rsp,
                          onPressed: isLoading ? null : _submit,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
