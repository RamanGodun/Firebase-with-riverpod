import 'package:firebase_with_riverpod/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import '../../features/theme/theme_toggle_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/helpers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '      Home page',
        actionWidgets: [
          const ThemeToggleIcon(),
          IconButton(
            onPressed:
                () => Helpers.pushToNamed(context, RoutesNames.profilePage),
            icon: const Icon(Icons.person_2),
          ),
        ],
      ),

      body: const Center(
        child: TextWidget(
          'You can go to profile page and make some settings',
          TextType.bodyLarge,
          isTextOnFewStrings: true,
        ),
      ),
    );
  }
}
