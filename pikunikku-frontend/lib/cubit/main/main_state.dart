part of 'main_cubit.dart';

class MainState extends Equatable {
  final int selectedMenu;

  MainState({this.selectedMenu = 0});

  @override
  List<Object?> get props => [selectedMenu];

  MainState copyWith({
    int? selectedMenu,
  }) =>
      MainState(
        selectedMenu: selectedMenu ?? this.selectedMenu,
      );

  @override
  bool? get stringify => true;
}
