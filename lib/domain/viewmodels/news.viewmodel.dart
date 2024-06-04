import 'package:flutter/cupertino.dart';
import 'package:news_app/data/services/api.service.dart';
import 'package:news_app/domain/models/article.dart';

class NewsViewModel extends ChangeNotifier {

  final ApiService apiService;
  List<Article> articles = [];
  late Article selectedArticle;
  String selectedCategory = "";
  String headerListNewsTitle = "Latest news";
  bool isLoading = true;

  NewsViewModel({required this.apiService});

  setSelectedArticle(Article article) {
    selectedArticle = article;
    notifyListeners();
  }

  setSelectedCategory(String title) {
    selectedCategory = title;
    notifyListeners();
  }

  setHeaderListNewsTitle(String title) {
    headerListNewsTitle = title;
    notifyListeners();
  }

  markAsLoading() {
    isLoading = true;
    notifyListeners();
  }

  fetchTopHeadlines() async {
    try {
      articles = await apiService.fetchTopHeadlines();
    } catch (exception) {
      print(exception.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  fetchCategoryNews() async {
    isLoading = true;
    notifyListeners();

    try {
      articles = await apiService.fetchCategory(category: selectedCategory.toLowerCase());
    } catch (exception) {
      print(exception.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  fetchNewsBySearchField(String search) async {
    isLoading = true;
    notifyListeners();

    try {
      articles = await apiService.fetchNewsBySearchField(search: search.toLowerCase());
    } catch (exception) {
      print(exception.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}