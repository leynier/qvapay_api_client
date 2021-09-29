// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

import 'package:qvapay_api_client/src/extension/date_extension.dart';

class Wallet extends Equatable {
  const Wallet({
    required this.transactionId,
    this.invoiceId,
    required this.walletType,
    required this.wallet,
    required this.value,
    required this.received,
    required this.txid,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        transactionId: json['transaction_id'] as int,
        invoiceId: json['invoice_id'] as String?,
        walletType: json['wallet_type'] as String,
        wallet: json['wallet'] as String,
        value: json['value'] as String,
        received: json['received'] as String,
        txid: json['txid'] as String,
        status: json['status'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'transaction_id': transactionId,
        'invoice_id': invoiceId,
        'wallet_type': walletType,
        'wallet': wallet,
        'value': value,
        'received': received,
        'txid': txid,
        'status': status,
        'created_at': createdAt.toStringWithMicrosecond(),
        'updated_at': updatedAt.toStringWithMicrosecond(),
      };

  final int transactionId;
  final String? invoiceId;
  final String walletType;
  final String wallet;
  final String value;
  final String received;
  final String txid;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props {
    return [
      transactionId,
      invoiceId,
      walletType,
      wallet,
      value,
      received,
      txid,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
