import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/cubit/select_option_cubit.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectField<T> extends StatelessWidget {
  final String label;
  final List<SelectOptionModel<T>> options;
  final String placeholder;
  final ValueChanged<SelectOptionModel<T>>? onChanged;
  final SelectOptionModel<T>? initialValue;

  const SelectField({
    super.key,
    required this.label,
    required this.options,
    this.placeholder = 'Sélectionner...',
    this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = SelectCubit();
        if (initialValue != null) cubit.select(initialValue!);
        return cubit;
      },
      child: _SelectFieldView<T>(
        label: label,
        options: options,
        placeholder: placeholder,
        onChanged: onChanged,
      ),
    );
  }
}

class _SelectFieldView<T> extends StatefulWidget {
  final String label;
  final List<SelectOptionModel<T>> options;
  final String placeholder;
  final ValueChanged<SelectOptionModel<T>>? onChanged;

  const _SelectFieldView({
    required this.label,
    required this.options,
    required this.placeholder,
    this.onChanged,
  });

  @override
  State<_SelectFieldView<T>> createState() => _SelectFieldViewState<T>();
}

class _SelectFieldViewState<T> extends State<_SelectFieldView<T>> {
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  double get _triggerWidth {
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.size.width ?? 200;
  }

  void _showOverlay(SelectOptionModel? selected) {
    _removeOverlay();
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
                  constraints: const BoxConstraints(maxHeight: 260),
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
                  child: SingleChildScrollView(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.options.map((opt) {
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
                            color: isSelected
                                ? AppColors.grayGh
                                : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      opt.label,
                                      fontSize: 14.rsp,
                                      fontWeight: isSelected
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
                              if (isSelected)
                                Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: AppColors.greyCharcoal,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
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

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
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
                widget.label.toUpperCase(),
                color: AppColors.grayAsh,
                fontWeight: FontWeight.w600,
                fontSize: 10.rsp,
              ),
              SizedBox(height: 6.rh),
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
