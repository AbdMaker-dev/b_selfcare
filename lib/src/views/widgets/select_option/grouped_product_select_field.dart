import 'dart:async';

import 'package:b_selfcare/src/data/models/group/data_item_product_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/cubit/select_option_cubit.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupedProductSelectField extends StatelessWidget {
  final String label;
  final String placeholder;
  final List<DataItemProductModel> groups;
  final ValueChanged<SelectOptionModel<String>>? onChanged;
  final Future<List<DataItemProductModel>> Function(String query) onSearch;

  const GroupedProductSelectField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.groups,
    required this.onSearch,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SelectCubit(),
      child: _GroupedProductSelectFieldView(
        label: label,
        placeholder: placeholder,
        groups: groups,
        onSearch: onSearch,
        onChanged: onChanged,
      ),
    );
  }
}

class _GroupedProductSelectFieldView extends StatefulWidget {
  final String label;
  final String placeholder;
  final List<DataItemProductModel> groups;
  final ValueChanged<SelectOptionModel<String>>? onChanged;
  final Future<List<DataItemProductModel>> Function(String query) onSearch;

  const _GroupedProductSelectFieldView({
    required this.label,
    required this.placeholder,
    required this.groups,
    required this.onSearch,
    this.onChanged,
  });

  @override
  State<_GroupedProductSelectFieldView> createState() =>
      _GroupedProductSelectFieldViewState();
}

class _GroupedProductSelectFieldViewState
    extends State<_GroupedProductSelectFieldView> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  final TextEditingController _searchController = TextEditingController();

  List<DataItemProductModel> _displayedGroups = [];
  bool _isLoadingSearch = false;
  Timer? _debounceTimer;
  StateSetter? _setOverlayState;

  double get _triggerWidth {
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.size.width ?? 200;
  }

  void _onQueryChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () async {
      _setOverlayState?.call(() => _isLoadingSearch = true);
      final results = await widget.onSearch(query);
      _setOverlayState?.call(() {
        _displayedGroups = results;
        _isLoadingSearch = false;
      });
    });
  }

  void _showOverlay(SelectOptionModel? selected) {
    _removeOverlay();
    _displayedGroups = widget.groups;

    final cubit = context.read<SelectCubit>();
    final width = _triggerWidth;

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: cubit.dismiss,
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: const Offset(0, 4),
            child: SizedBox(
              width: width,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(maxHeight: 340.rsp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.rr),
                    border: Border.all(color: AppColors.gray),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: StatefulBuilder(
                    builder: (_, setOverlayState) {
                      _setOverlayState = setOverlayState;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Search field
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.rw, 10.rh, 10.rw, 4.rh),
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              onChanged: _onQueryChanged,
                              style: TextStyle(fontSize: 14.rsp),
                              decoration: InputDecoration(
                                hintText: 'Rechercher un produit...',
                                hintStyle: TextStyle(
                                  fontSize: 13.rsp,
                                  color: AppColors.grayAsh,
                                ),
                                prefixIcon: _isLoadingSearch
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.grayAsh,
                                          ),
                                        ),
                                      )
                                    : Icon(
                                        Icons.search_rounded,
                                        size: 18,
                                        color: AppColors.grayAsh,
                                      ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.rw,
                                  vertical: 10.rh,
                                ),
                                filled: true,
                                fillColor: AppColors.grayWh,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.rr),
                                  borderSide: BorderSide(color: AppColors.gray),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.rr),
                                  borderSide: BorderSide(color: AppColors.gray),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.rr),
                                  borderSide:
                                      BorderSide(color: AppColors.greyCharcoal),
                                ),
                              ),
                            ),
                          ),
                          // Grouped list
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildGroupedItems(selected, cubit),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  List<Widget> _buildGroupedItems(SelectOptionModel? selected, SelectCubit cubit) {
    final hasItems = _displayedGroups.any((g) => (g.items ?? []).isNotEmpty);

    if (!hasItems && !_isLoadingSearch) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.rh),
          child: Center(
            child: AppText(
              'Aucun résultat',
              fontSize: 13.rsp,
              color: AppColors.grayAsh,
            ),
          ),
        ),
      ];
    }

    final widgets = <Widget>[];

    for (final group in _displayedGroups) {
      final items = group.items ?? [];
      if (items.isEmpty) continue;

      // Section header
      widgets.add(
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 7.rh),
          decoration: BoxDecoration(
            color: AppColors.grayWh,
            border: Border(
              bottom: BorderSide(color: AppColors.gray),
            ),
          ),
          child: AppText(
            (group.label ?? '').toUpperCase(),
            fontSize: 11.rsp,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
      );

      // Items
      for (final item in items) {
        final opt = SelectOptionModel<String>(
          label: item.name ?? '---',
          value: item.id.toString(),
          subtitle: item.description,
        );
        final isSelected = selected?.value == opt.value;
        widgets.add(
          GestureDetector(
            onTap: () {
              cubit.select(opt);
              widget.onChanged?.call(opt);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14.rw,
                vertical: 10.rh,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.grayGh : Colors.transparent,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          item.name ?? '---',
                          fontSize: 14.rsp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: AppColors.textHeading,
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_rounded,
                      size: 18.rsp,
                      color: AppColors.greyCharcoal,
                    ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _searchController.clear();
    _setOverlayState = null;
    _debounceTimer?.cancel();
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectCubit, SelectState>(
      listener: (ctx, state) {
        final isOpen = state.mapOrNull(open: (_) => true) ?? false;
        final selected = state.mapOrNull(
          open: (s) => s.selected,
          chosen: (s) => s.option,
        );
        if (isOpen) {
          _showOverlay(selected);
        } else {
          _removeOverlay();
        }
      },
      child: BlocBuilder<SelectCubit, SelectState>(
        builder: (ctx, state) {
          final isOpen = state.mapOrNull(open: (_) => true) ?? false;
          final selected = state.mapOrNull(
            open: (s) => s.selected,
            chosen: (s) => s.option,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                widget.label,
                type: AppTextType.label,
                fontSize: 14.rsp,
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.0.rh),
              CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  onTap: () => ctx.read<SelectCubit>().toggleOpen(),
                  child: AnimatedContainer(
                    key: _triggerKey,
                    duration: const Duration(milliseconds: 200),
                    constraints:
                        const BoxConstraints(minHeight: kMinInteractiveDimension),
                    padding: EdgeInsets.symmetric(horizontal: 14.rw),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppColors.grayWh,
                      borderRadius: BorderRadius.circular(10.rr),
                      border: Border.all(
                        color: isOpen ? AppColors.greyCharcoal : AppColors.gray,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppText(
                            selected?.label ?? widget.placeholder,
                            fontSize: 14.rsp,
                            color: selected != null
                                ? AppColors.textHeading
                                : AppColors.grayAsh,
                          ),
                        ),
                        AnimatedRotation(
                          turns: isOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.grayAsh,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
