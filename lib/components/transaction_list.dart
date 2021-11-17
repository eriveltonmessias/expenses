import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {


final List<Transaction> transactions;
final void Function(String) removeTransaction;

TransactionList(this.transactions, this.removeTransaction);



  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ?
    LayoutBuilder(builder: (context, constraints){
       return Column(
      children: [
         SizedBox(height:20),
        Text('Nenhuma Transação Cadastrada!',
        style: Theme.of(context).textTheme.headline6
        ),
        SizedBox(height: 20),
        Container(
          height: constraints.maxHeight * 0.6,
          child: Image.asset('assets/images/waiting.png',
          fit: BoxFit.cover,
          ),
          
        )
      ],
    );
    },
    ):
     ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index){
        final tr = transactions[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 5,
          ),
              child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${tr.value}'),
                        ) 
                    ,),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date)
                  ), 
                  trailing: MediaQuery.of(context).size.width > 480 ?
                  FlatButton.icon(
                  onPressed: () => removeTransaction(tr.id), 
                  icon:  Icon(Icons.delete),
                  label: Text('Excluir'),
                   textColor: Theme.of(context).errorColor,)
                   :IconButton(
                   onPressed: () => removeTransaction(tr.id),
                   color: Theme.of(context).errorColor,
                   icon: Icon(Icons.delete)
                   )
                    ,

                ),
                
            );
      },
    );
  }
}