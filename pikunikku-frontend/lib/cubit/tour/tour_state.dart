part of 'tour_cubit.dart';

class TourState extends Equatable {
  final Tour? singleTour;

  final List<Tour>? allTour;
  final int? allTourLength;

  final List<Tour>? listTourDekatRumah;
  final int? listTourDekatRumahLength;

  final List<Tour>? listTourPergiJauh;
  final int? listTourPergiJauhLength;

  final bool? loadingData;
  final bool? successGetData;

  final bool? loadingPaket;
  final List<Paket>? listPaket;
  final List<Paket>? selectedListPaket;
  final bool? hasFilteredData;
  // final String? filter;
  final Paket? selectedPaket;

  TourState({
    this.singleTour,

    this.allTour,
    this.allTourLength:0,

    this.listTourDekatRumah,
    this.listTourDekatRumahLength:0,

    this.listTourPergiJauh,
    this.listTourPergiJauhLength:0,

    this.loadingData:false,
    this.successGetData=false,

    this.loadingPaket=false,
    this.listPaket,
    this.selectedListPaket,
    this.selectedPaket,
    // this.filter,
    this.hasFilteredData=false,
    
  });

  @override
  List<Object?> get props =>
      [singleTour, allTour, listTourPergiJauh, listTourDekatRumah, allTourLength, listTourPergiJauhLength,listTourPergiJauhLength, loadingData, successGetData,listPaket, selectedPaket, selectedListPaket,
      // filter,
      hasFilteredData,
      loadingPaket,
      ];

  TourState copyWith({
    Tour? singleTour,

    List<Tour>? allTour,
    int? allTourLength,

    List<Tour>? listTourDekatRumah,
    int? listTourDekatRumahLength,

    List<Tour>? listTourPergiJauh,
    int? listTourPergiJauhLength,

    bool? loadingData,
    bool? successGetData,

    List<Paket>? listPaket,
    List<Paket>? selectedListPaket,
    Paket? selectedPaket,
    bool? loadingPaket,
    String? filter, 
    bool? hasFilteredData,
    // bool? hasFilteredData,
  }) =>
      TourState(
        singleTour: singleTour??this.singleTour,
        
        allTour: allTour??this.allTour,
        allTourLength: allTourLength??this.allTourLength,

        listTourDekatRumah: listTourDekatRumah??this.listTourDekatRumah,
        listTourDekatRumahLength: listTourDekatRumahLength??this.listTourDekatRumahLength,

        listTourPergiJauh: listTourPergiJauh??this.listTourPergiJauh,
        listTourPergiJauhLength: listTourPergiJauhLength??this.listTourPergiJauhLength,

        loadingData: loadingData??this.loadingData,
        successGetData: successGetData??this.successGetData,

        listPaket: listPaket??this.listPaket,
        selectedPaket: selectedPaket??this.selectedPaket,
        selectedListPaket: selectedListPaket??this.selectedListPaket,
        loadingPaket: loadingPaket??this.loadingPaket,
        // filter:filter??this.filter,
        hasFilteredData: hasFilteredData??this.hasFilteredData,
      );

  @override
  bool? get stringify => true;
}
