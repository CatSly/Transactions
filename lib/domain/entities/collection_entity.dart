import 'package:equatable/equatable.dart';

class CollectionEntity extends Equatable {

  const CollectionEntity({
    required this.id,
    required this.name,
    required this.roles,
  });
  final String id;
  final String? name;
  final Map<String, dynamic>? roles;

  @override
  List<Object?> get props => [id, name, roles];
}
