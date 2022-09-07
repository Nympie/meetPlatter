// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      type: json['type'] as String,
      type_prob: json['type_prob'] as int,
      growth: json['growth'] as String,
      growth_prob: json['growth_prob'] as int,
      health: json['health'] as String,
      health_prob: json['health_prob'] as int,
      freshness: json['freshness'] as String,
      freshness_prob: json['freshness_prob'] as int,
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'type': instance.type,
      'type_prob': instance.type_prob,
      'growth': instance.growth,
      'growth_prob': instance.growth_prob,
      'health': instance.health,
      'health_prob': instance.health_prob,
      'freshness': instance.freshness,
      'freshness_prob': instance.freshness_prob,
    };
