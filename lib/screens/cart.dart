import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';
import '../providers/cart.dart' show Cart;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map cartItems = {};

  @override
  Widget build(BuildContext context) {
    cartItems = Provider.of<Cart>(context).items;
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: cartItems.isEmpty
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://i.pinimg.com/originals/2e/ac/fa/2eacfa305d7715bdcd86bb4956209038.png'),
                              fit: BoxFit.cover),
                        ),
                      )
                    ],
                  ),
                )
              : Consumer<Cart>(
                  builder: (context, child, value) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CartItem(
                          id: cartItems.values.toList()[index].id,
                          prodId: cartItems.keys.toList()[index],
                          prodImage: cartItems.values.toList()[index].prodImage,
                          title: cartItems.values.toList()[index].title,
                          quantity: cartItems.values.toList()[index].quantity,
                          price: cartItems.values.toList()[index].price,
                        );
                      },
                      itemCount: cartItems.values.toList().length,
                    );
                  },
                ),
        ),
        Container(
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                    Text(
                      '\$ ${Provider.of<Cart>(context).totalAmount.toString()}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    'Order Now >',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
