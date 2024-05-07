import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../model/banner_model.dart';
import '../../service/banner_service.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerModel>>(
      future: fetchBanners(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 354,
            height: 172,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<BannerModel> banners = snapshot.data ?? [];
          return Center(
            child: SizedBox(
              width: 415.2,
              height: 168.1,
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                ),
                items: banners.map((banner) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 11),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      image: DecorationImage(
                        image: NetworkImage(banner.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}
