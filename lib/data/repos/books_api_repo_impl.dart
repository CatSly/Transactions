// import 'dart:async';
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:injectable/injectable.dart';
//
// @LazySingleton(as: BookApiRepo)
// class BookApiImpl extends BookApiRepo {
//   BookApiImpl();
//
//   @override
//   Future<List<BookEntity>> searchBook(
//       {required String findString, required String firstPartUrl}) async {
//     var booksList = <BookEntity>[];
//     var arr = findString.split(' ');
//     final requestString = arr.join('+');
//     final url = '$firstPartUrl+$requestString';
//     var client = http.Client();
//     final jsonResponse = await client
//         .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
//     if (jsonResponse.statusCode == 200) {
//       var jsonBody = json.decode(jsonResponse.body);
//       var volumeList = VolumeApiDocument.fromJson(jsonBody);
//       if (volumeList.items != null) {
//         for (var i = 0; i < volumeList.items!.length; i++) {
//           booksList.add(
//             BookEntity(
//               title: volumeList.items![i].volumeinfo.title,
//               coverPhotoUrl: volumeList.items![i].volumeinfo.image?.thumb,
//               author: volumeList.items![i].volumeinfo.authors?.first,
//               description: volumeList.items![i].volumeinfo.description,
//               hasUrl: true,
//             ),
//           );
//         }
//       }
//     }
//     return booksList;
//   }
//
//   @override
//   Future<List<BookEntity>> searchBookByApi({required String bookName}) async {
//     final url = 'https://www.googleapis.com/books/v1/volumes?q=';
//     return searchBook(findString: bookName, firstPartUrl: url);
//   }
//
//   @override
//   Future<List<BookEntity>> searchingBookByISBN({required String isbn}) {
//     final url = 'https://www.googleapis.com/books/v1/volumes?q=isbn:';
//     return searchBook(findString: isbn, firstPartUrl: url);
//   }
// }
