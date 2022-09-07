import 'package:json_annotation/json_annotation.dart';

part 'results.g.dart';

@JsonSerializable()
class Results {
  final String type;
  final int type_prob;
  final String growth;
  final int growth_prob;
  final String health;
  final int health_prob;
  final String freshness;
  final int freshness_prob;

  Results(
      {required this.type,
      required this.type_prob,
      required this.growth,
      required this.growth_prob,
      required this.health,
      required this.health_prob,
      required this.freshness,
      required this.freshness_prob});

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
