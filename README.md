# Finora — Banking & Expense Tracker Mobile Application

A Flutter application converted from the **Finora — Banking & Expense Tracker Mobile App UI Kit** in Figma.

---

## 📱 Converted Figma Screens

All screens have been extracted and mapped to Flutter widgets:

| Screen Name | Figma Frame ID | Flutter Implementation | Asset Preview |
| :--- | :--- | :--- | :--- |
| **01 — Onboarding** | `2:49` | `lib/screens/onboarding/onboarding_screen.dart` | [09_onboarding.png](assets/images/09_onboarding.png) |
| **02 — Log in** | `3:418` | `lib/screens/auth/login_screen.dart` | [10_login.png](assets/images/10_login.png) |
| **03 — Home / Dashboard** | `4:130` | `lib/screens/home/home_screen.dart` | [01_home_screen.png](assets/images/01_home_screen.png) |
| **04 — Transactions History** | `6:5` | `lib/screens/transactions/transaction_history_screen.dart` | [02_transaction_history.png](assets/images/02_transaction_history.png) |
| **05 — Transaction Details** | `6:87` | `lib/screens/transactions/transaction_details_screen.dart` | [03_transaction_details.png](assets/images/03_transaction_details.png) |
| **06 — Spending Insights** | `6:142` | `lib/screens/insights/spending_insights_screen.dart` | [04_spending_insights.png](assets/images/04_spending_insights.png) |
| **07 — My Cards** | `4:2` | `lib/screens/cards/cards_screen.dart` | [05_add_card.png](assets/images/05_add_card.png) |
| **08 — Add Card** | `4:5` | `lib/screens/cards/add_card_screen.dart` | [05_add_card.png](assets/images/05_add_card.png) |
| **09 — Send Money (Recipient)** | `4:293` | `lib/screens/send/send_recipient_screen.dart` | [06_send_choose_recipient.png](assets/images/06_send_choose_recipient.png) |
| **10 — Send Money (Amount)** | `4:374` | `lib/screens/send/send_amount_screen.dart` | [07_send_enter_amount.png](assets/images/07_send_enter_amount.png) |
| **11 — Send Money (Success)** | `4:496` | `lib/screens/send/send_success_screen.dart` | [08_send_success.png](assets/images/08_send_success.png) |
| **12 — Profile & Settings** | `5:368` | `lib/screens/profile/profile_screen.dart` | Built-in |

---

## 🎨 Design System Tokens

Extracted from the **Finora Design System** (`7:237`):

### 1. Color Palette (`lib/core/theme/app_colors.dart`)
* **Brand Primary:** `#5B4CF5` (Royal Indigo Violet)
* **Brand Dark / Gradient:** `#3F31D6` / `#382AC8`
* **Brand Light:** `#EEECFF`
* **Background:** `#F6F7FB`
* **Surface Cards:** `#FFFFFF`
* **Text Primary:** `#141432`
* **Text Secondary:** `#6B6F8A`
* **Text Muted:** `#9DA3B4`
* **Border:** `#E4E6F0`
* **Success / Income:** `#16A34A` / `#DCFCE7`
* **Expense / Danger:** `#EF4444` / `#FEE2E2`
* **Warning:** `#F59E0B` / `#FEF3C7`

### 2. Typography (`lib/core/theme/app_typography.dart`)
* **Font Family:** `Inter` (via `google_fonts`)
* Sizes: 32px (Display), 24px (Heading Lg), 20px (Heading Md), 16px (Body SemiBold), 14px (Body), 12px (Caption)

---

## 🚀 Key Interactive Features

1. **Interactive Dashboard**:
   - Live balance toggle with eye icon (shows/masks balance `••••••••`).
   - Quick action shortcuts (Send, Receive QR modal, Top Up card, Pay Bills modal).
   - Recent activity list with status indicators and tap-to-view receipt.

2. **Real-Time Money Transfer Flow**:
   - Choose contact from recents or searchable contacts.
   - Enter amount with preset quick chips (`$50`, `$100`, `$250`, `$500`) and custom in-app numeric keypad.
   - Live balance deduction and instant receipt generation with shareable transaction ID.

3. **Custom Donut Spending Chart**:
   - Custom `CustomPainter` rendering smooth curved arcs for categories (Housing 36%, Groceries 22%, Food 18%, Transport 14%, Other 10%).
   - Dynamic period tabs (Week / Month / Year).

4. **Live Card Preview & Addition**:
   - Live interactive card preview as cardholder details and numbers are typed.
   - Multi-card carousel with Freeze / Unfreeze controls and spending limit modals.

---

## 🛠️ How to Run the App

1. Ensure Flutter 3.x+ is installed on your computer.
2. In the project directory, install dependencies:
   ```bash
   flutter pub get
   ```
3. Run on your connected device, emulator, or Chrome:
   ```bash
   flutter run
   ```
