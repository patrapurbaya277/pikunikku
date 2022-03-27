import 'dart:convert';

import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:pikunikku/sources/model/avoider.dart';

part 'article_state.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit() : super(ArticleState());

  void getListArticle(context) async {
    Avoider avoider = Avoider();
    avoider.catchException(
        context: context,
        function: () async {
          http.Response response;
          response = await http.get(API.articles);
          // print(response.body);
          final jsonData = jsonDecode((response.body).toString());
          if (response.statusCode == 200) {
            List<Article> _listArticle = [];
            for (var item in jsonData["data"]) {
              _listArticle.add(Article.fromJson(item));
            }
            emit(state.copyWith(
              listArticle: _listArticle,
            ));
            print("sukses get artikel");
          }
        });
  }
}
