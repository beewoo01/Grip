import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:grip/api/ApiService.dart';

import '../../model/reservation_model.dart';


class ReservationViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();
  late final StreamController<int?> _insertionResultController;
  Stream<int?> get insertionResultStream => _insertionResultController.stream;

  ReservationViewModel() {
    _insertionResultController = StreamController<int?>.broadcast();
  }


  Future<int?> insertReservation(ReservationModel model) async {
    print('ReservationViewModel insertReservation 여기는옴');
    // insertReservationResult = await apiService.insertReservation(model);
    // return insertReservationResult;

    final insertResult = await apiService.insertReservation(model);
    _insertionResultController.add(insertResult);
    return insertResult;
  }
}