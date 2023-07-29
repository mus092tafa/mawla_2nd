import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../Models/transac.dart';

class Tlist extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final List<Transac> Transactions;
  final Function deletetx;

  // ignore: use_key_in_widget_constructors
  const Tlist(this.Transactions,this.deletetx);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 600,
        child: Transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No Transactions Added',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/image/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                              '\$${Transactions[index].amount}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        Transactions[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(Transactions[index].date)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: ()=> deletetx(Transactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: Transactions.length,
              ));
  }
}
                  // Card(
                  //     child: Row(
                  //   children: [
                  //     Container(
                  //         padding: const EdgeInsets.all(5),
                  //         margin: const EdgeInsets.symmetric(
                  //             vertical: 10, horizontal: 15),
                  //         decoration:  BoxDecoration(
                  //           borderRadius: BorderRadius.all(Radius.circular(5)),
                  //           shape: BoxShape.rectangle,
                  //           color: Theme.of(context).primaryColor,
                  //         ),
                  //         child: Text(
                  //           '\$ ${tx.amount.toStringAsFixed(2)}',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 16),
                  //         )),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           Transactions[index].title,
                  //           style: const TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //         Text(
                  //           DateFormat('yyyy-MM-dd')
                  //               .format(Transactions[index].date),
                  //           style: const TextStyle(
                  //               fontSize: 12, color: Colors.grey),
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // ))

