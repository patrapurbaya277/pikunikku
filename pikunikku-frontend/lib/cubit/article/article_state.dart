

part of 'article_cubit.dart';

class ArticleState extends Equatable{
  final List<Article>? listArticle;
  

  ArticleState(
      {this.listArticle});

  @override
  List<Object?> get props => [listArticle];

  ArticleState copyWith({
    List<Article>? listArticle,
  }) =>
      ArticleState(
        listArticle: listArticle??this.listArticle
      );

  @override
  bool? get stringify => true;
}