import 'dart:async';
import 'dart:math';

import 'package:class_booking/common/shimmer_screen.dart';
import 'package:class_booking/data/provider/booking_provider.dart';
import 'package:class_booking/data/model/class_model.dart';
import 'package:class_booking/features/cart/booking_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  late int time;
  late Timer _timer;
  bool isLoaded = false;
  late int freeSeats;

  @override
  void initState() {
    time = 30 + Random().nextInt(60 - 30);
    freeSeats = 5 + Random().nextInt(15 - 5);
    BookingProvider().getClasses().then((value) {
      setState(() {
        isLoaded = true;
      });
      startTimer();
    });
    super.initState();
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          timer.cancel();
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoaded
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Time Left: $time seconds'),
                            Text(
                              'Claim Your Free Trail Class',
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Stack(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 25,
                              ),
                              // if (Provider.of<CartBloc>(context).cartItems.length > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Text(
                                    '${Provider.of<BookingProvider>(context).cartList.length}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                  radius: 6,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            ///onTap
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BookingCart()));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Class Schedule',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        Text(
                          'Free Seats Left: $freeSeats',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: Provider.of<BookingProvider>(context)
                            .classesList
                            .length,
                        itemBuilder: (context, item) {
                          return getClassItem(
                              context,
                              Provider.of<BookingProvider>(context)
                                  .classesList[item],
                              item);
                        },
                      ),
                    )
                  ],
                ),
              )
            : MyShimmer(),
      ),
    );
  }

  Widget getClassItem(BuildContext context, ClassModel classModel, int index) {
    bool isFull = (Provider.of<BookingProvider>(context)
            .classesList[index]
            .classAvailableSeats!) <=
        0;
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
            // 'Thu May 6 2021, 1:00 PM PST - 2 PM PST',
            '${classModel.classDate}, ${classModel.classTime}',
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${Provider.of<BookingProvider>(context).classesList[index].classAvailableSeats} Seat Available',
                // '$isFull Seat Available',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              ElevatedButton(
                onPressed: () {
                  ///onPress
                  if (!isFull) if (freeSeats > 0 && time > 0) {
                    ///Book free seats
                    BookingProvider().addToCart(classModel).then((value) {
                      if (value) {
                        setState(() {
                          freeSeats = freeSeats - 1;
                          int? seat = Provider.of<BookingProvider>(context,
                                  listen: false)
                              .classesList[index]
                              .classAvailableSeats;
                          Provider.of<BookingProvider>(context, listen: false)
                              .classesList[index]
                              .classAvailableSeats = seat! - 1;
                          print(
                              '${Provider.of<BookingProvider>(context, listen: false).classesList[index].classAvailableSeats}');
                        });
                      } else {
                        ///if not added
                        showGameOverDialog(context, 'Something Wrong!',
                            'Looking like Class already in your cart or you can only book 3 class per week!');
                      }
                    });
                  } else {
                    ///Free seats are not available
                    if (time <= 0) {
                      ///Time Up
                      showGameOverDialog(
                          context, 'Time Up!', 'Please visit back again!');
                      return;
                    }

                    ///Seats full
                    showGameOverDialog(
                        context, 'Seats Full!', 'Please visit back again!');
                  }
                },
                child: Text(isFull ? 'Full' : 'Book Now'),
                style: ElevatedButton.styleFrom(
                  primary: isFull ? Colors.red : Colors.orange,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  showGameOverDialog(BuildContext context, String title, String msg) {
    Widget okBtn = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okBtn,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
