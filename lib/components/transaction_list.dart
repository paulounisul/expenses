import 'package:expenses/components/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  // final f = NumberFormat('#,###.0#', 'pt_BR');

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma Transação Cadastrada!!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.60,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(
                key: GlobalObjectKey(
                    tr), //Funciona mais só usar quando for extremamente necessario pois pode custar caro na performasse.
                tr: tr,
                onRemove: onRemove,
              );
            },
            // children: transactions.map((tr) {}).toList(),
          );

    // ListView(
    //         children: transactions.map((tr) {
    //           return TransactionItem(
    //             key: ValueKey(tr.id),
    //             tr: tr,
    //             onRemove: onRemove,
    //           );
    //         }).toList(),
    //       );
  }
}
