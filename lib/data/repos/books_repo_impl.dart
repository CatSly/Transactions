// import 'dart:async';
// import 'dart:io';
//
// import 'package:book_organizer/data/db/entities/book_document.dart';
// import 'package:book_organizer/data/db/entities/collection_document.dart';
// import 'package:book_organizer/data/db/entities/meta_document.dart';
// import 'package:book_organizer/data/db/entities/stack_document.dart';
// import 'package:book_organizer/domain/entities/book_entity.dart';
// import 'package:book_organizer/domain/entities/collection_entity.dart';
// import 'package:book_organizer/domain/repo/books_repo.dart';
// import 'package:book_organizer/utils/firebase_constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:injectable/injectable.dart';
//
// @LazySingleton(as: BooksRepo)
// class BooksRepoImpl extends BooksRepo {
//   final firestoreInstance = FirebaseFirestore.instance;
//   final metadata = SettableMetadata(contentType: 'image/jpeg');
//   final userId = FirebaseAuth.instance.currentUser?.uid;
//   Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
//   final storageRef = FirebaseStorage.instance.ref();
//   CollectionReference collections =
//       FirebaseFirestore.instance.collection('collections');
//
//   CollectionReference userCollection =
//       FirebaseFirestore.instance.collection('users');
//
//   CollectionReference circulationCollection =
//       FirebaseFirestore.instance.collection('circulations');
//
//   @override
//   Future<String> createCollection(
//       {required String collectionName, String? debtorUserId}) async {
//     final safeUserId;
//     if (debtorUserId == null) {
//       safeUserId = FirebaseAuth.instance.currentUser?.uid;
//       if (safeUserId == null) {
//         throw Exception('There is no current user');
//       }
//     } else {
//       safeUserId = debtorUserId;
//       if (safeUserId == null) {
//         throw Exception('There is no current user');
//       }
//     }
//
//     final collectionDocument = CollectionDocument(
//       meta: Meta(
//         createAppVersion: FBConst.appVersion,
//         createTimestamp: Timestamp.now(),
//         updateAppVersion: FBConst.appVersion,
//         updateTimestamp: Timestamp.now(),
//       ),
//       name: collectionName,
//       roles: {
//         safeUserId: 'owner',
//       },
//     );
//
//     final newCollectionReference = collections.doc();
//     newCollectionReference.set(collectionDocument.toJson());
//
//     return newCollectionReference.id;
//   }
//
//   @override
//   Future<CollectionEntity> getCollection(String collectionId) async {
//     final document = await collections.doc(collectionId).get();
//
//     final collectionDocument = CollectionDocument.fromJson(
//       document.data() as Map<String, dynamic>,
//     );
//
//     final collectionEntity = CollectionEntity(
//       id: collectionId,
//       name: collectionDocument.name,
//       roles: collectionDocument.roles,
//     );
//
//     return collectionEntity;
//   }
//
//   // One time read
//   @override
//   Future<List<CollectionEntity>> getCollections() async {
//     final safeUserId = FirebaseAuth.instance.currentUser?.uid;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     final collectionsResult = <CollectionEntity>[];
//     final snapshot = await collections
//         .where(
//           'roles.$safeUserId',
//           isEqualTo: 'owner',
//         )
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       for (final document in snapshot.docs) {
//         final collectionDocument = CollectionDocument.fromJson(
//           document.data() as Map<String, dynamic>,
//         );
//
//         var singleCollection = CollectionEntity(
//           id: document.id,
//           name: collectionDocument.name,
//           roles: collectionDocument.roles,
//         );
//
//         if (singleCollection.name?.compareTo('Landed books') != 0 &&
//             singleCollection.name?.compareTo('Borrowed books') != 0) {
//           collectionsResult.add(singleCollection);
//         }
//       }
//     }
//     return collectionsResult;
//   }
//
//   @override
//   Future<Stream<List<CollectionEntity>>> getCollectionsStream() async {
//     final safeUserId = FirebaseAuth.instance.currentUser?.uid;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     final snapshot = await collections
//         .where(
//           'roles.$safeUserId',
//           isEqualTo: 'owner',
//         )
//         .snapshots();
//
//     final stream = snapshot.map<List<CollectionEntity>>(
//       (event) {
//         final collectionsResultList = <CollectionEntity>[];
//         if (event.docs.isNotEmpty) {
//           for (final document in event.docs) {
//             final collectionDocument = CollectionDocument.fromJson(
//               document.data() as Map<String, dynamic>,
//             );
//
//             collectionsResultList.add(
//               CollectionEntity(
//                 id: document.id,
//                 name: collectionDocument.name,
//                 roles: collectionDocument.roles,
//               ),
//             );
//           }
//         }
//         return collectionsResultList;
//       },
//     );
//
//     return stream;
//   }
//
//   @override
//   Future<List<BookDocument>> getBooks({required String collectionId}) async {
//     var listBooks = <BookDocument>[];
//
//     final documentSnapshot =
//         await collections.doc(collectionId).collection('books').get();
//
//     if (documentSnapshot.size.toInt() > 0) {
//       final bookDocuments = documentSnapshot.docs
//           .map((e) => BookDocument.fromJson(e.data() as Map<String, dynamic>))
//           .toList();
//       listBooks = bookDocuments;
//     }
//
//     return listBooks;
//   }
//
//   // Listen books as stream
//   @override
//   Future<Stream<List<BookEntity>>> getBooksStream({
//     required String collectionId,
//   }) async {
//     final snapshot =
//         await collections.doc(collectionId).collection('books').snapshots();
//
//     final stream = snapshot.map<List<BookEntity>>(
//       (event) {
//         final collectionsResultList = <BookEntity>[];
//         if (event.docs.isNotEmpty) {
//           for (final document in event.docs) {
//             final bookDocument = BookDocument.fromJson(document.data());
//             collectionsResultList.add(
//               BookEntity(
//                 hasUrl: bookDocument.coverPhotoUrl != null ? true : false,
//                 title: bookDocument.title,
//                 author: bookDocument.author,
//                 description: bookDocument.desc,
//                 coverPhotoUrl: bookDocument.coverPhotoUrl,
//               ),
//             );
//           }
//         }
//         return collectionsResultList;
//       },
//     );
//
//     return stream;
//   }
//
//   @override
//   Future<void> createNewStack(
//       {required String title, required String collectionId}) async {
//     final safeUserId = userId;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     final stackDocument = StackDocument(
//       name: title,
//       meta: Meta(
//         createAppVersion: FBConst.appVersion,
//         createTimestamp: Timestamp.now(),
//         updateAppVersion: FBConst.appVersion,
//         updateTimestamp: Timestamp.now(),
//       ),
//       sortIndex: 1,
//     );
//
//     final newCollectionReference =
//         collections.doc(collectionId).collection('stacks').doc();
//     newCollectionReference.set(stackDocument.toJson());
//   }
//
//   @override
//   Future<String> uploadBookToCollection({
//     required String title,
//     required String author,
//     required String description,
//     required String collectionId,
//     required File? imageTemporary,
//     required String? bookImageName,
//     required String? source,
//   }) async {
//     final safeUserId = userId;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     var url = '';
//
//     if (imageTemporary != null && bookImageName != null) {
//       final ref = storageRef
//           .child('images/bookCoverPhotos/$userId/$collectionId/$bookImageName');
//       await ref.putFile(imageTemporary, metadata);
//       url = await ref.getDownloadURL();
//     }
//
//     final bookDocument = BookDocument(
//       title: title,
//       author: author,
//       coverPhotoUrl: url,
//       desc: description,
//       isInWishlist: false,
//       isbn: null,
//       meta: Meta(
//         createAppVersion: FBConst.appVersion,
//         createTimestamp: Timestamp.now(),
//         updateAppVersion: FBConst.appVersion,
//         updateTimestamp: Timestamp.now(),
//       ),
//       originalSource: source,
//       ownerId: '$userId',
//       publishDate: null,
//       publisher: null,
//       readState: 'UNKNOWN',
//     );
//
//     final newCollectionReference =
//         collections.doc(collectionId).collection('books');
//
//     var documentSnapshot =
//         await newCollectionReference.add(bookDocument.toJson());
//
//     return documentSnapshot.id;
//   }
//
//   @override
//   Future<void> uploadManualBookToStacks(
//       {required BookEntity dataIntoStack}) async {
//     final safeUserId = userId;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     if (dataIntoStack.chosenStacks != null &&
//         dataIntoStack.chosenStacks?.length != null) {
//       var length = dataIntoStack.chosenStacks?.length;
//       for (var i = 0; i < length!; i++) {
//         var url = '';
//
//         final ref = storageRef.child(
//           'images/bookCoverPhotos/$userId/${dataIntoStack.collectionId}'
//           '/${dataIntoStack.chosenStacks![i]}/${dataIntoStack.bookImageName}',
//         );
//
//         if (dataIntoStack.imageTemporary != null) {
//           await ref.putFile(dataIntoStack.imageTemporary!, metadata);
//           url = await ref.getDownloadURL();
//         }
//
//         final bookDocument = BookDocument(
//           title: dataIntoStack.title,
//           author: dataIntoStack.author,
//           coverPhotoUrl: url,
//           desc: dataIntoStack.description,
//           isInWishlist: false,
//           isbn: null,
//           meta: Meta(
//             createAppVersion: FBConst.appVersion,
//             createTimestamp: Timestamp.now(),
//             updateAppVersion: FBConst.appVersion,
//             updateTimestamp: Timestamp.now(),
//           ),
//           originalSource: dataIntoStack.source,
//           ownerId: '$userId',
//           publishDate: null,
//           publisher: null,
//           readState: 'UNKNOWN',
//         );
//
//         final newCollectionReference = collections
//             .doc(dataIntoStack.collectionId)
//             .collection('stacks')
//             .doc(dataIntoStack.chosenStacks![i].id)
//             .collection('books')
//             .doc(dataIntoStack.bookId);
//
//         newCollectionReference.set(bookDocument.toJson());
//       }
//     }
//   }
//
//   Future<void> uploadFoundBookToStacks(
//       {required BookEntity dataIntoStack}) async {
//     final safeUserId = userId;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     if (dataIntoStack.chosenStacks != null &&
//         dataIntoStack.chosenStacks?.length != null) {
//       var length = dataIntoStack.chosenStacks?.length;
//       for (var i = 0; i < length!; i++) {
//         final bookDocument = BookDocument(
//           title: dataIntoStack.title,
//           author: dataIntoStack.author,
//           coverPhotoUrl: dataIntoStack.coverPhotoUrl,
//           desc: dataIntoStack.description,
//           isInWishlist: false,
//           isbn: null,
//           meta: Meta(
//             createAppVersion: FBConst.appVersion,
//             createTimestamp: Timestamp.now(),
//             updateAppVersion: FBConst.appVersion,
//             updateTimestamp: Timestamp.now(),
//           ),
//           originalSource: 'Search',
//           ownerId: '$userId',
//           publishDate: null,
//           publisher: null,
//           readState: 'UNKNOWN',
//         );
//
//         final newCollectionReference = collections
//             .doc(dataIntoStack.collectionId)
//             .collection('stacks')
//             .doc(dataIntoStack.chosenStacks![i].id)
//             .collection('books')
//             .doc(dataIntoStack.bookId);
//
//         newCollectionReference.set(bookDocument.toJson());
//       }
//     }
//   }
//
//   @override
//   Future<void> uploadSingleBookToStacks(
//       {required BookEntity bookEntity}) async {
//     final safeUserId = userId;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     if (bookEntity.chosenStacks != null &&
//         bookEntity.chosenStacks?.length != null) {
//       var length = bookEntity.chosenStacks?.length;
//       for (var i = 0; i < length!; i++) {
//         final bookDocument = BookDocument(
//           title: bookEntity.title != null ? bookEntity.title : null,
//           author: bookEntity.author != null ? bookEntity.author : null,
//           coverPhotoUrl: bookEntity.coverPhotoUrl != null
//               ? bookEntity.coverPhotoUrl
//               : null,
//           desc: bookEntity.description != null ? bookEntity.description : null,
//           isInWishlist:
//               bookEntity.isInWishlist != null ? bookEntity.isInWishlist : null,
//           isbn: null,
//           userComment:
//               bookEntity.userComment != null ? bookEntity.userComment : 'Empty',
//           numChapters:
//               bookEntity.numChapters != null ? bookEntity.numChapters : null,
//           numPages: bookEntity.numPages != null ? bookEntity.numPages : null,
//           currentPage:
//               bookEntity.currentPage != null ? bookEntity.currentPage : null,
//           currentChapter: bookEntity.currentChapter != null
//               ? bookEntity.currentChapter
//               : null,
//           userRating: bookEntity.rating != null ? bookEntity.rating : 0,
//           meta: Meta(
//             createAppVersion: FBConst.appVersion,
//             createTimestamp: Timestamp.now(),
//             updateAppVersion: FBConst.appVersion,
//             updateTimestamp: Timestamp.now(),
//           ),
//           timesOfReading: bookEntity.timesOfReading,
//           originalSource: 'Search',
//           ownerId: '$userId',
//           publishDate: null,
//           publisher: null,
//           readState:
//               bookEntity.readState != null ? bookEntity.readState : 'UNKNOWN',
//         );
//
//         final newCollectionReference = collections
//             .doc(bookEntity.collectionId)
//             .collection('stacks')
//             .doc(bookEntity.chosenStacks![i].id)
//             .collection('books')
//             .doc(bookEntity.bookId);
//
//         newCollectionReference.set(bookDocument.toJson());
//       }
//     }
//   }
//
//   @override
//   Future<String> uploadFoundedBookToCollection(
//       {required String title,
//       required String author,
//       required String description,
//       required String collectionId,
//       required String imageTemporary,
//       required String bookImageName}) async {
//     final safeUserId = userId;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     final bookDocument = BookDocument(
//       title: title,
//       author: author,
//       coverPhotoUrl: imageTemporary,
//       desc: description,
//       isInWishlist: false,
//       isbn: null,
//       meta: Meta(
//         createAppVersion: FBConst.appVersion,
//         createTimestamp: Timestamp.now(),
//         updateAppVersion: FBConst.appVersion,
//         updateTimestamp: Timestamp.now(),
//       ),
//       originalSource: 'Search',
//       ownerId: '$userId',
//       publishDate: null,
//       publisher: null,
//       readState: 'UNKNOWN',
//     );
//
//     final newCollectionReference =
//         collections.doc(collectionId).collection('books');
//
//     var documentSnapshot =
//         await newCollectionReference.add(bookDocument.toJson());
//
//     return documentSnapshot.id;
//   }
//
//   @override
//   Future<void> removeBookFromStack({required BookEntity bookEntity}) async {
//     if (bookEntity.chosenStacks != null &&
//         bookEntity.chosenStacks?.length != null) {
//       var length = bookEntity.chosenStacks?.length;
//       for (var i = 0; i < length!; i++) {
//         final newCollectionReference = collections
//             .doc(bookEntity.collectionId)
//             .collection('stacks')
//             .doc(bookEntity.chosenStacks![i].id)
//             .collection('books')
//             .doc(bookEntity.bookId);
//
//         newCollectionReference.delete();
//       }
//     }
//   }
//
//   @override
//   Future<void> deleteStack(
//       {required String stackId, required String collectionId}) async {
//     final newCollectionReference =
//         collections.doc(collectionId).collection('stacks').doc(stackId);
//
//     newCollectionReference.delete();
//   }
//
//   @override
//   Future<void> editStack(
//       {required CollectionEntity collectionEntity,
//       required String stackId,
//       required String title}) async {
//     final newCollectionReference =
//         collections.doc(collectionEntity.id).collection('stacks').doc(stackId);
//
//     newCollectionReference.update({'name': title});
//   }
//
//   @override
//   Future<BookEntity?> getSingleBook(
//       {required String collectionId, required String bookId}) async {
//     BookDocument bookDocument;
//     BookEntity? bookEntity;
//
//     final documentSnapshot = await collections
//         .doc(collectionId)
//         .collection('books')
//         .doc(bookId)
//         .get();
//
//     ///TODO check null
//     if (documentSnapshot.exists) {
//       bookDocument = BookDocument.fromJson(
//         documentSnapshot.data() as Map<String, dynamic>,
//       );
//       bookEntity = BookEntity(
//         hasUrl: bookDocument.coverPhotoUrl != null ? true : false,
//         coverPhotoUrl: bookDocument.coverPhotoUrl,
//         description: bookDocument.desc,
//         author: bookDocument.author,
//         title: bookDocument.title,
//         createTimestamp: bookDocument.meta?.createTimestamp,
//         timesOfReading: bookDocument.timesOfReading,
//         numPages: bookDocument.numPages,
//         numChapters: bookDocument.numChapters,
//         currentChapter: bookDocument.currentChapter,
//         currentPage: bookDocument.currentPage,
//         isInWishlist: bookDocument.isInWishlist,
//         readState: bookDocument.readState,
//         rating: bookDocument.userRating,
//       );
//     }
//
//     return bookEntity;
//   }
//
//   @override
//   Future<void> uploadReadingBookState({required BookEntity bookEntity}) async {
//     final newCollectionReference = collections
//         .doc(bookEntity.collectionId)
//         .collection('books')
//         .doc(bookEntity.bookId);
//
//     newCollectionReference.update({
//       'readState': 'INREAD',
//       'numPages': bookEntity.numPages,
//       'numChapters': bookEntity.numChapters,
//     });
//   }
//
//   @override
//   Future<void> uploadCurrentPagesChapters(
//       {required BookEntity bookEntity}) async {
//     final newCollectionReference = collections
//         .doc(bookEntity.collectionId)
//         .collection('books')
//         .doc(bookEntity.bookId);
//
//     newCollectionReference.update({
//       'currentPage': bookEntity.currentPage,
//       'currentChapter': bookEntity.currentChapter,
//       'timesOfReading': bookEntity.timesOfReading,
//     });
//   }
//
//   @override
//   Future<void> uploadTotalPagesChapters(
//       {required BookEntity bookEntity}) async {
//     final newCollectionReference = collections
//         .doc(bookEntity.collectionId)
//         .collection('books')
//         .doc(bookEntity.bookId);
//
//     newCollectionReference.update({
//       'numChapters': bookEntity.numChapters,
//       'numPages': bookEntity.numPages,
//     });
//   }
//
//   @override
//   Future<void> addToWishlist(
//       {required String collectionId, required String bookId}) async {
//     final newCollectionReference =
//         collections.doc(collectionId).collection('books').doc(bookId);
//
//     newCollectionReference.update({'isInWishlist': true});
//   }
//
//   @override
//   Future<void> deleteFromWishlist(
//       {required String collectionId, required String bookId}) async {
//     final newCollectionReference =
//         collections.doc(collectionId).collection('books').doc(bookId);
//
//     newCollectionReference.update({'isInWishlist': false});
//   }
//
//   @override
//   Future<void> updateRating({required BookEntity bookEntity}) async {
//     final newCollectionReference = collections
//         .doc(bookEntity.collectionId)
//         .collection('books')
//         .doc(bookEntity.bookId);
//
//     newCollectionReference.update({
//       'userRating': bookEntity.rating,
//     });
//   }
//
//   @override
//   Future<void> updateComment({required BookEntity bookEntity}) async {
//     final newCollectionReference = collections
//         .doc(bookEntity.collectionId)
//         .collection('books')
//         .doc(bookEntity.bookId);
//
//     newCollectionReference.update({
//       'userRating': bookEntity.rating,
//       'userComment': bookEntity.userComment,
//       'readState': 'FINISHED'
//     });
//   }
//
//   @override
//   Future<void> deleteCollection({required String collectionId}) async {
//     final newCollectionReference = collections.doc(collectionId);
//
//     newCollectionReference.delete();
//   }
//
//   @override
//   Future<void> editCollection(
//       {required String collectionId, required String newName}) async {
//     final newCollectionReference = collections.doc(collectionId);
//
//     newCollectionReference.update({'name': newName});
//   }
//
//   @override
//   Future<void> deleteSingleBookFromStacks(
//       {required BookEntity bookEntity}) async {
//     final safeUserId = userId;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     if (bookEntity.chosenStacks != null &&
//         bookEntity.chosenStacks?.length != null) {
//       var length = bookEntity.chosenStacks?.length;
//       for (var i = 0; i < length!; i++) {
//         final newCollectionReference = collections
//             .doc(bookEntity.collectionId)
//             .collection('stacks')
//             .doc(bookEntity.chosenStacks![i].id)
//             .collection('books')
//             .doc(bookEntity.bookId);
//
//         newCollectionReference.delete();
//       }
//     }
//   }
//
//   @override
//   Future<List<CollectionEntity>> getLandedCollections() async {
//     final safeUserId = FirebaseAuth.instance.currentUser?.uid;
//     if (safeUserId == null) {
//       throw Exception('There is no current user');
//     }
//
//     final collectionsResult = <CollectionEntity>[];
//     final snapshot = await collections
//         .where(
//           'roles.$safeUserId',
//           isEqualTo: 'owner',
//         )
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       for (final document in snapshot.docs) {
//         final collectionDocument = CollectionDocument.fromJson(
//           document.data() as Map<String, dynamic>,
//         );
//
//         var singleCollection = CollectionEntity(
//           id: document.id,
//           name: collectionDocument.name,
//           roles: collectionDocument.roles,
//         );
//
//         if (singleCollection.name?.compareTo('Landed books') == 0) {
//           collectionsResult.add(singleCollection);
//         }
//       }
//     }
//     return collectionsResult;
//   }
//
//   @override
//   Future<List<BookEntity>> getBorrowedBooks() async {
//     var booksResult = <BookEntity>[];
//
//     ///TODO fix borrowerBooks and test it
//
//     final safeUserId = FirebaseAuth.instance.currentUser?.uid;
//     final snapshot = await circulationCollection
//         .where(
//           'roles.$safeUserId',
//           isEqualTo: 'borrower',
//         )
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       for (final document in snapshot.docs) {
//         var book = BookDocument.fromJson(
//           document.data() as Map<String, dynamic>,
//         );
//         booksResult.add(
//           BookEntity(
//             title: book.title,
//             returnTimestamp: book.returnTimestamp,
//             loanTimestamp: book.loanTimestamp,
//             borrowerEmail: book.borrowerEmail,
//             author: book.author,
//             ownerEmail: book.ownerEmail,
//             description: book.desc,
//             coverPhotoUrl: book.coverPhotoUrl,
//           ),
//         );
//       }
//     }
//     return booksResult;
//   }
//
//   @override
//   Future<List<BookDocument>> getLandedBooks(
//       {required String collectionId}) async {
//     var listBooks = <BookDocument>[];
//
//     final documentSnapshot =
//         await collections.doc(collectionId).collection('books').get();
//
//     if (documentSnapshot.size.toInt() > 0) {
//       final bookDocuments = documentSnapshot.docs
//           .map((e) => BookDocument.fromJson(e.data() as Map<String, dynamic>))
//           .toList();
//       listBooks = bookDocuments;
//     }
//
//     return listBooks;
//   }
//
//   @override
//   Future<String?> searchDebtorByEmail({required String? email}) async {
//     String? userId;
//
//     final snapshot = await userCollection
//         .where(
//           'email',
//           isEqualTo: email,
//         )
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       userId = snapshot.docs.first.id;
//     }
//
//     return userId;
//   }
//
//   @override
//   Future<String?> writeIntoLandedCollection(
//       {required BookDocument landedBook,
//       required String collectionName,
//       String? debtorUserId}) async {
//     String? landedCollectionId;
//     final collectionsResult = <String?>[];
//     final snapshot;
//     var bookId;
//
//     if (debtorUserId != null) {
//       snapshot = await collections
//           .where(
//             'roles.$debtorUserId',
//             isEqualTo: 'owner',
//           )
//           .get();
//     } else {
//       snapshot = await collections
//           .where(
//             'roles.${FirebaseAuth.instance.currentUser?.uid}',
//             isEqualTo: 'owner',
//           )
//           .get();
//     }
//
//     if (snapshot.docs.isNotEmpty) {
//       for (final document in snapshot.docs) {
//         final collectionDocument = CollectionDocument.fromJson(
//           document.data() as Map<String, dynamic>,
//         );
//         if (collectionDocument.name?.compareTo(collectionName) == 0) {
//           final landedCollectionReference =
//               collections.doc(document.id).collection('books');
//           await landedCollectionReference
//               .add(landedBook.toJson())
//               .then((documentSnapshot) => bookId = documentSnapshot.id);
//         }
//         collectionsResult.add(collectionDocument.name);
//       }
//     }
//
//     if (!collectionsResult.contains(collectionName)) {
//       landedCollectionId =
//           await createCollection(collectionName: collectionName);
//     }
//
//     if (landedCollectionId != null) {
//       final landedCollectionReference =
//           collections.doc(landedCollectionId).collection('books');
//
//       await landedCollectionReference
//           .add(landedBook.toJson())
//           .then((documentSnapshot) => bookId = documentSnapshot.id);
//     }
//     return bookId;
//   }
//
//   @override
//   Future<void> writeIntoBorrowedBooks(
//       {required BookDocument borrowedBook, required String borrowerId}) async {
//     final currentRoles = {
//       FirebaseAuth.instance.currentUser?.uid: 'owner',
//       borrowerId: 'borrower',
//     };
//
//     borrowedBook.roles = currentRoles;
//     try {
//       circulationCollection.doc().set(borrowedBook.toJson());
//     } on Exception catch (ex) {
//       print(ex.toString());
//     }
//   }
//
//   @override
//   Future<BookEntity?> getSingleBorrowedBook({required String bookId}) async {
//     BookDocument bookDocument;
//     BookEntity? bookEntity;
//
//     final documentSnapshot = await circulationCollection.doc(bookId).get();
//
//     if (documentSnapshot.exists) {
//       bookDocument = BookDocument.fromJson(
//         documentSnapshot.data() as Map<String, dynamic>,
//       );
//       bookEntity = BookEntity(
//         hasUrl: bookDocument.coverPhotoUrl != null ? true : false,
//         coverPhotoUrl: bookDocument.coverPhotoUrl,
//         description: bookDocument.desc,
//         author: bookDocument.author,
//         title: bookDocument.title,
//         createTimestamp: bookDocument.meta?.createTimestamp,
//         timesOfReading: bookDocument.timesOfReading,
//         numPages: bookDocument.numPages,
//         numChapters: bookDocument.numChapters,
//         currentChapter: bookDocument.currentChapter,
//         currentPage: bookDocument.currentPage,
//         isInWishlist: bookDocument.isInWishlist,
//         readState: bookDocument.readState,
//         rating: bookDocument.userRating,
//       );
//     }
//
//     return bookEntity;
//   }
//
//   @override
//   Future<void> addBorrowedBookToWishlist({required String bookId}) async {
//     final borrowedReference = circulationCollection.doc(bookId);
//
//     borrowedReference.update({'isInWishlist': true});
//   }
//
//   @override
//   Future<void> deleteBorrowedFromWishList({required String bookId}) async {
//     final borrowedReference = circulationCollection.doc(bookId);
//
//     borrowedReference.update({'isInWishlist': false});
//   }
//
//   @override
//   Future<void> uploadBorrowedReadingBookState(
//       {required BookEntity bookEntity, required String bookId}) async {
//     final borrowedReference = circulationCollection.doc(bookId);
//
//     borrowedReference.update({
//       'readState': 'INREAD',
//       'numPages': bookEntity.numPages,
//       'numChapters': bookEntity.numChapters,
//     });
//   }
//
//   @override
//   Future<void> uploadTotalBorrowedPagesChapters(
//       {required BookEntity bookEntity}) async {
//     final borrowedReference = circulationCollection.doc(bookEntity.bookId);
//
//     borrowedReference.update({
//       'numChapters': bookEntity.numChapters,
//       'numPages': bookEntity.numPages,
//     });
//   }
//
//   @override
//   Future<void> updateBorrowedRating({required BookEntity bookEntity}) async {
//     final borrowedReference = circulationCollection.doc(bookEntity.bookId);
//
//     borrowedReference.update({
//       'userRating': bookEntity.rating,
//     });
//   }
//
//   @override
//   Future<void> updateBorrowedComment({required BookEntity bookEntity}) async {
//     final borrowedReference = circulationCollection.doc(bookEntity.bookId);
//
//     borrowedReference.update({
//       'userRating': bookEntity.rating,
//       'userComment': bookEntity.userComment,
//       'readState': 'FINISHED'
//     });
//   }
//
//   @override
//   Future<void> markBorrowedReturn({required String bookId}) async {
//     final borrowedReference = circulationCollection.doc(bookId);
//
//     borrowedReference.update({
//       'wantReturn': true,
//     });
//   }
//
//   @override
//   Future<List<BookEntity>> getReturningBooks() async {
//     var booksResult = <BookEntity>[];
//
//     final safeUserId = FirebaseAuth.instance.currentUser?.uid;
//     final snapshot = await circulationCollection
//         .where(
//           'roles.$safeUserId',
//           isEqualTo: 'owner',
//         )
//         .where('wantReturn', isEqualTo: true)
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       for (final document in snapshot.docs) {
//         var book = BookDocument.fromJson(
//           document.data() as Map<String, dynamic>,
//         );
//         booksResult.add(
//           BookEntity(
//             title: book.title,
//             returnTimestamp: book.returnTimestamp,
//             loanTimestamp: book.loanTimestamp,
//             borrowerEmail: book.borrowerEmail,
//             author: book.author,
//             ownerEmail: book.ownerEmail,
//             description: book.desc,
//             coverPhotoUrl: book.coverPhotoUrl,
//           ),
//         );
//       }
//     }
//     return booksResult;
//   }
//
//   @override
//   Future<void> removeReturningBook({required String bookId}) async {
//     final borrowedReference = circulationCollection.doc(bookId);
//
//     borrowedReference.delete();
//   }
//
//   @override
//   Future<void> removeBorrowedBook({required String bookId}) async {
//     final snapshot = await circulationCollection
//         .where(
//           'landedBookId',
//           isEqualTo: bookId,
//         )
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       for (final document in snapshot.docs) {
//         final collectionDocument = CollectionDocument.fromJson(
//           document.data() as Map<String, dynamic>,
//         );
//
//         var singleCollection = CollectionEntity(
//           id: document.id,
//           name: collectionDocument.name,
//           roles: collectionDocument.roles,
//         );
//
//         final borrowedReference =
//             circulationCollection.doc(singleCollection.id);
//
//         borrowedReference.delete();
//       }
//     }
//   }
//
//   @override
//   Future<void> removeBookFromLandedBooks(
//       {required String collectionId, required String bookId}) async {
//     final newCollectionReference =
//         collections.doc(collectionId).collection('books').doc(bookId);
//
//     newCollectionReference.delete();
//   }
//
//   @override
//   Future<void> removeSingleBook(
//       {required String collectionId, required String bookId}) async {
//     final newCollectionReference =
//         collections.doc(collectionId).collection('books').doc(bookId);
//
//     newCollectionReference.delete();
//   }
//
//   @override
//   Future<void> removeLandedBookWithoutCollectionId(
//       {required String landedBookId}) async {
//     String? collectionId;
//     final safeUserId = FirebaseAuth.instance.currentUser?.uid;
//
//     final snapshot = await collections
//         .where(
//           'roles.$safeUserId',
//           isEqualTo: 'owner',
//         )
//         .get();
//
//     if (snapshot.docs.isNotEmpty) {
//       for (final document in snapshot.docs) {
//         final collectionDocument = CollectionDocument.fromJson(
//           document.data() as Map<String, dynamic>,
//         );
//
//         var singleCollection = CollectionEntity(
//           id: document.id,
//           name: collectionDocument.name,
//           roles: collectionDocument.roles,
//         );
//
//         if (singleCollection.name?.compareTo('Landed books') == 0) {
//           collectionId = singleCollection.id;
//         }
//       }
//
//       if (collectionId != null) {
//         final newCollectionReference =
//             collections.doc(collectionId).collection('books').doc(landedBookId);
//
//         newCollectionReference.delete();
//       }
//     }
//   }
// }
