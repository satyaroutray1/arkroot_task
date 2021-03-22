import 'package:flutter/cupertino.dart';
import 'apod.dart';


class ImageDetail extends ChangeNotifier {
  APOD _imageData;
  DateTime _date;

  set image(APOD imageData) {
    _imageData = imageData;
    if (_date == null) {
      _date = DateTime.parse(_imageData.date);
    }
    notifyListeners();
  }

  set date(DateTime date) {
    _date = date;
    notifyListeners();
  }

  DateTime get date => _date;
  APOD get image => _imageData;
}
