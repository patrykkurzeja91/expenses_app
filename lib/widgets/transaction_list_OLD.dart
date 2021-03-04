import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/models/transaction.dart';

// class TransactionList extends StatefulWidget {
//   @override
//   _TransactionListState createState() => _TransactionListState();
// }

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'no transactions at this moment',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).primaryColorDark),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: Text(
                            '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Text(
                                transactions[index].title,
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Text(
                              DateFormat('dd MMMM yyyy')
                                  .format(transactions[index].date),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  elevation: 1,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
