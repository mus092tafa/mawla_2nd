import 'package:flutter/material.dart';
import 'package:mawla_2nd/widgets/chart.dart';
import 'package:mawla_2nd/widgets/transac_list.dart';
import './widgets/new_trans.dart';
import 'widgets/transac_list.dart';
import './Models/transac.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        secondaryHeaderColor: Colors.white,
        textTheme: TextTheme(
            //--------------------------------titles
            titleSmall: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 12,
                fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            labelSmall: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        //---------------------------------Colors
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        fontFamily: 'Quicksand',

        // appBarTheme: AppBarTheme(
        //     toolbarTextStyle: ThemeData.dark().textTheme.copyWith(bodyMedium: const TextStyle(
        //             fontFamily: 'OpenSans',
        //             fontSize: 100,)).bodyMedium, titleTextStyle: ThemeData.light().textTheme.copyWith(bodyMedium: TextStyle(
        //             fontFamily: 'OpenSans',
        //             fontSize: 100,)).titleLarge)
      ),
      title: 'Dump purchases',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // -------------------------------------------------Transactions

  final List<Transac> _Utrans = [
    // Transac(id: 'a1', title: 'shoes', amount: 30.99, date: DateTime.now()),
    // Transac(id: 'a2', title: 'Grocry', amount: 15.99, date: DateTime.now())
  ];
  List<Transac> get _recentTransactions {
    return _Utrans.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewtx(String txtitle, double txamount, DateTime chosenDate) {
    final newtx = Transac(
      id: DateTime.now().toString(),
      title: txtitle,
      amount: txamount,
      date: chosenDate,
    );

    setState(() {
      _Utrans.add(newtx);
    });
  }

  void _startAddNewTx(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTrans(_addNewtx));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _Utrans.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      actions: [
        IconButton(
            onPressed: () => _startAddNewTx(context), icon: Icon(Icons.add))
      ],
      title: Text(
        'rami m6e',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          //---------------------------------------------Chart
          Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTransactions)),
          //---------------------------------------------transactions card
          Container(height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7, child: Tlist(_Utrans, _deleteTransaction))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () => _startAddNewTx(context)),
    );
  }
}
