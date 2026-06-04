import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/user_profile_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_date.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/users/cubit/users_cubit.dart';
import 'package:b_selfcare/src/views/pages/users/widgets/confirm_delete_user.dart';
import 'package:b_selfcare/src/views/pages/users/widgets/user_form.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';

class DetailUser extends StatefulWidget {
  final UserProfileModel userPreview;
  final UsersCubit usersCubit;

  const DetailUser({super.key, required this.userPreview, required this.usersCubit});

  static void show(
    BuildContext context, {
    required UserProfileModel userPreview,
    required UsersCubit usersCubit,
  }) {
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
            child: DetailUser(userPreview: userPreview, usersCubit: usersCubit),
          ),
        ),
      ),
    );
  }

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  UserProfileModel? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    widget.usersCubit.getUserById(widget.userPreview.id!).then((u) {
      if (mounted) setState(() { _user = u ?? widget.userPreview; _loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _user ?? widget.userPreview;

    return Container(
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
                        'Détail utilisateur',
                        fontSize: 20.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grayAsh,
                        highlight: 'utilisateur',
                        fontFamily: FontFamily.syne,
                        highlightColor: AppColors.primary,
                        highlightFontSize: 20.rsp,
                      ),
                      SizedBox(height: 4.rh),
                      AppText(
                        '${user.name ?? '---'} · ${user.email ?? '---'} · ${user.status ?? '---'}',
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
            child: _loading
                ? Center(child: CircularProgressIndicator(color: AppColors.primary))
                : SingleChildScrollView(
                    padding: EdgeInsets.all(16.rw),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeaderCard(user: user),
                        SizedBox(height: 16.rh),
                        _SectionInfos(user: user),
                        if (user.roles.isNotEmpty) ...[
                          SizedBox(height: 16.rh),
                          const DetailDivider(),
                          SizedBox(height: 16.rh),
                          _SectionRoles(user: user),
                        ],
                        SizedBox(height: 16.rh),
                      ],
                    ),
                  ),
          ),

          // FOOTER
          _Actions(user: user, usersCubit: widget.usersCubit),
        ],
      ),
    );
  }
}

// ─── Header card ─────────────────────────────────────────────────────────────

class _HeaderCard extends StatelessWidget {
  final UserProfileModel user;
  const _HeaderCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final initials = _initials(user.firstName, user.lastName);
    final isActive = user.status?.toUpperCase() == 'ACTIVE';

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
                AppText(
                  user.name ?? '---',
                  fontSize: 16.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
                if (user.email != null) ...[
                  SizedBox(height: 4.rh),
                  AppText(user.email!, fontSize: 13.rsp, color: AppColors.textMuted),
                ],
                if (user.msisdn != null) ...[
                  SizedBox(height: 3.rh),
                  AppText(user.msisdn!, fontSize: 13.rsp, color: AppColors.textMuted),
                ],
              ],
            ),
          ),
          DetailStatusBadge.fromStatus(user.status),
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
  final UserProfileModel user;
  const _SectionInfos({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Informations personnelles', icon: Icons.person_outline),
        SizedBox(height: 14.rh),
        DetailInfoRow(
          left:  DetailInfoItem(label: 'Prénom', value: user.firstName ?? '---', icon: Icons.badge_outlined),
          right: DetailInfoItem(label: 'Nom',    value: user.lastName  ?? '---', icon: Icons.badge_outlined),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left:  DetailInfoItem(label: 'Email',     value: user.email  ?? '---', icon: Icons.email_outlined),
          right: DetailInfoItem(label: 'Téléphone', value: user.msisdn ?? '---', icon: Icons.phone_outlined),
        ),
        SizedBox(height: 12.rh),
        DetailInfoRow(
          left:  DetailInfoItem(label: 'Dernière connexion', value: AppDate.format(user.lastLoginAt), icon: Icons.login_outlined),
          right: DetailInfoItem(label: 'Invitation envoyée',  value: AppDate.format(user.invitedAt),  icon: Icons.mark_email_read_outlined),
        ),
      ],
    );
  }
}

// ─── Section rôles ────────────────────────────────────────────────────────────

class _SectionRoles extends StatelessWidget {
  final UserProfileModel user;
  const _SectionRoles({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSectionTitle(label: 'Rôles (${user.roles.length})', icon: Icons.shield_outlined),
        SizedBox(height: 10.rh),
        Wrap(
          spacing: 10.rw,
          runSpacing: 8.rh,
          children: user.roles.map((r) => _RoleBadge(name: r.displayName ?? r.name ?? '---')).toList(),
        ),
      ],
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String name;
  const _RoleBadge({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 8.rh),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_user_outlined, size: 13.rsp, color: AppColors.primary),
          SizedBox(width: 6.rw),
          AppText(name, fontSize: 13.rsp, fontWeight: FontWeight.w600, color: AppColors.primary),
        ],
      ),
    );
  }
}

// ─── Footer actions ───────────────────────────────────────────────────────────

class _Actions extends StatelessWidget {
  final UserProfileModel user;
  final UsersCubit usersCubit;
  const _Actions({required this.user, required this.usersCubit});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              fontSize: 14.rsp,
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
          ),
          SizedBox(width: 12.rw),
          Expanded(
            child: AppButton(
              text: 'Supprimer',
              type: AppButtonType.primary,
              color: AppColors.error,
              fontSize: 14.rsp,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                ConfirmDeleteUser.show(context, user: user, usersCubit: usersCubit);
              },
            ),
          ),
          SizedBox(width: 12.rw),
          Expanded(
            child: AppButton(
              text: 'Modifier',
              type: AppButtonType.secondary,
              fontSize: 14.rsp,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                if (context.mounted) {
                  showDetailDialog(context, width: 650, child: UserForm(user: user));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
