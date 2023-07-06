import 'meta_document.dart';

class StackDocument {
  Meta? meta;
  String? name;
  int? sortIndex;

  StackDocument({this.meta, this.name, this.sortIndex});

  factory StackDocument.fromJson(Map<String, dynamic> json) {
    return StackDocument(
      name: json['name'] != null ? json['name'] : null,
      sortIndex: json['sortIndex'] != null ? json['sortIndex'] : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (name != null) {
      data['name'] = name;
    }
    if (sortIndex != null) {
      data['sortIndex'] = sortIndex;
    }

    return data;
  }
}
