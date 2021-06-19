import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final double value;
  final String label;
  final double percentage;

  final f = NumberFormat('#,###.0#', 'pt_BR');

  //construtor com parametros nomeados.
  ChartBar({
    this.label,
    this.value,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('${value.toStringAsFixed(2)}'),
                //'${value.remainder(value).isNaN ? '0' : value.toStringAsFixed(2)}'),
                // '${(value.remainder(value).isN == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2))}'),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.55,
              width: 10,
              //Stack serve para agrupar compentes, parecido com Row e Col..
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            //Text(label),
            Container(
              height: constraints.maxHeight * 0.20,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
