extension FormatPhoneNumber on String{
  static const String _countryCode = "+20";

  String get formatPhoneNumber {
    String cleaned = replaceAll(RegExp(r'\D'), '');

    if (cleaned.startsWith('0'))
      cleaned = cleaned.substring(1);
    else if(cleaned.startsWith('2'))
      cleaned = cleaned.substring(2);

    return '$_countryCode$cleaned';
  }
}