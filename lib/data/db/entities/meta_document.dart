import 'package:cloud_firestore/cloud_firestore.dart';

class Meta {
  String? createAppVersion;
  Timestamp? createTimestamp;
  String? updateAppVersion;
  Timestamp? updateTimestamp;

  Meta({
    this.createAppVersion,
    this.createTimestamp,
    this.updateAppVersion,
    this.updateTimestamp,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createAppVersion: json['createAppVersion'],
      createTimestamp: json['createTimestamp'],
      updateAppVersion: json['updateAppVersion'],
      updateTimestamp: json['updateTimestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['createAppVersion'] = createAppVersion;
    data['createTimestamp'] = createTimestamp;
    data['updateAppVersion'] = updateAppVersion;
    data['updateTimestamp'] = updateTimestamp;
    return data;
  }
}
