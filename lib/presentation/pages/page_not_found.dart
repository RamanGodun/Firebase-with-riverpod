import 'package:firebase_with_riverpod/core/constants/app_constants.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:firebase_with_riverpod/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../core/router/routes_names.dart';
import '../widgets/buttons.dart';
import '../widgets/text_widget.dart';

class PageNotFound extends StatelessWidget {
  final String errorMessage;

  const PageNotFound({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Page Not Found'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.m,
            children: [
              TextWidget(
                errorMessage.isNotEmpty
                    ? errorMessage
                    : 'Oops! The page you’re looking for does not exist.',
                TextType.error,
                alignment: TextAlign.center,
              ),

              CustomButton(
                type: ButtonType.filled,
                onPressed: () => context.goTo(RoutesNames.home),
                child: const TextWidget('Home', TextType.button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
