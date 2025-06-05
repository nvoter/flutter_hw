import 'package:flutter/material.dart';
import '../../../services/connectivity_service.dart';
import '../../../utils/dependencies_manager.dart';

class OfflineIndicator extends StatelessWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivity = getIt<ConnectivityService>();

    return StreamBuilder<bool>(
      stream: connectivity.onStatusChange,
      initialData: true,
      builder: (context, snapshot) {
        final online = snapshot.data ?? true;
        if (online) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'assets/images/offline.png',
            width: 24,
            height: 24,
          ),
        );
      },
    );
  }
}
