import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_button.dart';
import '../../models/contact_model.dart';
import '../../models/transaction_model.dart';
import '../../state/app_state.dart';
import 'send_success_screen.dart';

class SendAmountScreen extends StatefulWidget {
  final ContactModel contact;

  const SendAmountScreen({
    super.key,
    required this.contact,
  });

  @override
  State<SendAmountScreen> createState() => _SendAmountScreenState();
}

class _SendAmountScreenState extends State<SendAmountScreen> {
  String _amountStr = '250';
  final TextEditingController _noteController = TextEditingController(text: 'Dinner split 🍝');
  final List<String> presetAmounts = ['50', '100', '250', '500'];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onKeypadTap(String key) {
    setState(() {
      if (key == 'backspace') {
        if (_amountStr.isNotEmpty) {
          _amountStr = _amountStr.substring(0, _amountStr.length - 1);
          if (_amountStr.isEmpty) _amountStr = '0';
        }
      } else if (key == '.') {
        if (!_amountStr.contains('.')) {
          _amountStr += '.';
        }
      } else {
        if (_amountStr == '0') {
          _amountStr = key;
        } else {
          _amountStr += key;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = AppState();
    final amountVal = double.tryParse(_amountStr) ?? 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Send money'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                children: [
                  // Recipient Header Card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: widget.contact.avatarBg,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              widget.contact.initials,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: widget.contact.avatarFg,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.contact.name,
                                style: AppTypography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.contact.handle,
                                style: AppTypography.captionRegular.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Change',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Big Amount Display
                  Text(
                    '\$$_amountStr',
                    style: AppTypography.displayLarge.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Available Balance
                  Text(
                    'Available balance: \$${state.totalBalance.toStringAsFixed(2).replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (m) => '${m[1]},',
                        )}',
                    style: AppTypography.captionRegular.copyWith(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Preset Amount Chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: presetAmounts.map((p) {
                      final isSelected = _amountStr == p;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: GestureDetector(
                            onTap: () => setState(() => _amountStr = p),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primaryLight : AppColors.surface,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : AppColors.border,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '\$$p',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: isSelected ? AppColors.primary : AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Note input
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: TextField(
                      controller: _noteController,
                      style: AppTypography.bodyMedium,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.receipt_outlined, color: AppColors.textSecondary),
                        hintText: 'Add a note (optional)',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // In-App Keypad
                  _buildKeypad(),
                ],
              ),
            ),
          ),

          // Bottom Action
          Padding(
            padding: const EdgeInsets.all(20),
            child: AppButton(
              text: 'Continue',
              onPressed: amountVal <= 0
                  ? null
                  : () {
                      final newTx = TransactionModel(
                        id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
                        title: widget.contact.name,
                        category: 'Transfer',
                        dateGroup: 'TODAY',
                        timestamp: 'Transfer · Today, just now',
                        amount: amountVal,
                        isIncome: false,
                        iconType: TransactionIconType.initials,
                        initials: widget.contact.initials,
                        avatarBg: widget.contact.avatarBg,
                        avatarFg: widget.contact.avatarFg,
                        reference: 'FNR-8Q2K-${DateTime.now().millisecond}',
                      );
                      state.addTransaction(newTx);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => SendSuccessScreen(
                            contact: widget.contact,
                            amount: amountVal,
                            transactionId: newTx.reference,
                          ),
                        ),
                      );
                    },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypad() {
    final keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', 'backspace'],
    ];

    return Column(
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((key) {
            return InkResponse(
              onTap: () => _onKeypadTap(key),
              radius: 36,
              child: Container(
                width: 76,
                height: 52,
                alignment: Alignment.center,
                child: key == 'backspace'
                    ? const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary)
                    : Text(
                        key,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
