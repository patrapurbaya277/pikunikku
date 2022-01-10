import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/article/article_cubit.dart';
import 'package:pikunikku/pages/articles/widgets/article_item.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleCubit, ArticleState>(builder: (context, state) {
      return Scaffold(
        body: state.listArticle==null?SizedBox():ListView(
          padding: EdgeInsets.all(10),
          children: state.listArticle!.map((e) => ArticleItem(article: e,)).toList()
        ),
      );
    });
  }
}
