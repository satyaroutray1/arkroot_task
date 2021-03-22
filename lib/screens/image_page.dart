import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../models/image_detail.dart';

import '../models/apod.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageDetail>(builder: (context, imageModel, child) {
      return imageModel.image == null ? Center(child: LoadingIndicator(indicatorType: Indicator.ballScaleMultiple, color: Colors.lightBlue,),)
          : SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(imageModel.image, context),
            _imageDescription(imageModel.image, context),
          ],
        ),
      );
    });
  }
  
  Widget _image(APOD imageData, BuildContext context) {
    return Center(
      child: Container(
        child: Image.network(
          imageData.url,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: LoadingIndicator(indicatorType: Indicator.ballScaleMultiple, color: Colors.blue,),
            );
          },
        ),
      ),
    );
  }


  Widget _imageDescription(APOD imageData, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            imageData.title, style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline4.fontSize,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          Text(
            'Description: ${imageData.explanation}',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
