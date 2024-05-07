import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String title;
  final String description;
  final String level;
  final String type;

  const RecipeCard({
    Key? key,
    required this.imageUrl,
    required this.userName,
    required this.title,
    required this.description,
    required this.level,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164,
      height: 241,
      margin: const EdgeInsets.only(right: 11),
      decoration: BoxDecoration(
        color: kAccentColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 109,
            width: 164,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl), // Gunakan NetworkImage
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 5,
                        left: 5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        type,
                        style: boldTextStyle.copyWith(
                          fontSize: 11,
                          color: kAccentColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 5,
                        right: 5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        level,
                        style: boldTextStyle.copyWith(
                          fontSize: 11,
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: boldTextStyle.copyWith(
                    fontSize: 16,
                    color: kBlackColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Posted by ",
                      style: lightTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    Expanded(
                      // Added Expanded widget here
                      child: Text(
                        userName,
                        style: boldTextStyle.copyWith(
                          fontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 4,
                  style: regularTextStyle.copyWith(
                    fontSize: 9,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
