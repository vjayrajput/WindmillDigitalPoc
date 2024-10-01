import 'package:equatable/equatable.dart';

class PlatformEntity extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final String slug;

  PlatformEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
  });

  @override
  List<Object> get props => [id, name, symbol, slug];
}
