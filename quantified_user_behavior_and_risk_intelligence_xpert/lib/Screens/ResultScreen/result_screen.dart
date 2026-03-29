import 'package:flutter/material.dart';

import '../../Models/analyze_response.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';

class ResultScreen extends StatelessWidget {
  final AnalyzeResponse data;

  const ResultScreen({super.key, required this.data});

  Color _levelColor(String level) {
    switch (level) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (data.riskScore.clamp(0, 100)) / 100.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analysis Results",
          style: AppFonts.titleLarge.copyWith(color: AppColors.textAccent),
        ),
        backgroundColor: AppColors.bgPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Risk Score: ${data.riskScore.toStringAsFixed(1)}/100",
              style: AppFonts.displayMedium.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: AppColors.bgSecondary,
                valueColor: AlwaysStoppedAnimation(_levelColor(data.riskLevel)),
              ),
            ),
            const SizedBox(height: 12),
            Chip(
              label: Text(
                data.riskLevel,
                style: AppFonts.labelLarge.copyWith(
                  color: _levelColor(data.riskLevel),
                ),
              ),
              backgroundColor: _levelColor(data.riskLevel).withOpacity(0.15),
              side: BorderSide(color: _levelColor(data.riskLevel)),
            ),
            const SizedBox(height: 16),
            Text(
              "Analysis",
              style: AppFonts.headlineMedium.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 6),
            Text(
              data.analysis,
              style: AppFonts.bodyMedium.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Impersonation Risk",
                    style: AppFonts.titleMedium.copyWith(color: Colors.red),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.impersonationMessage,
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Recommendations",
              style: AppFonts.headlineMedium.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 6),
            ...data.recommendations.map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "• ",
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        r,
                        style: AppFonts.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              data.userWarning,
              style: AppFonts.titleMedium.copyWith(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
