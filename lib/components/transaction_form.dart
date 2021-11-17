
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionFrom extends StatefulWidget {
  final void Function(String title, double value, DateTime date) onSubmit;

 TransactionFrom(this.onSubmit);

  @override
  _TransactionFromState createState() => _TransactionFromState();
}

class _TransactionFromState extends State<TransactionFrom> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
   DateTime _selectDate = DateTime.now();

_submitForm(){

   final title = _titleController.text;
   final value = double.tryParse(_valueController.text)?? 0.0;

  if(title.isEmpty || value <= 0.0){
    return;
  }

   widget.onSubmit(title, value, _selectDate);
}



_showDatePicker(){
  showDatePicker(context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2019),
  lastDate: DateTime.now(),
).then((datePiker) {
    if(datePiker == null){
      return;
    }

      setState(() {
         _selectDate = datePiker;
      });
   
});
}

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
                elevation: 5,
                child: Padding(
                  padding:  EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 10 + MediaQuery.of(context).viewInsets.bottom
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                         onSubmitted: (_) => _submitForm(),
                        decoration: InputDecoration(
                          labelText: 'Titulo'
                        ),
                      ),
                      TextField(
                        controller: _valueController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        onSubmitted: (_) => _submitForm(),
                        decoration: InputDecoration(
                          labelText: 'valor'
                        ),
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text( _selectDate == null ? 'Nenhuma data selecionada!' :
                                                         'Data selecionada: ${DateFormat('d/M/y').format(_selectDate)}' 
                              ),
                            ),
                            FlatButton(
                              onPressed: _showDatePicker, 
                              child: Text('Selecionar Data',
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 ),
                              ),
                               textColor: Theme.of(context).primaryColor
                               ,)
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(onPressed: _submitForm
                          , 
                          child: Text('Nova transação'),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white ,
                          ),
                        ],
                      )
                    ],
                  ),
    
                ),
              ),
    );
  }
}