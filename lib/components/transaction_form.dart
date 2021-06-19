import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    //temos acesso ao widget por herança.
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      //aqui também temos acesso ao context por herança.
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              //usar o controller melhor forma mais ainda não é a ideal.
              //onChanged: (newValue) => value = newValue,
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              // _ ignora o parametro passado na função.
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor R\S',
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data Selecionada...!!!'
                          : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    //focusColor: Color.blue;
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Selecionar data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  child: Text('Nova Transação'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitForm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
