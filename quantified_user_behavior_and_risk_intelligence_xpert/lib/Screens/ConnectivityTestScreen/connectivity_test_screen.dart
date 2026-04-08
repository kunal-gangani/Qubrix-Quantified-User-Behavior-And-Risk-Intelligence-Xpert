import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BLoC/HealthCheck/health_check_bloc.dart';
import '../../Services/api_service.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';

class ConnectivityTestScreen extends StatelessWidget {
  const ConnectivityTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HealthCheckBloc(apiService: ApiService()),
      child: const _ConnectivityTestView(),
    );
  }
}

class _ConnectivityTestView extends StatelessWidget {
  const _ConnectivityTestView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phase 1: Connectivity Test"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStatusCard(context),
            const SizedBox(height: 12),
            _buildTestButton(context),
            const SizedBox(height: 12),
            _buildProceedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    return BlocBuilder<HealthCheckBloc, HealthCheckState>(
      builder: (context, state) {
        String status = _getStatusText(state);
        Color statusColor = _getStatusColor(state);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: statusColor, width: 6)),
            color: AppColors.bgSecondary.withValues(alpha: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getStatusTitle(state),
                  style: AppFonts.titleLarge.copyWith(color: statusColor),
                ),
                const SizedBox(height: 12),
                Text(
                  status,
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestButton(BuildContext context) {
    return BlocBuilder<HealthCheckBloc, HealthCheckState>(
      builder: (context, state) {
        bool isLoading = state is HealthCheckLoading;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    context.read<HealthCheckBloc>().add(
                      const HealthCheckRequested(),
                    );
                  },
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textOnGold,
                      ),
                    ),
                  )
                : Text(
                    "Test /health",
                    style: AppFonts.titleMedium.copyWith(
                      color: AppColors.textOnGold,
                    ),
                  ),
          ),
        );
      },
    );
  }

  String _getStatusTitle(HealthCheckState state) {
    if (state is HealthCheckInitial) {
      return "Status: Not Tested";
    } else if (state is HealthCheckLoading) {
      return "Status: Testing...";
    } else if (state is HealthCheckSuccess) {
      return "Status: Connected ✓";
    } else if (state is HealthCheckFailure) {
      return "Status: Failed ✗";
    }
    return "Status: Unknown";
  }

  Color _getStatusColor(HealthCheckState state) {
    if (state is HealthCheckInitial) {
      return AppColors.grey500;
    } else if (state is HealthCheckLoading) {
      return AppColors.info;
    } else if (state is HealthCheckSuccess) {
      return AppColors.success;
    } else if (state is HealthCheckFailure) {
      return AppColors.error;
    }
    return AppColors.grey500;
  }

  String _getStatusText(HealthCheckState state) {
    if (state is HealthCheckInitial) {
      return "Ready to test connectivity. Tap the button to start.";
    } else if (state is HealthCheckLoading) {
      return "Checking health status...";
    } else if (state is HealthCheckSuccess) {
      return "✓ Status: ${state.healthResponse.status}\n✓ Message: ${state.healthResponse.message}";
    } else if (state is HealthCheckFailure) {
      return "✗ Error: ${state.error}";
    }
    return "Unknown state";
  }

  Widget _buildProceedButton(BuildContext context) {
    return BlocBuilder<HealthCheckBloc, HealthCheckState>(
      builder: (context, state) {
        bool isConnected = state is HealthCheckSuccess;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isConnected
                ? () {
                    Navigator.of(context).pushNamed('/upload');
                  }
                : null,
            child: Text(
              "Proceed to Analysis",
              style: AppFonts.titleMedium.copyWith(
                color: isConnected
                    ? AppColors.textOnGold
                    : AppColors.textSecondary,
              ),
            ),
          ),
        );
      },
    );
  }
}
