import 'package:flutter/cupertino.dart';
import 'package:flutter_garbage_classification/util/common.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


Widget banner_widget(BuildContext context){

  return Container(
    height: 220,
    child: Swiper(itemCount: 2,
      itemBuilder: (BuildContext context,int index){
        return Container(
          child: Image(
            image: AssetImage(StringImgRes.banner_list[index]),
            fit: BoxFit.fill,
          ),
        );
      },
      pagination: new SwiperPagination(),
      autoplay: true,

    ),);
}