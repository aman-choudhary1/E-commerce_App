import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_app/modals/cart.dart';
import 'package:new_flutter_app/widgets/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import '../core/store.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.color(context.theme.accentColor).center.make(),
      ),
      body: Column(
        children: [
          _cartList().p32().expand(),
          Divider(),
          _cartTotal(),
        ],
      ),
    );
  }
}

class _cartTotal extends StatelessWidget {
  const _cartTotal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartModal _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VxBuilder(
            builder: (context, _) {
              return "\$${_cart.totalPrice}".text.bold.xl3.red700.make();
            },
            mutations: {RemoveMutation},
          ),
          ElevatedButton(
            onPressed: () async {
              await launch("https://rzp.io/l/9mKr1eSO");
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(context.theme.buttonColor),
              shape: MaterialStateProperty.all(
                StadiumBorder(),
              ),
            ),
            child: "Check out".text.make(),
          ).wh(120, 48)
        ],
      ),
    ).px16();
  }
}

class _cartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.listen(context, to: [RemoveMutation]);
    final CartModal _cart = (VxState.store as MyStore).cart;
    return _cart.items.isEmpty
        ? "Hey, it feels so light".text.xl3.makeCentered()
        : ListView.builder(
            itemCount: _cart.items.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: Icon(Icons.done),
                trailing: IconButton(
                  icon: Icon(CupertinoIcons.cart_fill_badge_minus,
                      color: Vx.red700),
                  onPressed: () => RemoveMutation(_cart.items[index]),
                  // setState(() {});
                ),
                title: _cart.items[index].name.text.make(),
              ),
            ),
          );
  }
}
