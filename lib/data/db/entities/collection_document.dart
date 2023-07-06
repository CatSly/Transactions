import 'meta_document.dart';

class CollectionDocument {
  CollectionDocument({
    required this.meta,
    required this.name,
    required this.roles,
  });

  factory CollectionDocument.fromJson(Map<String, dynamic> json) {
    return CollectionDocument(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      name: json['name'],
      roles: json['roles'],
    );
  }

  Meta? meta;
  String? name;
  Map<String, dynamic>? roles;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['name'] = name;
    data['roles'] = roles;
    return data;
  }
}
