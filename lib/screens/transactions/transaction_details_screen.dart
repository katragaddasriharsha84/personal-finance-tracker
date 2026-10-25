import 'package:flutter/material.dart';
import '../../models/transaction_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/pill_badge.dart';
import '../../core/widgets/app_button.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Details',
        trailing: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: IconButton(
            icon: const Icon(Icons.share_outlined, size: 20, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sharing transaction receipt...')),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Merchant Icon
            _buildCenterIcon(),
            const SizedBox(height: 16),

            // Merchant Name
            Text(
              transaction.title,
              style: AppTypography.headingMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Amount
            Text(
              transaction.formattedAmount,
              style: AppTypography.displayLarge.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: transaction.isIncome ? AppColors.success : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // Status Badge
            const PillBadge(
              text: 'Completed',
              variant: PillBadgeVariant.success,
            ),
            const SizedBox(height: 28),

            // Details Breakdown Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Category', transaction.category),
                  const SizedBox(height: 14),
                  _buildDetailRow('Paid with', transaction.paidWith),
                  const SizedBox(height: 14),
                  _buildDetailRow('Date & time', 'Sep 24, 2026 · 7:30 PM'),
                  const SizedBox(height: 14),
                  _buildDetailRow('Reference', transaction.reference),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Divider(color: AppColors.borderLight, height: 1),
                  ),
                  _buildDetailRow('Fee', '\$${transaction.fee.toStringAsFixed(2)}'),
                  const SizedBox(height: 14),
                  _buildDetailRow(
                    'Cashback earned',
                    '+\$${transaction.cashback.toStringAsFixed(2)}',
                    valueColor: AppColors.success,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Add receipt or note action card
            Material(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Attach receipt clicked')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.receipt_outlined,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add a receipt or note',
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Keep records for tax time',
                              style: AppTypography.captionRegular,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Report a problem button
            AppButton(
              text: 'Report a problem',
              variant: AppButtonVariant.danger,
              icon: const Icon(Icons.outlined_flag_rounded, color: AppColors.danger, size: 20),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Support team contacted.')),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterIcon() {
    if (transaction.initials != null) {
      return Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: transaction.avatarBg ?? AppColors.avatarBlue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            transaction.initials!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: transaction.avatarFg ?? AppColors.avatarBlueText,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: transaction.avatarBg ?? AppColors.avatarYellow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Icon(
          Icons.receipt_rounded,
          color: transaction.avatarFg ?? AppColors.avatarYellowText,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyRegular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
