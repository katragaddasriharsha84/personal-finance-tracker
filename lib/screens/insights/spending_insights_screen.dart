import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/pill_badge.dart';
import '../../state/app_state.dart';
import 'widgets/spending_donut_chart.dart';
import 'widgets/category_progress_row.dart';

class SpendingInsightsScreen extends StatefulWidget {
  final bool showBack;

  const SpendingInsightsScreen({super.key, this.showBack = false});

  @override
  State<SpendingInsightsScreen> createState() => _SpendingInsightsScreenState();
}

class _SpendingInsightsScreenState extends State<SpendingInsightsScreen> {
  int selectedPeriodIndex = 1; // 0: Week, 1: Month, 2: Year
  final List<String> periods = ['Week', 'Month', 'Year'];

  @override
  Widget build(BuildContext context) {
    final state = AppState();
    const totalSpent = 1842.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Insights',
        showBack: widget.showBack,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            // Period Segmented Tab
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: List.generate(periods.length, (index) {
                  final isSelected = selectedPeriodIndex == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedPeriodIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.surface : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            periods[index],
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Donut Chart Card
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'September 2026',
                        style: AppTypography.bodyLargeSemiBold.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const PillBadge(
                        text: '12% less than Aug',
                        variant: PillBadgeVariant.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  SpendingDonutChart(
                    categories: state.spendingCategories,
                    totalSpent: totalSpent,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Category Breakdown Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < state.spendingCategories.length; i++) ...[
                    CategoryProgressRow(category: state.spendingCategories[i]),
                    if (i < state.spendingCategories.length - 1)
                      const SizedBox(height: 18),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
