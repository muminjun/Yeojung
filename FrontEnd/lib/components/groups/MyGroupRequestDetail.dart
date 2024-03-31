import 'package:flutter/material.dart';

class MyGroupRequestDetail extends StatelessWidget {
  final int transactionId;

  const MyGroupRequestDetail({Key? key, required this.transactionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyGroupRequestDetail'),
      ),
      body: Center(
        child: Text('Transaction ID: $transactionId'),
      ),
    );
  }
}
