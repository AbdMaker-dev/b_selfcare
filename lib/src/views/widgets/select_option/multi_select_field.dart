import 'dart:async';

import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';

class MultiSelectField<T> extends StatefulWidget {
  final String label;
  final List<SelectOptionModel<T>> options;
  final String placeholder;
  final List<T> initialValues;
  final ValueChanged<List<SelectOptionModel<T>>>? onChanged;
  final SelectSearchMode? searchMode;
  final Future<List<SelectOptionModel<T>>> Function(String query)? onSearch;

  const MultiSelectField({
    super.key,
    required this.label,
    required this.options,
    this.placeholder = 'Sélectionner...',
    this.initialValues = const [],
    this.onChanged,
    this.searchMode,
    this.onSearch,
  }) : assert(
          searchMode != SelectSearchMode.api || onSearch != null,
          'onSearch est requis quand searchMode est api',
        );

  @override
  State<MultiSelectField<T>> createState() => _MultiSelectFieldState<T>();
}

class _MultiSelectFieldState<T> extends State<MultiSelectField<T>> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  OverlayEntry? _overlayEntry;

  late List<T> _selected;
  bool _isOpen = false;

  List<SelectOptionModel<T>> _apiResults = [];
  bool _isLoadingSearch = false;
  Timer? _debounceTimer;
  StateSetter? _setOverlayState;

  bool get _isSearchable => widget.searchMode != null;

  @override
  void initState() {
    super.initState();
    _selected = List<T>.from(widget.initialValues);
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  double get _triggerWidth {
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.size.width ?? 200;
  }

  void _onQueryChanged(String query) {
    if (widget.searchMode == SelectSearchMode.api) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 350), () async {
        _setOverlayState?.call(() => _isLoadingSearch = true);
        final results = await widget.onSearch!(query);
        _setOverlayState?.call(() {
          _apiResults = results;
          _isLoadingSearch = false;
        });
      });
    } else {
      _setOverlayState?.call(() {});
    }
  }

  void _toggleOption(SelectOptionModel<T> opt) {
    setState(() {
      if (_selected.contains(opt.value)) {
        _selected.remove(opt.value);
      } else {
        _selected.add(opt.value);
      }
    });
    final selectedOpts =
        widget.options.where((o) => _selected.contains(o.value)).toList();
    widget.onChanged?.call(selectedOpts);
    _rebuildOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    if (widget.searchMode == SelectSearchMode.api) {
      _apiResults = widget.options;
    }

    final width = _triggerWidth;

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeOverlay,
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
                  constraints: const BoxConstraints(maxHeight: 300),
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
                      final query = _searchController.text.toLowerCase();

                      final List<SelectOptionModel<T>> filtered;
                      if (!_isSearchable) {
                        filtered = widget.options;
                      } else if (widget.searchMode == SelectSearchMode.local) {
                        filtered = widget.options
                            .where((o) => o.label.toLowerCase().contains(query))
                            .toList();
                      } else {
                        filtered = _apiResults;
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isSearchable)
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.rw, 10.rh, 10.rw, 4.rh),
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                onChanged: _onQueryChanged,
                                style: TextStyle(fontSize: 14.rsp),
                                decoration: InputDecoration(
                                  hintText: 'Rechercher...',
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
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: filtered.isEmpty && !_isLoadingSearch
                                    ? [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16.rh),
                                          child: AppText(
                                            'Aucun résultat',
                                            fontSize: 13.rsp,
                                            color: AppColors.grayAsh,
                                          ),
                                        ),
                                      ]
                                    : filtered.map((opt) {
                                        final isChecked =
                                            _selected.contains(opt.value);
                                        return GestureDetector(
                                          onTap: () {
                                            _toggleOption(opt);
                                            setOverlayState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 14.rw,
                                              vertical: 10.rh,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isChecked
                                                  ? AppColors.grayGh
                                                  : Colors.transparent,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      AppText(
                                                        opt.label,
                                                        fontSize: 14.rsp,
                                                        fontWeight: isChecked
                                                            ? FontWeight.w600
                                                            : FontWeight.normal,
                                                        color: AppColors.textHeading,
                                                      ),
                                                      if (opt.subtitle != null)
                                                        AppText(
                                                          opt.subtitle!,
                                                          fontSize: 12.rsp,
                                                          color: AppColors.grayAsh,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                AnimatedSwitcher(
                                                  duration: const Duration(
                                                      milliseconds: 150),
                                                  child: isChecked
                                                      ? Icon(
                                                          Icons.check_box_rounded,
                                                          key: const ValueKey(true),
                                                          size: 18,
                                                          color:
                                                              AppColors.greyCharcoal,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .check_box_outline_blank_rounded,
                                                          key: const ValueKey(false),
                                                          size: 18,
                                                          color: AppColors.grayAsh,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
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

  void _rebuildOverlay() {
    if (_isOpen) {
      _overlayEntry?.markNeedsBuild();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _searchController.clear();
    _setOverlayState = null;
    _debounceTimer?.cancel();
  }

  void _closeOverlay() {
    _removeOverlay();
    setState(() => _isOpen = false);
  }

  void _toggle() {
    if (_isOpen) {
      _closeOverlay();
    } else {
      setState(() => _isOpen = true);
      _showOverlay();
    }
  }

  String get _triggerLabel {
    if (_selected.isEmpty) return widget.placeholder;
    if (_selected.length == 1) {
      return widget.options
          .firstWhere(
            (o) => o.value == _selected.first,
            orElse: () => SelectOptionModel(
                label: _selected.first.toString(), value: _selected.first),
          )
          .label;
    }
    return '${_selected.length} numéros sélectionnés';
  }

  @override
  Widget build(BuildContext context) {
    final hasSelection = _selected.isNotEmpty;

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
            onTap: _toggle,
            child: AnimatedContainer(
              key: _triggerKey,
              duration: const Duration(milliseconds: 200),
              constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
              padding: EdgeInsets.symmetric(horizontal: 14.rw),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: AppColors.grayWh,
                borderRadius: BorderRadius.circular(10.rr),
                border: Border.all(
                  color: _isOpen ? AppColors.greyCharcoal : AppColors.gray,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppText(
                      _triggerLabel,
                      fontSize: 14.rsp,
                      color: hasSelection
                          ? AppColors.textHeading
                          : AppColors.grayAsh,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isOpen ? 0.5 : 0,
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
  }
}
