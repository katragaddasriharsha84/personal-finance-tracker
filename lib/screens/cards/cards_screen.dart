import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_button.dart';
import '../../models/card_model.dart';
import '../../state/app_state.dart';
import 'add_card_screen.dart';

class CardsScreen extends StatefulWidget {
  final bool showBack;

  const CardsScreen({super.key, this.showBack = false});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  int _selectedCardIndex = 0;
  bool _isCardFrozen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'My Cards',
        showBack: widget.showBack,
        trailing: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            icon: const Icon(Icons.add_rounded, size: 22, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddCardScreen()),
              );
            },
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: AppState(),
        builder: (context, _) {
          final state = AppState();
          final cards = state.cards;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cards Carousel
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    itemCount: cards.length,
                    onPageChanged: (idx) => setState(() => _selectedCardIndex = idx),
                    itemBuilder: (ctx, idx) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: _buildCardItem(cards[idx], idx),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),

                // Indicator Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(cards.length, (idx) {
                    final isSelected = _selectedCardIndex == idx;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isSelected ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.border,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 28),

                // Quick Card Controls Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildControlButton(
                      icon: _isCardFrozen
                          ? Icons.lock_open_rounded
                          : Icons.ac_unit_rounded,
                      label: _isCardFrozen ? 'Unfreeze' : 'Freeze',
                      onTap: () {
                        setState(() => _isCardFrozen = !_isCardFrozen);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isCardFrozen
                                  ? 'Card frozen successfully'
                                  : 'Card un-frozen',
                            ),
                          ),
                        );
                      },
                    ),
                    _buildControlButton(
                      icon: Icons.speed_rounded,
                      label: 'Limits',
                      onTap: () => _showLimitDialog(context),
                    ),
                    _buildControlButton(
                      icon: Icons.pin_outlined,
                      label: 'Change PIN',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('PIN setup requested')),
                        );
                      },
                    ),
                    _buildControlButton(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Card Details Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Card Type', cards[_selectedCardIndex].cardType),
                      const SizedBox(height: 14),
                      _buildDetailRow(
                        'Card Status',
                        _isCardFrozen ? 'Frozen' : 'Active',
                        valueColor: _isCardFrozen ? AppColors.danger : AppColors.success,
                      ),
                      const SizedBox(height: 14),
                      _buildDetailRow('Online Payments', 'Enabled', valueColor: AppColors.success),
                      const SizedBox(height: 14),
                      _buildDetailRow('International Tx', 'Enabled', valueColor: AppColors.success),
                      const SizedBox(height: 14),
                      _buildDetailRow('Monthly Limit', '\$10,000 / \$2,350 used'),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Add New Card Button
                AppButton(
                  text: 'Add another card',
                  variant: AppButtonVariant.secondary,
                  icon: const Icon(Icons.add_rounded, size: 20, color: AppColors.textPrimary),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AddCardScreen()),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardItem(CardModel card, int index) {
    final isAlternate = index % 2 == 1;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isAlternate
              ? [const Color(0xFF1E1B4B), const Color(0xFF312E81)]
              : [const Color(0xFF5B4CF5), const Color(0xFF382AC8)],
        ),
        boxShadow: [
          BoxShadow(
            color: (isAlternate ? const Color(0xFF1E1B4B) : AppColors.primary).withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Finora',
                style: AppTypography.headingSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                card.cardType,
                style: AppTypography.headingMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Container(
            width: 42,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFBBF24),
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Color(0xFFFDE68A), Color(0xFFF59E0B)],
              ),
            ),
          ),
          Text(
            card.maskedNumber,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card.cardHolder,
                style: AppTypography.captionMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                card.expiry,
                style: AppTypography.captionMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: onTap,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Icon(icon, color: AppColors.textPrimary, size: 22),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.captionMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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

  void _showLimitDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Card Spending Limits', style: AppTypography.headingSmall),
            const SizedBox(height: 16),
            Text('Daily Limit: \$2,000.00', style: AppTypography.bodyMedium),
            const SizedBox(height: 8),
            Text('Monthly Limit: \$10,000.00', style: AppTypography.bodyMedium),
            const SizedBox(height: 24),
            AppButton(
              text: 'Save Limits',
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }
}
