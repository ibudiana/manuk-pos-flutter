import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final int id;
  final int customerId;
  final int userId;
  final int branchId;
  final int discountId;
  final int taxId;
  final int feeId;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final DateTime transactionDate;
  final DateTime dueDate;
  final int subtotal;
  final int discountAmount;
  final int taxAmount;
  final int feeAmount;
  final int shippingCost;
  final int grandTotal;
  final int amountPaid;
  final int amountReturned;
  final String paymentStatus;
  final int pointsEarned;
  final int pointsUsed;
  final String notes;
  final String status;
  final int referenceId;
  final String shippingAddress;
  final String shippingTracking;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final List<TransactionItem> transactionItems;

  const Transaction({
    required this.id,
    required this.customerId,
    required this.userId,
    required this.branchId,
    required this.discountId,
    required this.taxId,
    required this.feeId,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.transactionDate,
    required this.dueDate,
    required this.subtotal,
    required this.discountAmount,
    required this.taxAmount,
    required this.feeAmount,
    required this.shippingCost,
    required this.grandTotal,
    required this.amountPaid,
    required this.amountReturned,
    required this.paymentStatus,
    required this.pointsEarned,
    required this.pointsUsed,
    required this.notes,
    required this.status,
    required this.referenceId,
    required this.shippingAddress,
    required this.shippingTracking,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.transactionItems,
  });

  @override
  List<Object?> get props => [
        id,
        customerId,
        userId,
        branchId,
        discountId,
        taxId,
        feeId,
        invoiceNumber,
        invoiceDate,
        transactionDate,
        dueDate,
        subtotal,
        discountAmount,
        taxAmount,
        feeAmount,
        shippingCost,
        grandTotal,
        amountPaid,
        amountReturned,
        paymentStatus,
        pointsEarned,
        pointsUsed,
        notes,
        status,
        referenceId,
        shippingAddress,
        shippingTracking,
        createdAt,
        updatedAt,
        syncStatus,
        transactionItems,
      ];
}

class TransactionItem extends Equatable {
  final int id;
  final int transactionId;
  final int productId;
  final int quantity;
  final int unitPrice;
  final int originalPrice;
  final int discountPercent;
  final int discountAmount;
  final int taxPercent;
  final int taxAmount;
  final int subtotal;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;

  const TransactionItem({
    required this.id,
    required this.transactionId,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.originalPrice,
    required this.discountPercent,
    required this.discountAmount,
    required this.taxPercent,
    required this.taxAmount,
    required this.subtotal,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });

  @override
  List<Object?> get props => [
        id,
        transactionId,
        productId,
        quantity,
        unitPrice,
        originalPrice,
        discountPercent,
        discountAmount,
        taxPercent,
        taxAmount,
        subtotal,
        notes,
        createdAt,
        updatedAt,
        syncStatus,
      ];
}
