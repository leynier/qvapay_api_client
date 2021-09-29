// ignore_for_file: public_member_api_docs
import 'package:equatable/equatable.dart';

class PaidBy extends Equatable {
  const PaidBy({
    this.uuid,
    required this.username,
    required this.name,
    this.lastname,
    this.bio,
    this.logo,
    this.kyc,
  });

  factory PaidBy.fromJson(Map<String, dynamic> json) => PaidBy(
        uuid: json['uuid'] as String?,
        username: json['username'] as String,
        name: json['name'] as String,
        lastname: json['lastname'] as String?,
        bio: json['bio'] as String?,
        logo: json['logo'] as String?,
        kyc: json['kyc'] as int?,
      );

  final String? uuid;
  final String username;
  final String name;
  final String? lastname;
  final String? bio;
  final String? logo;
  final int? kyc;

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (uuid != null) 'uuid': uuid,
        'username': username,
        'name': name,
        if (lastname != null) 'lastname': lastname,
        if (bio != null) 'bio': bio,
        if (logo != null) 'logo': logo,
        if (kyc != null) 'kyc': kyc,
      };

  @override
  List<Object?> get props {
    return [
      uuid,
      username,
      name,
      lastname,
      bio,
      logo,
      kyc,
    ];
  }
}
