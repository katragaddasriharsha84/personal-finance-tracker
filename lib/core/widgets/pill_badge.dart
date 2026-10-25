import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum PillBadgeVariant { success, danger, warning, primary, neutral }

class PillBadge extends StatelessWidget {
  final String text;
  final PillBadgeVariant variant;
  final IconData? icon;

  const PillBadge({
    super.key,
    required this.text,
    this.variant = PillBadgeVariant.success,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color fgColor;

    switch (variant) {
      case PillBadgeVariant.success:
        bgColor = AppColors.successLight;
        fgColor = AppColors.success;
        break;
      case PillBadgeVariant.danger:
        bgColor = AppColors.dangerLight;
        fgColor = AppColors.danger;
        break;
      case PillBadgeVariant.warning:
        bgColor = AppColors.warningLight;
        fgColor = AppColors.warning;
        break;
      case PillBadgeVariant.primary:
        bgColor = AppColors.primaryLight;
        fgColor = AppColors.primary;
        break;
      case PillBadgeVariant.neutral:
        bgColor = AppColors.surfaceSecondary;
        fgColor = AppColors.textSecondary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fgColor),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: AppTypography.captionMedium.copyWith(
              color: fgColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
