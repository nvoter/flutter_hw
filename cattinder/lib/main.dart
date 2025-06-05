import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'utils/dependencies_manager.dart';
import 'services/connectivity_service.dart';
import 'screens/components/main_screen.dart';

void main() {
  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivity = getIt<ConnectivityService>();

    return StreamBuilder<bool>(
      stream: connectivity.onStatusChange,
      initialData: true,
      builder: (context, snapshot) {
        final online = snapshot.data ?? true;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cat Tinder',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: Builder(
            builder: (context) {
              if (!online) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Network connection error'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                });
              }
              return const MainScreen();
            },
          ),
        );
      },
    );
  }
}
