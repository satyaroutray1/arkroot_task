import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../utilities/network_helper.dart';
import 'image_page.dart';
import '../models/image_detail.dart';
import '../models/apod.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetWorkHelper http;
  DateTime date;

  @override
  void initState() {
    http = NetWorkHelper();

    date = DateTime.now();
    getImage(date);
    
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    var imageModel = context.read<ImageDetail>();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1995, 6),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      imageModel.date = picked;

    print("selectedDate: ${selectedDate.toString().split(" ")[0]}");

  }

  getImage(DateTime date) async {
    Response response;
    var imageModel = context.read<ImageDetail>();
    try {
      response = await http.fetchData(date.toString().split(" ")[0]);
      if (response.statusCode == 200) {
        imageModel.image = APOD.fromJson(response.data);
      } else {
        imageModel.image = null;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Consumer<ImageDetail>(
          builder: (context, imageModel, child) {
            return AppBar(
              title:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Astronomy Picture of the Day',
                    style: TextStyle(color: Colors.white,),
                  ),
                  Text(
                    '${imageModel.date == null ? "" : imageModel.date.toString().split(" ")[0]}',
                    style: TextStyle(color: Colors.white,
                    fontSize: Theme.of(context).textTheme.headline6.fontSize/2),

                  )
                ],
              ),
              centerTitle: true,);

          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ImageDetail>(
              builder: (context, imageModel, child) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          child: Text('Change Date'),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          child: Text('Find'),
                          onPressed: () {
                            imageModel.image = null;
                            getImage(imageModel.date);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            ImagePage(),

          ],
        ),
      ),
    );
  }
}
