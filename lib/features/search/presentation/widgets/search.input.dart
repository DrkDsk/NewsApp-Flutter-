import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/features/article/presentation/providers/news.viewmodel.dart';
import 'package:provider/provider.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    super.key,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {

  final TextEditingController textController = TextEditingController();
  late NewsViewModel newsViewModel;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds : 500), () {
      if (text.isNotEmpty) {
        newsViewModel.setTextSearchController(textController);
        newsViewModel.fetchNewsBySearchField(context: context);
      } else {
        newsViewModel.setHeaderListNewsTitle("Latest news");
        newsViewModel.fetchTopHeadlines(context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(5,5)
              ),
              const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5,-5)
              ),
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextFormField(
            onChanged: (value) => onSearchChanged(value),
            controller: textController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w500,
                    fontSize: 24
                )
            ),
          ),
        ),
      ),
    );
  }
}