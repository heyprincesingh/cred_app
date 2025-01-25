String convertCurrencyIntoString(String currency) {
  if (currency.isEmpty || !RegExp(r'^\d+$').hasMatch(currency)) {
    return "Invalid number";
  }

  if (currency.length <= 3) {
    return currency;
  }

  String lastThree = currency.substring(currency.length - 3);
  String remaining = currency.substring(0, currency.length - 3);
  String reversedRemaining = remaining.split('').reversed.join();

  StringBuilder formatted = StringBuilder();
  int counter = 0;
  for (int i = 0; i < reversedRemaining.length; i++) {
    formatted.write(reversedRemaining[i]);
    counter++;
    if (counter % 2 == 0 && i != reversedRemaining.length - 1) {
      formatted.write(',');
    }
  }

  String formattedRemaining = formatted.toString().split('').reversed.join();

  return '₹ $formattedRemaining,$lastThree';
}

class StringBuilder {
  final _buffer = StringBuffer();

  void write(String str) {
    _buffer.write(str);
  }

  String toString() {
    return _buffer.toString();
  }
}
