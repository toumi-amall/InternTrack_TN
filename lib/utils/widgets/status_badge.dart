import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Status badge widget - displays status with color coding
class StatusBadge extends StatelessWidget {
  final String status;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const StatusBadge({
    super.key,
    required this.status,
    required this.backgroundColor,
    required this.textColor,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 6,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: backgroundColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

/// Helper function to get status color based on status string
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'applied':
      return AppColors.statusApplied;
    case 'interview':
      return AppColors.statusInterview;
    case 'accepted':
      return AppColors.statusAccepted;
    case 'rejected':
      return AppColors.statusRejected;
    default:
      return AppColors.statusPending;
  }
}
