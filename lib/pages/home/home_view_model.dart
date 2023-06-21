import 'package:blog_app/services/firestore/blog_service.dart';
import 'package:blog_app/utils/strings.dart';
import 'package:flutter/material.dart';

import '../../models/blog.dart';
import '../../utils/custom_navigator.dart';

class HomeViewModel extends ChangeNotifier {
  final BlogService _blogService = BlogService();

  List<Blog> blogList = [];
  List<String> selectedTags = [];
  bool isLoading = false;

  Future<void> getBlogs() async {
    changeLoading();
    blogList = await _blogService.getAll();

    if (selectedTags.isNotEmpty) {
      blogList = blogList
          .where((blog) => containList(blog.tags, selectedTags))
          .toList();
    }

    changeLoading();
  }

  //superlist blogların etiketlerini sublist ise seçili etiketleri ifade eder.
  //blogdaki etiketler seçili etiketlerden herhangi birini içermesi yeterlidir.
  bool containList(List<String> superList, List<String> subList) {
    bool contains = false;

    for (var element in superList) {
      if (subList.contains(element)) {
        contains = true;
        break;
      }
    }
    return contains;
  }

  Future<void> onClickTag(String text, bool isSelected) async {
    if (isSelected) {
      selectedTags.add(text);
    } else {
      selectedTags.remove(text);
    }
    await getBlogs();
  }

  void changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void goToDetailPage(BuildContext context, Blog blog) {
    CustomNavigator.pushToWithArgument(context, Strings.detailRoute, blog);
  }
}
