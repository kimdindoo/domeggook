import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SlideImage extends StatelessWidget {
  const SlideImage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'asset/img/ad/ad1.png',
      'asset/img/ad/ad2.png',
      'asset/img/ad/ad3.png',
      'asset/img/ad/ad4.png',
      'asset/img/ad/ad5.png',
      'asset/img/ad/ad6.png',
    ];

    return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        height: 133,
        autoPlay: true, // 자동 슬라이드
        autoPlayInterval: Duration(seconds: 2), // 2초마다 자동 변경
      ),
      itemCount: imageList.length,
      itemBuilder: (context, index, realIndex) {
        final item = imageList[index];

        return Stack(
          children: [
            Center(
              child: Image.asset(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(64),
                    ),
                  ),
                  child: Text(
                    '${index + 1}/${imageList.length}',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
