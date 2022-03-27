part of 'booking_cubit.dart';

class BookingState extends Equatable {
  final bool? canBook;
  final bool? loading;
  final bool? bookStatus;
  final int? jumlah;
  final Tour? tour;
  final Paket? paket;
  final String? metode;
  final File? image;
  final BookData? bookData;
  final String? message;
  final List<BookData>? listBookData;
  final BookData? bookDetail;

  BookingState({
    this.jumlah = 1,
    this.tour,
    this.paket,
    this.metode = "Langsung",
    this.image,
    this.canBook,
    this.loading = false,
    this.bookStatus = false,
    this.bookData,
    this.message = "",
    this.listBookData,
    this.bookDetail,
  });

  @override
  List<Object?> get props => [
        jumlah,
        tour,
        paket,
        metode,
        image,
        canBook,
        loading,
        bookStatus,
        bookData,
        message,
        listBookData,
        bookDetail,
      ];

  BookingState copyWith({
    int? jumlah,
    Tour? tour,
    Paket? paket,
    String? metode,
    File? image,
    bool? canBook,
    bool? loading,
    bool? bookStatus,
    BookData? bookData,
    String? message,
    List<BookData>? listBookData,
    BookData? bookDetail,
  }) =>
      BookingState(
        jumlah: jumlah ?? this.jumlah,
        tour: tour ?? this.tour,
        paket: paket ?? this.paket,
        metode: metode ?? this.metode,
        image: image ?? this.image,
        canBook: canBook ?? this.canBook,
        loading: loading ?? this.loading,
        bookStatus: bookStatus ?? this.bookStatus,
        bookData: bookData ?? this.bookData,
        message: message ?? this.message,
        listBookData: listBookData ?? this.listBookData,
        bookDetail: bookDetail??this.bookDetail,
      );

  @override
  bool? get stringify => true;
}
