import 'package:intl/intl.dart';

class Helper {
  static int calculatePercentage(int obtained, int total) => obtained * 100 ~/ total;

  static String formatNumber(int number) {
    var f = new NumberFormat("###,###", "en_US");
    return f.format(number);
  }
}