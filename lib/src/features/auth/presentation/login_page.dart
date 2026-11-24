import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

const confirmationUrl = String.fromEnvironment(
  'CONFIRMATION_URL',
  defaultValue:
      'https://bjkmp-squad.github.io/flutter_cantina_facil/confirmacao.html',
);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigningIn = true;
  bool _recoveryUnavailable = false;

  void _message(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cantina Fácil')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView(
            padding: const EdgeInsets.all(24),
            shrinkWrap: true,
            children: [
              if (_recoveryUnavailable) ...[
                const Text('A recuperação de senha ainda não está disponível.'),
                TextButton(
                  onPressed: () => setState(() => _recoveryUnavailable = false),
                  child: const Text('Voltar para o login'),
                ),
              ] else ...[
                Text(
                  'Acesse sua conta',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                SupaEmailAuth(
                  autofocus: false,
                  redirectTo: confirmationUrl,
                  showSnackBars: false,
                  showConfirmPasswordField: true,
                  metadataFields: [
                    MetaDataField(
                      key: 'nome',
                      label: 'Nome',
                      prefixIcon: const Icon(Icons.person),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Informe seu nome.'
                          : null,
                    ),
                  ],
                  onToggleSignIn: (value) => _isSigningIn = value,
                  onToggleRecoverPassword: (value) {
                    if (value) setState(() => _recoveryUnavailable = true);
                  },
                  onSignInComplete: (_) {},
                  onSignUpComplete: (response) {
                    if (response.session == null) {
                      _message('Confira seu e-mail para confirmar o cadastro.');
                    }
                  },
                  onError: (_) => _message(
                    _isSigningIn
                        ? 'Não foi possível entrar. Verifique seus dados e tente novamente.'
                        : 'Não foi possível concluir o cadastro. Tente novamente.',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
