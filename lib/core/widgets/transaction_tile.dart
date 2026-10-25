import 'package:flutter/material.dart';
import '../../models/transaction_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../../screens/transactions/transaction_details_screen.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onTap;

  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TransactionDetailsScreen(transaction: transaction),
              ),
            );
          },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    transaction.timestamp,
                    style: AppTypography.captionRegular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              transaction.formattedAmount,
              style: AppTypography.bodyLargeSemiBold.copyWith(
                color: transaction.isIncome ? AppColors.success : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (transaction.initials != null) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: transaction.avatarBg ?? AppColors.avatarBlue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            transaction.initials!,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: transaction.avatarFg ?? AppColors.avatarBlueText,
            ),
          ),
        ),
      );
    }

    IconData iconData;
    Color bgColor = transaction.avatarBg ?? AppColors.surfaceSecondary;
    Color fgColor = transaction.avatarFg ?? AppColors.primary;

    switch (transaction.iconType) {
      case TransactionIconType.salary:
        iconData = Icons.south_west_rounded;
        bgColor = AppColors.avatarGreen;
        fgColor = AppColors.avatarGreenText;
        break;
      case TransactionIconType.bill:
        iconData = Icons.receipt_rounded;
        bgColor = AppColors.avatarYellow;
        fgColor = AppColors.avatarYellowText;
        break;
      case TransactionIconType.coffee:
        iconData = Icons.local_cafe_rounded;
        bgColor = AppColors.avatarYellow;
        fgColor = AppColors.avatarYellowText;
        break;
      case TransactionIconType.grocery:
        iconData = Icons.shopping_cart_rounded;
        bgColor = AppColors.avatarPink;
        fgColor = AppColors.avatarPinkText;
        break;
      case TransactionIconType.transport:
        iconData = Icons.directions_car_rounded;
        bgColor = AppColors.avatarBlue;
        fgColor = AppColors.avatarBlueText;
        break;
      case TransactionIconType.transfer:
      default:
        iconData = transaction.isIncome
            ? Icons.south_west_rounded
            : Icons.north_east_rounded;
        break;
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Icon(
          iconData,
          color: fgColor,
          size: 22,
        ),
      ),
    );
  }
}
