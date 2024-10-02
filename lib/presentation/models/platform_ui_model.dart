import 'package:equatable/equatable.dart';

class PlatformUiModel extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final String tokenAddress;

  const PlatformUiModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.tokenAddress,
  });

  @override
  List<Object> get props => [id, name, symbol, slug, tokenAddress];
}
