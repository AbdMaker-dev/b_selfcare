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
  final Future<List<DataItemProductModel>> Function(dynamic data) onFetch;

  const GroupedProductSelectField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.groups,
    required this.onFetch,
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
        onFetch: onFetch,
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
  final Future<List<DataItemProductModel>> Function(dynamic data) onFetch;

  const _GroupedProductSelectFieldView({
    required this.label,
    required this.placeholder,
    required this.groups,
    required this.onFetch,
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
  String _selectedType = 'NATIVE';
  bool _isLoading = false;
  Timer? _debounceTimer;
  StateSetter? _setOverlayState;

  double get _triggerWidth {
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.size.width ?? 200;
  }

  Future<void> _fetch({required String type, String query = ''}) async {
    _setOverlayState?.call(() => _isLoading = true);
    final results = await widget.onFetch({
      'type': type,
      if (query.isNotEmpty) 'search': query,
    });
    _setOverlayState?.call(() {
      _displayedGroups = results;
      _isLoading = false;
    });
  }

  Future<void> _fetchForType(String type) async {
    _selectedType = type;
    _searchController.clear();
    await _fetch(type: type);
  }

  void _onQueryChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      _fetch(type: _selectedType, query: query);
    });
  }

  void _showOverlay(SelectOptionModel? selected) {
    _removeOverlay();
    _displayedGroups = widget.groups;
    _selectedType = 'NATIVE';

    final cubit = context.read<SelectCubit>();
    final width = _triggerWidth;

    // Initial fetch
    Future.microtask(() => _fetchForType('NATIVE'));

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
                  constraints: BoxConstraints(maxHeight: 360.rsp),
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
                          // Type tabs
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                10.rw, 10.rh, 10.rw, 8.rh),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _TypeTab(
                                    label: 'Produits natifs',
                                    isSelected: _selectedType == 'NATIVE',
                                    onTap: () => _fetchForType('NATIVE'),
                                  ),
                                ),
                                SizedBox(width: 8.rw),
                                Expanded(
                                  child: _TypeTab(
                                    label: 'Produits custom',
                                    isSelected: _selectedType == 'CUSTOM',
                                    onTap: () => _fetchForType('CUSTOM'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Search field
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                10.rw, 0, 10.rw, 8.rh),
                            child: TextField(
                              controller: _searchController,
                              onChanged: _onQueryChanged,
                              style: TextStyle(fontSize: 14.rsp),
                              decoration: InputDecoration(
                                hintText: 'Rechercher...',
                                hintStyle: TextStyle(
                                  fontSize: 13.rsp,
                                  color: AppColors.grayAsh,
                                ),
                                prefixIcon: Icon(
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
                                  borderSide:
                                      BorderSide(color: AppColors.gray),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.rr),
                                  borderSide:
                                      BorderSide(color: AppColors.gray),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.rr),
                                  borderSide: BorderSide(
                                      color: AppColors.greyCharcoal),
                                ),
                              ),
                            ),
                          ),
                          Divider(height: 1, color: AppColors.gray),
                          // Items list
                          Flexible(
                            child: _isLoading
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 24.rh),
                                    child: Center(
                                      child: SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _buildItems(selected, cubit),
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

  List<Widget> _buildItems(SelectOptionModel? selected, SelectCubit cubit) {
    final allItems = _displayedGroups
        .expand((g) => g.items ?? [])
        .toList();

    if (allItems.isEmpty) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.rh),
          child: Center(
            child: AppText(
              'Aucun produit',
              fontSize: 13.rsp,
              color: AppColors.grayAsh,
            ),
          ),
        ),
      ];
    }

    return allItems.map((item) {
      final opt = SelectOptionModel<String>(
        label: item.name ?? '---',
        value: item.id.toString(),
        subtitle: item.description,
      );
      final isSelected = selected?.value == opt.value;
      return GestureDetector(
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
            border: Border(
              bottom: BorderSide(color: AppColors.gray.withValues(alpha: 0.5)),
            ),
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
                    if (item.description != null &&
                        item.description!.isNotEmpty)
                      AppText(
                        item.description!,
                        fontSize: 12.rsp,
                        color: AppColors.grayAsh,
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
      );
    }).toList();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _searchController.clear();
    _debounceTimer?.cancel();
    _setOverlayState = null;
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
                    constraints: const BoxConstraints(
                        minHeight: kMinInteractiveDimension),
                    padding: EdgeInsets.symmetric(horizontal: 14.rw),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: AppColors.grayWh,
                      borderRadius: BorderRadius.circular(10.rr),
                      border: Border.all(
                        color: isOpen
                            ? AppColors.greyCharcoal
                            : AppColors.gray,
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

class _TypeTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(vertical: 8.rh),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.grayWh,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.gray,
          ),
        ),
        child: AppText(
          label,
          fontSize: 13.rsp,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? AppColors.white : AppColors.grayAsh,
        ),
      ),
    );
  }
}
