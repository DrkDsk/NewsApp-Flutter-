import 'package:flutter/material.dart';
import 'package:news_app/core/utils/images.dart';

class ArticleRoundedImage extends StatelessWidget {

  final String imageUrl;

  const ArticleRoundedImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.blue.shade900,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: getDefaultArticleImage(imageUrl),
          )
      ),
    );
  }
}