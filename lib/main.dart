

import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';


main () => runApp(ExpensesApp());

class  ExpensesApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),  
          button: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
        appBarTheme: AppBarTheme(
          textTheme:ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold

          ),
        ),
        ),
      ),
    );
  }
}


  class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


   final List<Transaction> transactions = [];
   bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return transactions.where((tr){
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)
        ));
    }).toList();
  }

_addTransaction(String title, double value, DateTime date){
    Transaction newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date);

      setState(() {
        transactions.add(newTransaction); 
      });

      Navigator.of(context).pop();
  }


_removeTransaction(String id){
  setState(() {
     transactions.removeWhere((tr) => tr.id == id);
  });
 
}


  _openTransactionFormModal(BuildContext context){

    showModalBottomSheet(
      context: context, 
      builder:(_) {
        return TransactionFrom(_addTransaction);
      });
    
  }

    @override
    Widget build(BuildContext context) {
        final  mediaQuery =  MediaQuery.of(context);
        bool isLandscape =  mediaQuery.orientation == Orientation.landscape;

      final Appbar = AppBar(title: Text('Depesas'),
        actions: [
          IconButton(onPressed: () => _openTransactionFormModal(context),
           icon: Icon(Icons.add),
           ),
           IconButton(
             onPressed: (){
               setState(() {
                 _showChart = !_showChart;
               });
             },
           icon: Icon(_showChart ? Icons.list: Icons.pie_chart),
           ),

        ],
        );

      final availabeleHeight = mediaQuery.size.height
                              - Appbar.preferredSize.height - mediaQuery.padding.top;

      return Scaffold(
        appBar: Appbar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            /*if(isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Exibir Gráfico'),
                  Switch(value: _showChart,
                   onChanged: (value){
                     setState(() {
                       _showChart = value;
                     });
                   })

                ],
              ),*/
              if(_showChart || !isLandscape)Container(
                height: availabeleHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(_recentTransactions),
              ),
              if(!_showChart || !isLandscape)Container(
                height:  availabeleHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(transactions, _removeTransaction)
                ,),
            
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
}