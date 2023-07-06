import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.name,
    this.avatar,
  });

  final String? name;
  final String? avatar;

  @override
  List<Object?> get props => [
        name,
        avatar,
      ];
}
