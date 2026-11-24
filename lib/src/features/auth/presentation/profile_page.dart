import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';

import '../data/supabase_auth_repository.dart';

final signOutMutation = Mutation<void>();

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider(userId));
    final signOut = ref.watch(signOutMutation);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha conta'),
        actions: [
          TextButton(
            onPressed: signOut is MutationPending
                ? null
                : () async {
                    try {
                      await signOutMutation.run(
                        ref,
                        (transaction) =>
                            transaction.get(authRepositoryProvider).signOut(),
                      );
                    } catch (error) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Não foi possível sair. Tente novamente.',
                            ),
                          ),
                        );
                      }
                    }
                  },
            child: Text(signOut is MutationPending ? 'Saindo...' : 'Sair'),
          ),
        ],
      ),
      body: profile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Não foi possível carregar o perfil.'),
              TextButton(
                onPressed: () => ref.invalidate(profileProvider(userId)),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
        data: (profile) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              profile.nome ?? 'Minha conta',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (profile.email != null) Text(profile.email!),
            const SizedBox(height: 8),
            Text('Perfil: ${profile.role}'),
          ],
        ),
      ),
    );
  }
}
