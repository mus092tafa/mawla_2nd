import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  // ignore: non_constant_identifier_names
  final double SpendingPctTotal;

  const ChartBar(this.label, this.spendingAmount, this.SpendingPctTotal, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 60,
          width: 20,
          child: Stack(
            children: [
              Container(alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                alignment: AlignmentDirectional.bottomCenter,
                heightFactor: SpendingPctTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(label),
      ],
    );
  }
}
