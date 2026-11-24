import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

const authLocalizationsDelegates = [
  _PortugueseAuthDelegate(),
  ...SupabaseAuthUILocalizations.localizationsDelegates,
];

class _PortugueseAuthDelegate
    extends LocalizationsDelegate<SupabaseAuthUILocalizations> {
  const _PortugueseAuthDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'pt';

  @override
  Future<SupabaseAuthUILocalizations> load(Locale locale) =>
      SynchronousFuture(_PortugueseAuthLocalizations());

  @override
  bool shouldReload(_PortugueseAuthDelegate old) => false;
}

class _PortugueseAuthLocalizations extends SupabaseAuthUILocalizations {
  _PortugueseAuthLocalizations() : super('pt');

  @override
  String get enterEmail => 'E-mail';
  @override
  String get validEmailError => 'Informe um e-mail válido.';
  @override
  String get enterPassword => 'Senha';
  @override
  String get passwordLengthError => 'A senha deve ter pelo menos 6 caracteres.';
  @override
  String get signIn => 'Entrar';
  @override
  String get signUp => 'Cadastrar';
  @override
  String get forgotPassword => 'Esqueci minha senha';
  @override
  String get dontHaveAccount => 'Não tem uma conta? Cadastre-se';
  @override
  String get haveAccount => 'Já tem uma conta? Entre';
  @override
  String get requiredFieldError => 'Este campo é obrigatório.';
  @override
  String get confirmPassword => 'Confirme a senha';
  @override
  String get confirmPasswordError => 'As senhas não coincidem.';
  @override
  String get sendPasswordReset => 'Enviar recuperação';
  @override
  String get passwordResetSent => 'E-mail de recuperação enviado.';
  @override
  String get backToSignIn => 'Voltar para o login';
  @override
  String get unexpectedError => 'Ocorreu um erro inesperado.';
  @override
  String get enterOtpCode => 'Código de verificação';
  @override
  String get enterNewPassword => 'Nova senha';
  @override
  String get changePassword => 'Alterar senha';
  @override
  String get passwordChangedSuccess => 'Senha alterada.';
  @override
  String get otpCodeError => 'Código inválido ou expirado.';
  @override
  String get otpDisabledError => 'Verificação por código indisponível.';
  @override
  String get enterPhoneNumber => 'Telefone';
  @override
  String get validPhoneNumberError => 'Informe um telefone válido.';
  @override
  String get continueWithMagicLink => 'Continuar por e-mail';
  @override
  String get checkYourEmail => 'Confira seu e-mail.';
  @override
  String get successSignInMessage => 'Login realizado.';
  @override
  String get updatePassword => 'Atualizar senha';
  @override
  String get enterOneTimeCode => 'Informe o código.';
  @override
  String get enterCodeSent => 'Informe o código enviado.';
  @override
  String get verifyPhone => 'Verificar telefone';
  @override
  String continueWithProvider(String provider) => 'Continuar com $provider';
}
