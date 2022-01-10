part of 'main_cubit.dart';

class MainState extends Equatable {
  final int selectedMenu;

  // final bool close;
  // final Connectivi
  // final bool? connectionState;

  MainState({this.selectedMenu = 0, 
  // this.close=false
  });

  @override
  List<Object?> get props => [selectedMenu,
  // close
  ];

  MainState copyWith({
    int? selectedMenu,
    // bool? close
  }) =>
      MainState(
        selectedMenu: selectedMenu ?? this.selectedMenu,
        // close: close??false
      );

  @override
  bool? get stringify => true;
}
