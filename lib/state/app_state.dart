import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../models/contact_model.dart';
import '../models/card_model.dart';
import '../models/spending_category_model.dart';
import '../core/theme/app_colors.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal() {
    _initMockData();
  }

  // User Profile
  String userName = 'Arjun Mehta';
  String userInitials = 'AM';
  String greeting = 'Good morning';

  // Balance & Wallet
  double totalBalance = 24562.80;
  bool isBalanceVisible = true;
  String balanceGrowthText = '↑ 2.4% vs last month';
  String defaultWalletName = 'Wallet •••• 4821';

  // State Lists
  List<TransactionModel> transactions = [];
  List<ContactModel> contacts = [];
  List<CardModel> cards = [];
  List<SpendingCategoryModel> spendingCategories = [];

  void toggleBalanceVisibility() {
    isBalanceVisible = !isBalanceVisible;
    notifyListeners();
  }

  void addTransaction(TransactionModel transaction) {
    transactions.insert(0, transaction);
    if (transaction.isIncome) {
      totalBalance += transaction.amount;
    } else {
      totalBalance -= transaction.amount;
    }
    notifyListeners();
  }

  void addCard(CardModel card) {
    cards.insert(0, card);
    notifyListeners();
  }

  void _initMockData() {
    transactions = [
      const TransactionModel(
        id: 'tx_1',
        title: 'Riya Kapoor',
        category: 'Transfer',
        dateGroup: 'TODAY',
        timestamp: 'Transfer · Today, 9:12 AM',
        amount: 250.00,
        isIncome: false,
        iconType: TransactionIconType.initials,
        initials: 'RK',
        avatarBg: AppColors.avatarBlue,
        avatarFg: AppColors.avatarBlueText,
        reference: 'FNR-8Q2K-41X7',
        fee: 0.00,
        cashback: 0.00,
      ),
      const TransactionModel(
        id: 'tx_2',
        title: 'Acme Corp',
        category: 'Salary',
        dateGroup: 'YESTERDAY',
        timestamp: 'Salary · Yesterday',
        amount: 4200.00,
        isIncome: true,
        iconType: TransactionIconType.salary,
        avatarBg: AppColors.avatarGreen,
        avatarFg: AppColors.avatarGreenText,
        reference: 'FNR-9A1B-33CC',
        fee: 0.00,
        cashback: 12.50,
      ),
      const TransactionModel(
        id: 'tx_3',
        title: 'City Power & Light',
        category: 'Utilities',
        dateGroup: 'SEP 24',
        timestamp: 'Bill payment · Sep 24',
        amount: 86.40,
        isIncome: false,
        iconType: TransactionIconType.bill,
        avatarBg: AppColors.avatarYellow,
        avatarFg: AppColors.avatarYellowText,
        reference: 'FNR-2L9D-77QA',
        fee: 0.00,
        cashback: 0.86,
      ),
      const TransactionModel(
        id: 'tx_4',
        title: 'Brew & Co.',
        category: 'Food & drink',
        dateGroup: 'TODAY',
        timestamp: 'Food & drink · 8:05 AM',
        amount: 6.80,
        isIncome: false,
        iconType: TransactionIconType.coffee,
        avatarBg: AppColors.avatarYellow,
        avatarFg: AppColors.avatarYellowText,
        reference: 'FNR-1C8E-90PW',
        fee: 0.00,
        cashback: 0.07,
      ),
      const TransactionModel(
        id: 'tx_5',
        title: 'Green Basket Market',
        category: 'Groceries',
        dateGroup: 'YESTERDAY',
        timestamp: 'Groceries · 5:42 PM',
        amount: 74.15,
        isIncome: false,
        iconType: TransactionIconType.grocery,
        avatarBg: AppColors.avatarPink,
        avatarFg: AppColors.avatarPinkText,
        reference: 'FNR-5T4X-12MN',
        fee: 0.00,
        cashback: 1.48,
      ),
      const TransactionModel(
        id: 'tx_6',
        title: 'City Cabs',
        category: 'Transport',
        dateGroup: 'YESTERDAY',
        timestamp: 'Transport · 1:10 PM',
        amount: 18.40,
        isIncome: false,
        iconType: TransactionIconType.transport,
        avatarBg: AppColors.avatarBlue,
        avatarFg: AppColors.avatarBlueText,
        reference: 'FNR-7U2H-88KL',
        fee: 0.00,
        cashback: 0.37,
      ),
    ];

    contacts = [
      const ContactModel(
        id: 'c_1',
        name: 'Riya Kapoor',
        handle: '@riya.k · Finora',
        bankOrPhone: '@riya.k · Finora',
        initials: 'RK',
        avatarBg: AppColors.avatarBlue,
        avatarFg: AppColors.avatarBlueText,
      ),
      const ContactModel(
        id: 'c_2',
        name: 'Sam Jordan',
        handle: 'Chase •••• 2210',
        bankOrPhone: 'Chase •••• 2210',
        initials: 'SJ',
        avatarBg: AppColors.avatarGreen,
        avatarFg: AppColors.avatarGreenText,
      ),
      const ContactModel(
        id: 'c_3',
        name: 'Leah Martin',
        handle: '@leahm · Finora',
        bankOrPhone: '@leahm · Finora',
        initials: 'LM',
        avatarBg: AppColors.avatarPink,
        avatarFg: AppColors.avatarPinkText,
      ),
      const ContactModel(
        id: 'c_4',
        name: 'Dev Patel',
        handle: '+1 (628) 555-0190',
        bankOrPhone: '+1 (628) 555-0190',
        initials: 'DP',
        avatarBg: AppColors.avatarYellow,
        avatarFg: AppColors.avatarYellowText,
      ),
      const ContactModel(
        id: 'c_5',
        name: 'Noah Okafor',
        handle: 'Wells Fargo •••• 7731',
        bankOrPhone: 'Wells Fargo •••• 7731',
        initials: 'NO',
        avatarBg: Color(0xFFEDE9FE),
        avatarFg: Color(0xFF6D28D9),
      ),
    ];

    cards = [
      const CardModel(
        id: 'card_1',
        cardHolder: 'ARJUN MEHTA',
        cardNumber: '4821 5530 1976 4821',
        expiry: '09/28',
        cvv: '832',
        cardType: 'VISA',
        isDefault: true,
      ),
      const CardModel(
        id: 'card_2',
        cardHolder: 'ARJUN MEHTA',
        cardNumber: '5241 8920 3341 9012',
        expiry: '11/27',
        cvv: '451',
        cardType: 'MASTERCARD',
        isDefault: false,
      ),
    ];

    spendingCategories = const [
      SpendingCategoryModel(
        name: 'Housing & bills',
        amount: 663,
        percentage: 0.36,
        color: AppColors.categoryHousing,
      ),
      SpendingCategoryModel(
        name: 'Groceries',
        amount: 405,
        percentage: 0.22,
        color: AppColors.categoryGroceries,
      ),
      SpendingCategoryModel(
        name: 'Food & drink',
        amount: 332,
        percentage: 0.18,
        color: AppColors.categoryFood,
      ),
      SpendingCategoryModel(
        name: 'Transport',
        amount: 258,
        percentage: 0.14,
        color: AppColors.categoryTransport,
      ),
      SpendingCategoryModel(
        name: 'Other',
        amount: 184,
        percentage: 0.10,
        color: AppColors.categoryOther,
      ),
    ];
  }
}
