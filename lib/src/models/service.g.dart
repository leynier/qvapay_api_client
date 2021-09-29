// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      lead: json['lead'] as String,
      price: json['price'] as String,
      logo: json['logo'] as String,
      sublogo: json['sublogo'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'lead': instance.lead,
      'price': instance.price,
      'logo': instance.logo,
      'sublogo': instance.sublogo,
      'desc': instance.desc,
    };
