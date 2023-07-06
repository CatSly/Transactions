import 'package:equatable/equatable.dart';

class StackEntity extends Equatable {

  const StackEntity({required this.name, this.sortIndex, this.id});
  final String name;
  final String? id;
  final int? sortIndex;

  @override
  List<Object?> get props => [name, id, sortIndex];
}
