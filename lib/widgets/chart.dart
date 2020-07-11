import 'package:expenses_manager/models/transation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({@required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0;
      recentTransactions.forEach((element) {
        if (element.date.day == weekDay.day &&
            element.date.month == weekDay.month &&
            element.date.year == weekDay.year) sum += element.amount;
      });
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': sum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((e) {
          return Text(e["day"]);
        }).toList(),
      ),
    );
  }
}
