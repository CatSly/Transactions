import 'package:cloud_firestore/cloud_firestore.dart';

import 'meta_document.dart';

class BookDocument {
  BookDocument({
    this.author,
    this.bookId,
    this.coverPhotoUrl,
    this.desc,
    this.isInWishlist,
    this.isbn,
    this.meta,
    this.numPages,
    this.numChapters,
    this.currentChapter,
    this.currentPage,
    this.updateTimestamp,
    this.originalSource,
    this.ownerId,
    this.publishDate,
    this.publisher,
    this.readState,
    this.title,
    this.userComment,
    this.userRating,
    this.timesOfReading,
    this.ownerEmail,
    this.borrowerEmail,
    this.loanTimestamp,
    this.returnTimestamp,
    this.wantReturn,
    this.landedBookId,
    this.roles,
  });

  factory BookDocument.fromJson(Map<String, dynamic> json) {
    return BookDocument(
      author: json['author'] != null ? json['author'] : null,
      bookId: json['bookId'] != null ? json['bookId'] : null,
      landedBookId: json['landedBookId'] != null ? json['landedBookId'] : null,
      coverPhotoUrl:
          json['coverPhotoUrl'] != null ? json['coverPhotoUrl'] : null,
      desc: json['desc'] != null ? json['desc'] : null,
      isInWishlist: json['isInWishlist'] != null ? json['isInWishlist'] : null,
      isbn: json['isbn'] != null ? json['isbn'] : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      numPages: json['numPages'] != null ? json['numPages'] : null,
      numChapters: json['numChapters'] != null ? json['numChapters'] : null,
      currentChapter:
          json['currentChapter'] != null ? json['currentChapter'] : null,
      currentPage: json['currentPage'] != null ? json['currentPage'] : null,
      updateTimestamp: json['meta.updateTimestamp'] != null
          ? json['meta.updateTimestamp']
          : null,
      originalSource:
          json['originalSource'] != null ? json['originalSource'] : null,
      ownerId: json['ownerId'] != null ? json['ownerId'] : null,
      publishDate: json['publishDate'] != null ? json['publishDate'] : null,
      publisher: json['publisher'] != null ? json['publisher'] : null,
      readState: json['readState'] != null ? json['readState'] : null,
      title: json['title'] != null ? json['title'] : null,
      userComment: json['userComment'] != null ? json['userComment'] : null,
      userRating: json['userRating'] != null ? json['userRating'] : null,
      timesOfReading:
          json['timesOfReading'] != null ? json['timesOfReading'] : null,
      ownerEmail: json['ownerEmail'] != null ? json['ownerEmail'] : null,
      borrowerEmail:
          json['borrowerEmail'] != null ? json['borrowerEmail'] : null,
      loanTimestamp:
          json['loanTimestamp'] != null ? json['loanTimestamp'] : null,
      returnTimestamp:
          json['returnTimestamp'] != null ? json['returnTimestamp'] : null,
      wantReturn: json['wantReturn'] != null ? json['wantReturn'] : null,
      roles: json['roles'],
    );
  }

  String? author;
  String? bookId;
  String? landedBookId;
  String? coverPhotoUrl;
  String? desc;
  bool? isInWishlist;
  String? isbn;
  Meta? meta;
  int? numPages;
  int? numChapters;
  int? currentPage;
  int? currentChapter;
  Timestamp? updateTimestamp;
  String? originalSource;
  String? ownerId;
  int? publishDate;
  String? publisher;
  String? readState;
  String? title;
  String? userComment;
  int? userRating;
  int? timesOfReading;
  String? ownerEmail;
  String? borrowerEmail;
  Timestamp? loanTimestamp;
  Timestamp? returnTimestamp;
  bool? wantReturn;
  Map<String?, dynamic>? roles;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (title != null) {
      data['title'] = title;
    }
    if (author != null) {
      data['author'] = author;
    }
    if (bookId != null) {
      data[' bookId'] = bookId;
    }
    if (coverPhotoUrl != null) {
      data['coverPhotoUrl'] = coverPhotoUrl;
    }
    if (desc != null) {
      data['desc'] = desc;
    }
    if (isInWishlist != null) {
      data['isInWishlist'] = isInWishlist;
    }
    if (isbn != null) {
      data['isbn'] = isbn;
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (numPages != null) {
      data['numPages'] = numPages;
    }
    if (numChapters != null) {
      data['numChapters'] = numChapters;
    }
    if (currentPage != null) {
      data['currentPage'] = currentPage;
    }
    if (currentChapter != null) {
      data['currentChapter'] = currentChapter;
    }
    if (updateTimestamp != null) {
      data['meta.updateTimestamp'] = updateTimestamp;
    }
    if (originalSource != null) {
      data['originalSource'] = originalSource;
    }
    if (ownerId != null) {
      data['ownerId'] = ownerId;
    }
    if (publishDate != null) {
      data['publishDate'] = publishDate;
    }
    if (publisher != null) {
      data['publisher'] = publisher;
    }
    if (readState != null) {
      data['readState'] = readState;
    }
    if (userComment != null) {
      data['userComment'] = userComment;
    }
    if (userRating != null) {
      data['userRating'] = userRating;
    }
    if (timesOfReading != null) {
      data['timesOfReading'] = timesOfReading;
    }
    if (ownerEmail != null) {
      data['ownerEmail'] = ownerEmail;
    }
    if (borrowerEmail != null) {
      data['borrowerEmail'] = borrowerEmail;
    }
    if (loanTimestamp != null) {
      data['loanTimestamp'] = loanTimestamp;
    }
    if (returnTimestamp != null) {
      data['returnTimestamp'] = returnTimestamp;
    }
    if (wantReturn != null) {
      data['wantReturn'] = wantReturn;
    }
    if (landedBookId != null) {
      data['landedBookId'] = landedBookId;
    }
    if (roles != null) {
      data['roles'] = roles;
    }
    return data;
  }
}
