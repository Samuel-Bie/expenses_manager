import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });

  String get formatedDate {
    return DateFormat.yMMMMEEEEd().format(this.date);
  }
}
