import 'package:ecommerce_user_app13/pages/checkout_page.dart';
import 'package:ecommerce_user_app13/providers/cart_provider.dart';
import 'package:ecommerce_user_app13/utils/constants.dart';
import 'package:ecommerce_user_app13/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/cart';

  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear items',
            onPressed: () {},
          )
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, provider, child) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.cartList.length,
                itemBuilder: (context, index) {
                  final cartM = provider.cartList[index];
                  return CartItem(
                    cartModel: cartM,
                    priceWithQuantity: provider.itemPriceWithQuantity(cartM),
                    onIncrease: () {
                      provider.increaseQuantity(cartM);
                    },
                    onDecrease: () {
                      provider.decreaseQuantity(cartM);
                    },
                    onDelete: () {
                      provider.removeFromCart(cartM.productId!);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                color: Colors.grey.shade300,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Subtotal: $currencySymbol${provider.getCartSubtotal()}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed:
                        provider.totalItemsInCart == 0 ?
                        null : () => Navigator.pushNamed(context, CheckoutPage.routeName),
                        child: const Text('Checkout'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
