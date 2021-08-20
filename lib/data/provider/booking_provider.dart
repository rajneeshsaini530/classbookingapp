import 'dart:async';
import 'package:class_booking/data/model/class_model.dart';
import 'package:flutter/cupertino.dart';

class BookingProvider extends ChangeNotifier {
  static final BookingProvider _singleton = BookingProvider._internal();

  factory BookingProvider() {
    return _singleton;
  }

  BookingProvider._internal();

  List<ClassModel> _classesList = [];
  List<ClassModel> _cartList = [];

  List<ClassModel> get classesList => _classesList;

  List<ClassModel> get cartList => _cartList;

  /// get class for booking
  Future<bool> getClasses() {
    ///local of remote data call
    _classesList = getLocalClassesData();
    return Future.value(true);
  }

  Future<bool> addToCart(ClassModel classModel) {
    ///Add class to cart
    if (_cartList.contains(classModel)) {
      return Future.value(false);
    }
    List<ClassModel> cartSameWeekCount =
        _cartList.where((t) => t.week == classModel.week).toList();
    if (cartSameWeekCount.length >= 3) {
      return Future.value(false);
    }
    _cartList.add(classModel);
    notifyListeners();
    return Future.value(true);
  }

  Future<bool> removeFromCart(ClassModel classModel) {
    ///Remove class from cart
    _cartList.remove(classModel);
    notifyListeners();
    return Future.value(true);
  }

  List<ClassModel> getLocalClassesData() {
    List<ClassModel> classList = [];
    classList.add(ClassModel(
        classId: 1,
        week: 1,
        className: 'Python',
        classAvailableSeats: 4,
        classDate: '23/08/2021',
        classTime: '4:00 PM - 5:00 PM'));
    classList.add(ClassModel(
        classId: 2,
        week: 1,
        className: 'Java',
        classAvailableSeats: 3,
        classDate: '25/08/2021',
        classTime: '5:00 PM - 6:00 PM'));
    classList.add(ClassModel(
        classId: 3,
        week: 1,
        className: 'HTML',
        classAvailableSeats: 1,
        classDate: '26/08/2021',
        classTime: '9:00 AM - 10:00 AM'));
    classList.add(ClassModel(
        classId: 4,
        week: 1,
        className: 'HTML',
        classAvailableSeats: 2,
        classDate: '27/08/2021',
        classTime: '9:00 AM - 10:00 AM'));

    classList.add(ClassModel(
        classId: 5,
        week: 2,
        className: 'Python',
        classAvailableSeats: 0,
        classDate: '30/08/2021',
        classTime: '4:00 PM - 5:00 PM'));
    classList.add(ClassModel(
        classId: 6,
        week: 2,
        className: 'Java',
        classAvailableSeats: 2,
        classDate: '01/09/2021',
        classTime: '5:00 PM - 6:00 PM'));
    classList.add(ClassModel(
        classId: 7,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 3,
        classDate: '03/09/2021',
        classTime: '9:00 AM - 10:00 AM'));
    classList.add(ClassModel(
        classId: 8,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 0,
        classDate: '04/09/2021',
        classTime: '9:00 AM - 10:00 AM'));

    classList.add(ClassModel(
        classId: 5,
        week: 2,
        className: 'Python',
        classAvailableSeats: 1,
        classDate: '06/09/2021',
        classTime: '4:00 PM - 5:00 PM'));
    classList.add(ClassModel(
        classId: 6,
        week: 2,
        className: 'Java',
        classAvailableSeats: 2,
        classDate: '08/09/2021',
        classTime: '5:00 PM - 6:00 PM'));
    classList.add(ClassModel(
        classId: 7,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 3,
        classDate: '10/09/2021',
        classTime: '9:00 AM - 10:00 AM'));
    classList.add(ClassModel(
        classId: 8,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 0,
        classDate: '11/09/2021',
        classTime: '9:00 AM - 10:00 AM'));

    classList.add(ClassModel(
        classId: 5,
        week: 2,
        className: 'Python',
        classAvailableSeats: 1,
        classDate: '13/09/2021',
        classTime: '4:00 PM - 5:00 PM'));
    classList.add(ClassModel(
        classId: 6,
        week: 2,
        className: 'Java',
        classAvailableSeats: 2,
        classDate: '15/09/2021',
        classTime: '5:00 PM - 6:00 PM'));
    classList.add(ClassModel(
        classId: 7,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 0,
        classDate: '18/09/2021',
        classTime: '9:00 AM - 10:00 AM'));
    classList.add(ClassModel(
        classId: 8,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 5,
        classDate: '19/09/2021',
        classTime: '9:00 AM - 10:00 AM'));

    classList.add(ClassModel(
        classId: 5,
        week: 2,
        className: 'Python',
        classAvailableSeats: 1,
        classDate: '20/09/2021',
        classTime: '4:00 PM - 5:00 PM'));
    classList.add(ClassModel(
        classId: 6,
        week: 2,
        className: 'Java',
        classAvailableSeats: 2,
        classDate: '22/09/2021',
        classTime: '5:00 PM - 6:00 PM'));
    classList.add(ClassModel(
        classId: 7,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 3,
        classDate: '25/09/2021',
        classTime: '9:00 AM - 10:00 AM'));
    classList.add(ClassModel(
        classId: 8,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 0,
        classDate: '26/09/2021',
        classTime: '9:00 AM - 10:00 AM'));

    classList.add(ClassModel(
        classId: 5,
        week: 2,
        className: 'Python',
        classAvailableSeats: 1,
        classDate: '28/09/2021',
        classTime: '4:00 PM - 5:00 PM'));
    classList.add(ClassModel(
        classId: 6,
        week: 2,
        className: 'Java',
        classAvailableSeats: 2,
        classDate: '30/09/2021',
        classTime: '5:00 PM - 6:00 PM'));
    classList.add(ClassModel(
        classId: 7,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 3,
        classDate: '02/10/2021',
        classTime: '9:00 AM - 10:00 AM'));
    classList.add(ClassModel(
        classId: 8,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 0,
        classDate: '03/10/2021',
        classTime: '9:00 AM - 10:00 AM'));

    classList.add(ClassModel(
        classId: 5,
        week: 2,
        className: 'Python',
        classAvailableSeats: 1,
        classDate: '05/10/2021',
        classTime: '4:00 PM - 5:00 PM'));
    classList.add(ClassModel(
        classId: 6,
        week: 2,
        className: 'Java',
        classAvailableSeats: 0,
        classDate: '07/10/2021',
        classTime: '5:00 PM - 6:00 PM'));
    classList.add(ClassModel(
        classId: 7,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 3,
        classDate: '10/10/2021',
        classTime: '9:00 AM - 10:00 AM'));
    classList.add(ClassModel(
        classId: 8,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 2,
        classDate: '11/10/2021',
        classTime: '9:00 AM - 10:00 AM'));

    classList.add(ClassModel(
        classId: 5,
        week: 2,
        className: 'Python',
        classAvailableSeats: 0,
        classDate: '12/10/2021',
        classTime: '4:00 PM - 5:00 PM'));
    classList.add(ClassModel(
        classId: 6,
        week: 2,
        className: 'Java',
        classAvailableSeats: 2,
        classDate: '14/10/2021',
        classTime: '5:00 PM - 6:00 PM'));
    classList.add(ClassModel(
        classId: 7,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 0,
        classDate: '18/10/2021',
        classTime: '9:00 AM - 10:00 AM'));
    classList.add(ClassModel(
        classId: 8,
        week: 2,
        className: 'HTML',
        classAvailableSeats: 2,
        classDate: '19/10/2021',
        classTime: '9:00 AM - 10:00 AM'));

    classList.add(ClassModel(
        classId: 5,
        week: 2,
        className: 'Python',
        classAvailableSeats: 1,
        classDate: '20/10/2021',
        classTime: '4:00 PM - 5:00 PM'));
    return classList;
  }
}
