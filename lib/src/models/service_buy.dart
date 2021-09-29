// ignore_for_file: public_member_api_docs
import 'package:equatable/equatable.dart';
import 'package:qvapay_api_client/src/models/service.dart';

import 'package:qvapay_api_client/src/extension/date_extension.dart';

class ServiceBuy extends Equatable {
  const ServiceBuy({
    required this.serviceId,
    required this.userId,
    required this.serviceData,
    required this.status,
    required this.amount,
    required this.transactionId,
    required this.createdAt,
    required this.updatedAt,
    required this.service,
  });

  factory ServiceBuy.fromJson(Map<String, dynamic> json) => ServiceBuy(
        serviceId: json['service_id'] as int,
        userId: json['user_id'] as int,
        serviceData: json['service_data'] as String,
        status: json['status'] as String,
        amount: json['amount'] as String,
        transactionId: json['transaction_id'] as int,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        service: Service.fromJson(json['service'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'service_id': serviceId,
        'user_id': userId,
        'service_data': serviceData,
        'status': status,
        'amount': amount,
        'transaction_id': transactionId,
        'created_at': createdAt.toStringWithMicrosecond(),
        'updated_at': updatedAt.toStringWithMicrosecond(),
        'service': service.toJson(),
      };

  final int serviceId;
  final int userId;
  final String serviceData;
  final String status;
  final String amount;
  final int transactionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Service service;

  @override
  List<Object> get props {
    return [
      serviceId,
      userId,
      serviceData,
      status,
      amount,
      transactionId,
      createdAt,
      updatedAt,
      service,
    ];
  }
}
