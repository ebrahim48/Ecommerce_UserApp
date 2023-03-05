import 'package:ecommerce_user_app13/providers/order_provider.dart';
import 'package:ecommerce_user_app13/utils/constants.dart';
import 'package:ecommerce_user_app13/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/order';
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getOrdersByUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) =>
        provider.orderList.isNotEmpty ? ListView.builder(
          itemCount: provider.orderList.length,
          itemBuilder: (context, index) {
            final orderM = provider.orderList[index];
            return ListTile(
              title: Text(getFormattedDateTime(orderM.orderDate.timestamp.toDate(), 'dd/MM/yyyy hh:mm:ss a')),
              subtitle: Text(orderM.orderStatus),
              trailing: Text('$currencySymbol${orderM.grandTotal.round()}'),
            );
          },
        ) : const Center(child: Text('You have no orders yet'),),
      ),
    );
  }
}
