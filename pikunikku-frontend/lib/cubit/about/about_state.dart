

part of 'about_cubit.dart';

class AboutState extends Equatable{
  final int? index;
  final List<Testimoni>? listTestimoni;
  final int maxMenu = 4;
  

  AboutState(
      {this.index=0,this.listTestimoni});

  @override
  List<Object?> get props => [index,listTestimoni];

  AboutState copyWith({
    List<Testimoni>? listTestimoni,
    int? index,
  }) =>
      AboutState(
        listTestimoni: listTestimoni??this.listTestimoni,
        index: index??this.index
      );

  @override
  bool? get stringify => true;
}