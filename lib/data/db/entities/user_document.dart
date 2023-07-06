import 'package:cloud_firestore/cloud_firestore.dart';

import 'meta_document.dart';

class UserDocument {

  UserDocument({
    required this.email,
    required this.lastLoginTimestamp,
    required this.meta,
  });

  factory UserDocument.fromJson(Map<String, dynamic> json) {
    return UserDocument(
      email: json['email'],
      lastLoginTimestamp: json['lastLoginTimestamp'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
  final String email;
  final Timestamp lastLoginTimestamp;
  final Meta? meta;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['lastLoginTimestamp'] = lastLoginTimestamp;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}
