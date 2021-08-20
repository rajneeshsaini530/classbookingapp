import 'package:class_booking/data/model/class_model.dart';
import 'package:class_booking/data/provider/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingCart extends StatelessWidget {
  const BookingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Provider.of<BookingProvider>(context).cartList.isEmpty
          ? Center(
              child: Text('Your cart is empty!'),
            )
          : Consumer<BookingProvider>(
              builder: (context, bookingProvider, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount:
                        Provider.of<BookingProvider>(context).cartList.length,
                    itemBuilder: (context, item) {
                      return getCartItem(context,
                          Provider.of<BookingProvider>(context).cartList[item]);
                    },
                  ),
                );
              },
            ),
    );
  }

  Widget getCartItem(BuildContext context, ClassModel classModel) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.09),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${classModel.className}',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${classModel.classDate}, ${classModel.classTime}',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                ///onPress
                BookingProvider().removeFromCart(classModel).then((value) {
                  ///removed
                  print('Class Removed!');
                });
              },
              child: Text('Cancel'),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
            ),
          )
        ],
      ),
    );
  }
}
