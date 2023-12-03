import 'package:cineflix_id/presentation/misc/extensions/build_context_extension.dart';
import 'package:cineflix_id/presentation/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user_data/user_data_provider.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(ref.watch(userDataProvider).when(
                  data: (data) => data.toString(),
                  error: (error, stackTrace) => '',
                  loading: () => 'loading',
                )),
            ElevatedButton(
              onPressed: () => ref.read(userDataProvider.notifier).logout(),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
