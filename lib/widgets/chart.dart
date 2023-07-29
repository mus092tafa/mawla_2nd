import 'package:flutter/material.dart';
import '../Models/transac.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transac> recentTransactions;

  const Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get groupedTransactionsVlaue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalsum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum
      };
    });
  }
//--------------------------------------the same as using loop for specific index
  double get totalSpending {
    return groupedTransactionsVlaue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }


//-----------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...groupedTransactionsVlaue.map((data) {
                
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'] as String,
                      data['amount'] as double,
                      totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending),
                );
              }).toList(),
            ],
          ),
        ));
  }
}
