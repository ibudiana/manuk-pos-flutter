import 'package:manuk_pos/features/transaction/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required super.id,
    required super.customerId,
    required super.userId,
    required super.branchId,
    required super.discountId,
    required super.taxId,
    required super.feeId,
    required super.invoiceNumber,
    required super.invoiceDate,
    required super.transactionDate,
    required super.dueDate,
    required super.subtotal,
    required super.discountAmount,
    required super.taxAmount,
    required super.feeAmount,
    required super.shippingCost,
    required super.grandTotal,
    required super.amountPaid,
    required super.amountReturned,
    required super.paymentStatus,
    required super.pointsEarned,
    required super.pointsUsed,
    required super.notes,
    required super.status,
    required super.referenceId,
    required super.shippingAddress,
    required super.shippingTracking,
    required super.createdAt,
    required super.updatedAt,
    required super.syncStatus,
    required super.transactionItems,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      customerId: json['customer_id'],
      userId: json['user_id'],
      branchId: json['branch_id'],
      discountId: json['discount_id'],
      taxId: json['tax_id'],
      feeId: json['fee_id'],
      invoiceNumber: json['invoice_number'],
      invoiceDate: DateTime.parse(json['invoice_date']),
      transactionDate: DateTime.parse(json['transaction_date']),
      dueDate: DateTime.parse(json['due_date']),
      subtotal: json['subtotal'],
      discountAmount: json['discount_amount'],
      taxAmount: json['tax_amount'],
      feeAmount: json['fee_amount'],
      shippingCost: json['shipping_cost'],
      grandTotal: json['grand_total'],
      amountPaid: json['amount_paid'],
      amountReturned: json['amount_returned'],
      paymentStatus: json['payment_status'],
      pointsEarned: json['points_earned'],
      pointsUsed: json['points_used'],
      notes: json['notes'],
      status: json['status'],
      referenceId: json['reference_id'],
      shippingAddress: json['shipping_address'],
      shippingTracking: json['shipping_tracking'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      syncStatus: json['sync_status'],
      transactionItems: (json['transaction_items'] as List)
          .map((item) => TransactionItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'user_id': userId,
      'branch_id': branchId,
      'discount_id': discountId,
      'tax_id': taxId,
      'fee_id': feeId,
      'invoice_number': invoiceNumber,
      'invoice_date': invoiceDate.toIso8601String(),
      'transaction_date': transactionDate.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'subtotal': subtotal,
      'discount_amount': discountAmount,
      'tax_amount': taxAmount,
      'fee_amount': feeAmount,
      'shipping_cost': shippingCost,
      'grand_total': grandTotal,
      'amount_paid': amountPaid,
      'amount_returned': amountReturned,
      'payment_status': paymentStatus,
      'points_earned': pointsEarned,
      'points_used': pointsUsed,
      'notes': notes,
      'status': status,
      'reference_id': referenceId,
      'shipping_address': shippingAddress,
      'shipping_tracking': shippingTracking,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
      'transaction_items': transactionItems
          .map((item) => (item as TransactionItemModel).toJson())
          .toList(),
    };
  }

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      customerId: transaction.customerId,
      userId: transaction.userId,
      branchId: transaction.branchId,
      discountId: transaction.discountId,
      taxId: transaction.taxId,
      feeId: transaction.feeId,
      invoiceNumber: transaction.invoiceNumber,
      invoiceDate: transaction.invoiceDate,
      transactionDate: transaction.transactionDate,
      dueDate: transaction.dueDate,
      subtotal: transaction.subtotal,
      discountAmount: transaction.discountAmount,
      taxAmount: transaction.taxAmount,
      feeAmount: transaction.feeAmount,
      shippingCost: transaction.shippingCost,
      grandTotal: transaction.grandTotal,
      amountPaid: transaction.amountPaid,
      amountReturned: transaction.amountReturned,
      paymentStatus: transaction.paymentStatus,
      pointsEarned: transaction.pointsEarned,
      pointsUsed: transaction.pointsUsed,
      notes: transaction.notes,
      status: transaction.status,
      referenceId: transaction.referenceId,
      shippingAddress: transaction.shippingAddress,
      shippingTracking: transaction.shippingTracking,
      createdAt: transaction.createdAt,
      updatedAt: transaction.updatedAt,
      syncStatus: transaction.syncStatus,
      transactionItems: transaction.transactionItems
          .map((item) => TransactionItemModel.fromEntity(item))
          .toList(),
    );
  }
}

class TransactionItemModel extends TransactionItem {
  const TransactionItemModel({
    required super.id,
    required super.transactionId,
    required super.productId,
    required super.quantity,
    required super.unitPrice,
    required super.originalPrice,
    required super.discountPercent,
    required super.discountAmount,
    required super.taxPercent,
    required super.taxAmount,
    required super.subtotal,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
    required super.syncStatus,
  });

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) {
    return TransactionItemModel(
      id: json['id'],
      transactionId: json['transaction_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      originalPrice: json['original_price'],
      discountPercent: json['discount_percent'],
      discountAmount: json['discount_amount'],
      taxPercent: json['tax_percent'],
      taxAmount: json['tax_amount'],
      subtotal: json['subtotal'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      syncStatus: json['sync_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_id': transactionId,
      'product_id': productId,
      'quantity': quantity,
      'unit_price': unitPrice,
      'original_price': originalPrice,
      'discount_percent': discountPercent,
      'discount_amount': discountAmount,
      'tax_percent': taxPercent,
      'tax_amount': taxAmount,
      'subtotal': subtotal,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'sync_status': syncStatus,
    };
  }

  factory TransactionItemModel.fromEntity(TransactionItem item) {
    return TransactionItemModel(
      id: item.id,
      transactionId: item.transactionId,
      productId: item.productId,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      originalPrice: item.originalPrice,
      discountPercent: item.discountPercent,
      discountAmount: item.discountAmount,
      taxPercent: item.taxPercent,
      taxAmount: item.taxAmount,
      subtotal: item.subtotal,
      notes: item.notes,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
      syncStatus: item.syncStatus,
    );
  }
}
