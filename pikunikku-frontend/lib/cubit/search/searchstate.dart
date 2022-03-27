
part of 'search_cubit.dart';

class SearchState extends Equatable{
  final String? key;
  final List<Tour>? result;
  final bool? loading;
  

  SearchState(
      {this.key: "", this.result, this.loading=false});

  @override
  List<Object?> get props => [key, result, loading];

  SearchState copyWith({
    String? key,
    List<Tour>? result,
    bool? loading,
  }) =>
      SearchState(
        key: key??this.key,
        result: result??this.result,
        loading: loading??this.loading
      );

  @override
  bool? get stringify => true;
}