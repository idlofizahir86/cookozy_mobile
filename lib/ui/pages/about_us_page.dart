import 'package:cookozy_mobile/shared/theme.dart';
import 'package:flutter/material.dart';
import '../widgets/top_section_widget.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 35),
              const TopSectionWidget(
                title: "About Us",
                back: true,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Cooking Together, Growing Together",
                  style: boldTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  "Selamat datang di Cookozy, teman terbaikmu di dunia kuliner anak kost! Di Cookozy, kami berkomitmen untuk menyediakan pengalaman kuliner yang sehat, praktis, inspiratif, dan mendidik bagi para anak kost.",
                  style: mediumTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  "Cookozy hadir untuk membantu kamu menemukan resep praktis, menyehatkan, berbagi inspirasi, dan mengembangkan keterampilan memasak dengan mudah. Bersama Cookozy, mari jelajahi dunia kuliner dan buatlah momen-momen tak terlupakan di dapur kecil kos mu!\nSelamat Memasak!!",
                  style: mediumTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 55,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/member/Teamus.png"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/member/Idlofi.png",
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/member/Claraa.png",
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/member/Neha.png",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/member/Cisi.png",
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/member/Brit.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
