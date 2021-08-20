import 'package:class_booking/data/provider/booking_provider.dart';
import 'package:class_booking/features/booking/classes_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BookingProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Class Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClassesPage(),
    );
  }
}
