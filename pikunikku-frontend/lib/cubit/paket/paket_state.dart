part of 'paket_cubit.dart';

class PaketState extends Equatable {
  final bool? loadingPaket;
  final List<Paket>? listPaket;
  final bool? hasFilteredData;
  final String? filter;
  final Paket? selectedPaket;

  PaketState({
    this.loadingPaket=false,
    this.listPaket,
    this.selectedPaket,
    this.filter,
    this.hasFilteredData=false,
  });

  @override
  List<Object?> get props =>
      [listPaket, selectedPaket,loadingPaket,filter,hasFilteredData];

  PaketState copyWith({
    List<Paket>? listPaket,
    Paket? selectedPaket,
    bool? loadingPaket,
    String? filter,
    bool? hasFilteredData,
  }) =>
      PaketState(
        listPaket: listPaket??this.listPaket,
        selectedPaket: selectedPaket??this.selectedPaket,
        loadingPaket: loadingPaket??this.loadingPaket,
        filter:filter??this.filter,
        hasFilteredData: hasFilteredData??false,
      );

  @override
  bool? get stringify => true;
}
