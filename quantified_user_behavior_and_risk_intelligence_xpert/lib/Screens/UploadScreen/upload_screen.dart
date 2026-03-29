import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BLoC/Analyze/analyze_bloc.dart';
import '../../BLoC/Analyze/analyze_event.dart';
import '../../BLoC/Analyze/analyze_state.dart';
import '../../Services/api_service.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_fonts.dart';
import '../ResultScreen/result_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _imagesController = TextEditingController();
  final _voiceController = TextEditingController();
  String _socialPresence = "medium";
  late AnalyzeBloc _analyzeBloc;

  @override
  void initState() {
    super.initState();
    _analyzeBloc = AnalyzeBloc(apiService: ApiService());
  }

  @override
  void dispose() {
    _imagesController.dispose();
    _voiceController.dispose();
    _analyzeBloc.close();
    super.dispose();
  }

  void _analyze() {
    final images = int.tryParse(_imagesController.text.trim());
    final voice = int.tryParse(_voiceController.text.trim());

    if (images == null || voice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid numbers.")),
      );
      return;
    }

    context.read<AnalyzeBloc>().add(
      AnalyzeRequested(
        imagesCount: images,
        voiceSeconds: voice,
        socialPresence: _socialPresence,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _analyzeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Qubrix - Analyze",
            style: AppFonts.titleLarge.copyWith(color: AppColors.textAccent),
          ),
          backgroundColor: AppColors.bgPrimary,
        ),
        body: BlocListener<AnalyzeBloc, AnalyzeState>(
          listener: (context, state) {
            if (state is AnalyzeSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ResultScreen(data: state.data),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _imagesController,
                  keyboardType: TextInputType.number,
                  style: AppFonts.bodyMedium,
                  decoration: InputDecoration(
                    labelText: "Images count",
                    labelStyle: AppFonts.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _voiceController,
                  keyboardType: TextInputType.number,
                  style: AppFonts.bodyMedium,
                  decoration: InputDecoration(
                    labelText: "Voice seconds",
                    labelStyle: AppFonts.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _socialPresence,
                  items: const [
                    DropdownMenuItem(value: "low", child: Text("low")),
                    DropdownMenuItem(value: "medium", child: Text("medium")),
                    DropdownMenuItem(value: "high", child: Text("high")),
                  ],
                  onChanged: (v) =>
                      setState(() => _socialPresence = v ?? "medium"),
                  style: AppFonts.bodyMedium,
                  decoration: InputDecoration(
                    labelText: "Social presence",
                    labelStyle: AppFonts.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<AnalyzeBloc, AnalyzeState>(
                  builder: (context, state) {
                    final loading = state is AnalyzeLoading;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: loading ? null : _analyze,
                        child: loading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text("Analyze Risk", style: AppFonts.labelLarge),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                BlocBuilder<AnalyzeBloc, AnalyzeState>(
                  builder: (context, state) {
                    if (state is AnalyzeFailure) {
                      return Text(
                        state.message,
                        style: AppFonts.bodyMedium.copyWith(color: Colors.red),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
