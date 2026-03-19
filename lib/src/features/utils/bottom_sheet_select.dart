import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/util/constants.dart';

class BottomSheetSelect<T> extends StatelessWidget {
  const BottomSheetSelect({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.optionLabelBuilder,
  });

  final String label;
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T value)? optionLabelBuilder;

  String _optionLabel(T item) => optionLabelBuilder?.call(item) ?? '$item';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedTextStyle = theme.textTheme.bodyMedium!.copyWith(
      color: theme.primaryColor,
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.primaryColor,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: kBottomSheetBorderRadius,
                ),
                builder: (context) {
                  return _BottomSheetSelectContent<T>(
                    label: label,
                    value: value,
                    options: options,
                    optionLabelBuilder: optionLabelBuilder,
                    onChanged: onChanged,
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: theme.colorScheme.surface,
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _optionLabel(value),
                    style: selectedTextStyle,
                  ),
                  SizedBox(width: 8.w),
                  SvgPicture.asset(
                    'assets/images/dua_icon/svg/dropdown.svg',
                    color: theme.primaryColor,
                    width: 20.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheetSelectContent<T> extends StatelessWidget {
  const _BottomSheetSelectContent({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.optionLabelBuilder,
  });

  final String label;
  final T value;
  final List<T> options;
  final ValueChanged<T> onChanged;
  final String Function(T value)? optionLabelBuilder;

  String _optionLabel(T item) => optionLabelBuilder?.call(item) ?? '$item';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedBgColor = theme.colorScheme.primary.withValues(alpha: 0.12);
    final maxHeight = MediaQuery.of(context).size.height * 0.6;
    final tileHeight = 52.h;
    final separatorHeight = 8.h;
    final listHeight = options.isEmpty
        ? 0.0
        : options.length * tileHeight + (options.length - 1) * separatorHeight;
    final effectiveListHeight = listHeight.clamp(0.0, maxHeight);
    final needsScroll = listHeight > maxHeight;

    return SafeArea(
      child: Padding(
        padding: kPagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 6.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              height: effectiveListHeight,
              child: ListView.separated(
                physics: needsScroll
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                separatorBuilder: (_, __) => SizedBox(height: separatorHeight),
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = option == value;

                  return GestureDetector(
                    onTap: () {
                      onChanged(option);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? selectedBgColor : null,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: theme.colorScheme.surface,
                          width: 1.1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _optionLabel(option),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: isSelected ? theme.primaryColor : null,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
