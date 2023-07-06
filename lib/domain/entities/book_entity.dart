import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class BookEntity {
  BookEntity({
    this.title,
    this.author,
    this.description,
    this.coverPhotoUrl,
    this.createTimestamp,
    this.numPages,
    this.numChapters,
    this.currentChapter,
    this.currentPage,
    this.hasUrl,
    this.readState,
    this.isInWishlist,
    this.collectionId,
    this.bookId,
    this.imageTemporary,
    this.bookImageName,
    this.userComment,
    this.rating,
    this.timesOfReading,
    this.ownerEmail,
    this.borrowerEmail,
    this.source,
    this.loanTimestamp,
    this.returnTimestamp,
    this.wantReturn,
    this.landedBookId,
    this.roles,
  });

  String? title;
  String? author;
  String? description;
  String? coverPhotoUrl;
  Timestamp? createTimestamp;
  int? numPages;
  int? numChapters;
  int? currentPage;
  int? currentChapter;
  bool? hasUrl;
  String? readState;
  bool? isInWishlist;
  String? collectionId;
  String? bookId;
  File? imageTemporary;
  String? bookImageName;
  String? userComment;
  int? rating;
  int? timesOfReading;
  String? ownerEmail;
  String? borrowerEmail;
  final String? source;
  Timestamp? loanTimestamp;
  Timestamp? returnTimestamp;
  bool? wantReturn;
  String? landedBookId;
  final Map<String, dynamic>? roles;
}
