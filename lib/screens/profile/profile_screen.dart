import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_button.dart';
import '../../state/app_state.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppState();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Profile', showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            // User Avatar & Name Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: const BoxDecoration(
                      color: AppColors.avatarPeach,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        state.userInitials,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppColors.avatarPeachText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    state.userName,
                    style: AppTypography.headingMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@arjun.mehta · Finora Verified',
                    style: AppTypography.captionRegular.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings Menu Groups
            _buildMenuGroup(
              title: 'Account',
              items: [
                _MenuItem(Icons.person_outline_rounded, 'Personal information'),
                _MenuItem(Icons.account_balance_outlined, 'Linked bank accounts'),
                _MenuItem(Icons.document_scanner_outlined, 'Tax documents'),
              ],
            ),
            const SizedBox(height: 18),

            _buildMenuGroup(
              title: 'Preferences & Security',
              items: [
                _MenuItem(Icons.security_outlined, 'Face ID & PIN security'),
                _MenuItem(Icons.notifications_none_rounded, 'Push notifications'),
                _MenuItem(Icons.language_rounded, 'App language & region'),
              ],
            ),
            const SizedBox(height: 18),

            _buildMenuGroup(
              title: 'Help & Legal',
              items: [
                _MenuItem(Icons.headset_mic_outlined, 'Customer support'),
                _MenuItem(Icons.policy_outlined, 'Terms and privacy policy'),
              ],
            ),
            const SizedBox(height: 32),

            // Log out Button
            AppButton(
              text: 'Log out',
              variant: AppButtonVariant.secondary,
              icon: const Icon(Icons.logout_rounded, size: 20, color: AppColors.danger),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGroup({required String title, required List<_MenuItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: AppTypography.captionMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                ListTile(
                  leading: Icon(items[i].icon, color: AppColors.textPrimary, size: 22),
                  title: Text(
                    items[i].title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onTap: () {},
                ),
                if (i < items.length - 1)
                  const Divider(height: 1, indent: 56, endIndent: 16, color: AppColors.borderLight),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;

  _MenuItem(this.icon, this.title);
}
