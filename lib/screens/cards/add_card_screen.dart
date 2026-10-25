import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../models/card_model.dart';
import '../../state/app_state.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Arjun Mehta');
  final TextEditingController _numberController = TextEditingController(text: '4821 5530 1976 4821');
  final TextEditingController _expiryController = TextEditingController(text: '09/28');
  final TextEditingController _cvvController = TextEditingController(text: '832');
  bool _isDefault = true;

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Add a card',
        trailing: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: IconButton(
            icon: const Icon(Icons.crop_free_rounded, size: 20, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Card scanner opened')),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Card Preview
            _buildCardPreview(),
            const SizedBox(height: 28),

            // Cardholder name field
            AppTextField(
              label: 'Cardholder name',
              controller: _nameController,
              hint: 'e.g. Arjun Mehta',
              prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.textSecondary),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 18),

            // Card number field
            AppTextField(
              label: 'Card number',
              controller: _numberController,
              hint: '0000 0000 0000 0000',
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.credit_card_rounded, color: AppColors.textSecondary),
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'VISA',
                  style: AppTypography.bodyLargeSemiBold.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 18),

            // Expiry & CVV Row
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'Expiry date',
                    controller: _expiryController,
                    hint: 'MM / YY',
                    keyboardType: TextInputType.datetime,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: AppTextField(
                    label: 'CVV',
                    controller: _cvvController,
                    hint: '•••',
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    suffixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary, size: 20),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Set as default payment card switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Set as default payment card',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Switch(
                  value: _isDefault,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _isDefault = val),
                ),
              ],
            ),
            const SizedBox(height: 36),

            // Submit Button
            AppButton(
              text: 'Add card',
              onPressed: () {
                final newCard = CardModel(
                  id: 'card_${DateTime.now().millisecondsSinceEpoch}',
                  cardHolder: _nameController.text.toUpperCase(),
                  cardNumber: _numberController.text,
                  expiry: _expiryController.text,
                  cvv: _cvvController.text,
                  isDefault: _isDefault,
                );
                AppState().addCard(newCard);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Card added successfully!')),
                );
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    final holder = _nameController.text.trim().isEmpty
        ? 'ARJUN MEHTA'
        : _nameController.text.toUpperCase();
    final number = _numberController.text.trim().isEmpty
        ? '4821 5530 1976 ••••'
        : _numberController.text;
    final expiry = _expiryController.text.trim().isEmpty
        ? 'MM/YY'
        : _expiryController.text;

    return Container(
      width: double.infinity,
      height: 215,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5B4CF5),
            Color(0xFF382AC8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.32),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Finora Brand & VISA logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Finora',
                style: AppTypography.headingSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'VISA',
                style: AppTypography.headingMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          // Metallic Chip
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

          // Card Number
          Text(
            number,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),

          // Holder & Expiry
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                holder,
                style: AppTypography.captionMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                expiry,
                style: AppTypography.captionMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
