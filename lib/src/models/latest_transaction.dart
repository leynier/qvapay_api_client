// ignore_for_file: public_member_api_docs
import 'package:equatable/equatable.dart';
import 'package:qvapay_api_client/src/extension/date_extension.dart';
import 'package:qvapay_api_client/src/models/app.dart';
import 'package:qvapay_api_client/src/models/owner.dart';
import 'package:qvapay_api_client/src/models/paid_by.dart';
import 'package:qvapay_api_client/src/models/service_buy.dart';
import 'package:qvapay_api_client/src/models/wallet.dart';

class LatestTransaction extends Equatable {
  const LatestTransaction({
    required this.uuid,
    required this.appId,
    required this.amount,
    required this.description,
    required this.remoteId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.logo,
    required this.app,
    required this.paidBy,
    required this.appOwner,
    required this.owner,
    this.wallet,
    this.serviceBuy,
  });

  factory LatestTransaction.fromJson(Map<String, dynamic> json) =>
      LatestTransaction(
        uuid: json['uuid'] as String,
        appId: json['app_id'] as int,
        amount: json['amount'] as String,
        description: json['description'] as String,
        remoteId: json['remote_id'] as String,
        status: json['status'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        logo: json['logo'] as String,
        app: App.fromJson(json['app'] as Map<String, dynamic>),
        paidBy: PaidBy.fromJson(json['paid_by'] as Map<String, dynamic>),
        appOwner: App.fromJson(json['app_owner'] as Map<String, dynamic>),
        owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
        wallet: json['wallet'] == null
            ? null
            : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
        serviceBuy: json['servicebuy'] == null
            ? null
            : ServiceBuy.fromJson(json['servicebuy'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uuid': uuid,
        'app_id': appId,
        'amount': amount,
        'description': description,
        'remote_id': remoteId,
        'status': status,
        'created_at': createdAt.toStringWithMicrosecond(),
        'updated_at': updatedAt.toStringWithMicrosecond(),
        'logo': logo,
        'app': app.toJson(),
        'paid_by': paidBy.toJson(),
        'app_owner': appOwner.toJson(),
        'owner': owner.toJson(),
        'wallet': wallet?.toJson(),
        'servicebuy': serviceBuy?.toJson(),
      };

  final String uuid;
  final int appId;
  final String amount;
  final String description;
  final String remoteId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String logo;
  final App app;
  final PaidBy paidBy;
  final App appOwner;
  final Owner owner;
  final Wallet? wallet;
  final ServiceBuy? serviceBuy;

  @override
  List<Object?> get props {
    return [
      uuid,
      appId,
      amount,
      description,
      remoteId,
      status,
      createdAt,
      updatedAt,
      logo,
      app,
      paidBy,
      appOwner,
      owner,
      wallet,
      serviceBuy,
    ];
  }
}
