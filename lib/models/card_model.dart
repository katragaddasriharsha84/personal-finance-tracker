class CardModel {
  final String id;
  final String cardHolder;
  final String cardNumber;
  final String expiry;
  final String cvv;
  final String cardType;
  final bool isDefault;

  const CardModel({
    required this.id,
    required this.cardHolder,
    required this.cardNumber,
    required this.expiry,
    required this.cvv,
    this.cardType = 'VISA',
    this.isDefault = true,
  });

  String get maskedNumber {
    if (cardNumber.length >= 16) {
      final clean = cardNumber.replaceAll(' ', '');
      if (clean.length >= 16) {
        return '${clean.substring(0, 4)} ${clean.substring(4, 8)} ${clean.substring(8, 12)} ••••';
      }
    }
    return cardNumber;
  }

  String get last4 {
    final clean = cardNumber.replaceAll(' ', '');
    if (clean.length >= 4) {
      return clean.substring(clean.length - 4);
    }
    return '4821';
  }
}
