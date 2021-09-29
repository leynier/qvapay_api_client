// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      uuid: json['uuid'] as String?,
      username: json['username'] as String,
      name: json['name'] as String,
      lastname: json['lastname'] as String?,
      bio: json['bio'] as String?,
      logo: json['logo'] as String?,
      kyc: json['kyc'] as int?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'username': instance.username,
      'name': instance.name,
      'lastname': instance.lastname,
      'bio': instance.bio,
      'logo': instance.logo,
      'kyc': instance.kyc,
    };
