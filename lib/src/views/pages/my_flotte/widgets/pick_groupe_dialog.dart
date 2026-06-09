import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickGroupeDialog extends StatefulWidget {
  final GroupCubit groupCubit;
  final void Function(GroupModel, GroupCubit) onSelected;

  const PickGroupeDialog({super.key, required this.groupCubit, required this.onSelected});

  static void show(BuildContext context, {required void Function(GroupModel, GroupCubit) onSelected}) {
    final groupCubit = getIt<GroupCubit>();
    groupCubit.getGroups(data: {'page': 1});
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.rr)),
        child: SizedBox(
          width: 440.rw,
          child: PickGroupeDialog(groupCubit: groupCubit, onSelected: onSelected),
        ),
      ),
    );
  }

  @override
  State<PickGroupeDialog> createState() => _PickGroupeDialogState();
}

class _PickGroupeDialogState extends State<PickGroupeDialog> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      bloc: widget.groupCubit,
      builder: (ctx, state) {
        final allGroups = state.maybeWhen(
          getGroupsLoaded: (data) => data.data?.groups ?? <GroupModel>[],
          orElse: () => <GroupModel>[],
        );
        final filtered = _query.isEmpty
            ? allGroups
            : allGroups.where((g) => (g.name ?? '').toLowerCase().contains(_query.toLowerCase())).toList();
        final isLoading = state is GetGroupsLoading;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.rw, 20.rh, 20.rw, 16.rh),
              child: Row(children: [
                DetailIconBox(icon: Icons.group_outlined),
                SizedBox(width: 14.rw),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText('Sélectionner un groupe', fontSize: 16.rsp, fontWeight: FontWeight.w700, color: AppColors.primary),
                    if (!isLoading && allGroups.isNotEmpty)
                      AppText(
                        '${allGroups.length} groupe${allGroups.length > 1 ? 's' : ''} disponible${allGroups.length > 1 ? 's' : ''}',
                        fontSize: 12.rsp,
                        color: AppColors.textMuted,
                      ),
                  ],
                ),
              ]),
            ),
            const DetailDivider(),

            // ── Recherche ────────────────────────────────────────────────────
            if (!isLoading && allGroups.isNotEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(16.rw, 12.rh, 16.rw, 4.rh),
                child: AppSearchInput(
                  controller: _searchController,
                  hintText: 'Rechercher un groupe...',
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),

            // ── Corps ────────────────────────────────────────────────────────
            if (isLoading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.rh),
                child: Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2.5)),
              )
            else if (allGroups.isEmpty)
              _EmptyState(icon: Icons.group_off_outlined, message: 'Aucun groupe disponible', hint: 'Créez d\'abord un groupe pour continuer')
            else if (filtered.isEmpty)
              _EmptyState(icon: Icons.search_off_rounded, message: 'Aucun résultat', hint: 'Aucun groupe ne correspond à « $_query »')
            else
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 280.rh),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(16.rw, 10.rh, 16.rw, 4.rh),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => _GroupTile(
                    groupe: filtered[i],
                    query: _query,
                    onTap: () {
                      Navigator.of(ctx).pop();
                      widget.onSelected(filtered[i], widget.groupCubit);
                    },
                  ),
                ),
              ),

            const DetailDivider(),

            // ── Footer ───────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh),
              child: Align(
                alignment: Alignment.centerRight,
                child: DetailActionBtn(
                  label: 'Annuler',
                  type: AppButtonType.outline,
                  width: 110,
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Tuile groupe ──────────────────────────────────────────────────────────────

class _GroupTile extends StatelessWidget {
  final GroupModel groupe;
  final String query;
  final VoidCallback onTap;

  const _GroupTile({required this.groupe, required this.query, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.rh),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.rr),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
          decoration: BoxDecoration(
            color: AppColors.grayWh,
            borderRadius: BorderRadius.circular(10.rr),
            border: Border.all(color: AppColors.gray),
          ),
          child: Row(
            children: [
              Container(
                width: 36.rw,
                height: 36.rh,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.rr),
                ),
                child: Icon(Icons.group_outlined, color: AppColors.primary, size: 18.rsp),
              ),
              SizedBox(width: 12.rw),
              Expanded(child: _HighlightedText(text: groupe.name ?? '---', query: query)),
              Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 18.rsp),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Texte avec surbrillance de la recherche ───────────────────────────────────

class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;

  const _HighlightedText({required this.text, required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return AppText(text, fontSize: 14.rsp, fontWeight: FontWeight.w500, color: AppColors.textHeading);
    }
    final lower = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final start = lower.indexOf(lowerQuery);
    if (start == -1) {
      return AppText(text, fontSize: 14.rsp, fontWeight: FontWeight.w500, color: AppColors.textHeading);
    }
    final end = start + query.length;
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14.rsp, fontWeight: FontWeight.w500, color: AppColors.textHeading),
        children: [
          if (start > 0) TextSpan(text: text.substring(0, start)),
          TextSpan(
            text: text.substring(start, end),
            style: TextStyle(
              backgroundColor: AppColors.secondary.withValues(alpha: 0.6),
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (end < text.length) TextSpan(text: text.substring(end)),
        ],
      ),
    );
  }
}

// ── État vide ─────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String hint;

  const _EmptyState({required this.icon, required this.message, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.rh, horizontal: 20.rw),
      child: Column(
        children: [
          Container(
            width: 52.rw,
            height: 52.rh,
            decoration: BoxDecoration(color: AppColors.grayGh, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.grayAsh, size: 26.rsp),
          ),
          SizedBox(height: 10.rh),
          AppText(message, fontSize: 14.rsp, fontWeight: FontWeight.w600, color: AppColors.textHeading),
          SizedBox(height: 4.rh),
          AppText(hint, fontSize: 12.rsp, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
