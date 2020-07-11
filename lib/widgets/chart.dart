import 'package:expenses_manager/models/transation.dart';
import 'package:expenses_manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({@required this.recentTransactions});

  List<Map<String, Object>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double sum = 0;
      recentTransactions.forEach((element) {
        if (element.date.day == weekDay.day &&
            element.date.month == weekDay.month &&
            element.date.year == weekDay.year) sum += element.amount;
      });
      return {
        'label': DateFormat.E().format(weekDay),
        'amount': sum.toStringAsFixed(0),
      };
    });
  }

  double get _maxSpending {
    return _groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + double.parse(element["amount"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionValues.map((e) {
            var label = e["label"];
            var amount = double.parse(e["amount"]);
            var percentage =
                _maxSpending <= 0.0 ? 0.0 : (amount / _maxSpending);
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: label,
                amount: amount,
                percentage: percentage,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
