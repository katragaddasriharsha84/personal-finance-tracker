import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/transaction_tile.dart';
import '../../models/transaction_model.dart';
import '../../state/app_state.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  final List<String> filters = ['All', 'Income', 'Expenses', 'Transfers'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Transactions',
        trailing: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: const Center(
            child: Icon(
              Icons.tune_rounded,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: AppState(),
        builder: (context, _) {
          final state = AppState();
          final query = _searchController.text.toLowerCase();

          // Filter by tab and search
          final filtered = state.transactions.where((tx) {
            final matchesSearch = tx.title.toLowerCase().contains(query) ||
                tx.category.toLowerCase().contains(query);
            if (!matchesSearch) return false;

            if (selectedFilter == 'Income') return tx.isIncome;
            if (selectedFilter == 'Expenses') return !tx.isIncome;
            if (selectedFilter == 'Transfers') {
              return tx.category.toLowerCase().contains('transfer');
            }
            return true;
          }).toList();

          final todayList = filtered.where((tx) => tx.dateGroup == 'TODAY').toList();
          final yesterdayList = filtered.where((tx) => tx.dateGroup == 'YESTERDAY').toList();
          final otherList = filtered
              .where((tx) => tx.dateGroup != 'TODAY' && tx.dateGroup != 'YESTERDAY')
              .toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Field
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search transactions',
                      hintStyle: AppTypography.bodyRegular.copyWith(color: AppColors.textMuted),
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      final isSelected = selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.textPrimary : AppColors.surface,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isSelected ? AppColors.textPrimary : AppColors.border,
                              ),
                            ),
                            child: Text(
                              filter,
                              style: AppTypography.bodyMedium.copyWith(
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 18),

                // Income / Spent Summary Row
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        title: 'Income',
                        amount: '+\$4,200.00',
                        icon: Icons.south_west_rounded,
                        iconBg: AppColors.avatarGreen,
                        iconFg: AppColors.avatarGreenText,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildSummaryCard(
                        title: 'Spent',
                        amount: '−\$1,842.30',
                        icon: Icons.north_east_rounded,
                        iconBg: AppColors.dangerLight,
                        iconFg: AppColors.danger,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // TODAY Section
                if (todayList.isNotEmpty) ...[
                  Text(
                    'TODAY',
                    style: AppTypography.captionMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTransactionGroup(todayList),
                  const SizedBox(height: 20),
                ],

                // YESTERDAY Section
                if (yesterdayList.isNotEmpty) ...[
                  Text(
                    'YESTERDAY',
                    style: AppTypography.captionMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTransactionGroup(yesterdayList),
                  const SizedBox(height: 20),
                ],

                // Other Section
                if (otherList.isNotEmpty) ...[
                  Text(
                    'EARLIER',
                    style: AppTypography.captionMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTransactionGroup(otherList),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color iconBg,
    required Color iconFg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconFg, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.captionRegular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  amount,
                  style: AppTypography.bodyLargeSemiBold.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionGroup(List<TransactionModel> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            TransactionTile(transaction: items[i]),
            if (i < items.length - 1)
              const Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: AppColors.borderLight,
              ),
          ],
        ],
      ),
    );
  }
}
