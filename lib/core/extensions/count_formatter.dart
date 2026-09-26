extension CountFormatter on int{
  String get formatCount{
    if (this < 1000)
      return toString();

    if (this < 1000000)
      return '${(this / 1000).toStringAsFixed(1)}k';

    return '${(this / 1000000).toStringAsFixed(1)}M';
  }
}