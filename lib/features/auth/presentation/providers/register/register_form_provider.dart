import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref) {
  final registerUserCallBack = ref.watch(authProvider.notifier).registerUser;
  final logoutCallBack = ref.watch(authProvider.notifier).logout;

  return RegisterFormNotifier(registerUserCallBack, logoutCallBack);
});


class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  final Function(String, String, String) registerUserCallBack; 
  final Function(String?) logoutCallBack;

  RegisterFormNotifier(this.registerUserCallBack, this.logoutCallBack): super(RegisterFormState());


  onFormSubmit() async {
    _touchEveryField();
    
    if (!state.isValid) return;

    if (state.password != state.repeatPassword) {
      logoutCallBack('las contraseñas no son iguales');
      return;
    }

    await registerUserCallBack(state.email.value, state.password.value, state.fullName.value );
  }

  void _touchEveryField() {
    final fullName = FullName.dirty(state.fullName.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repeatPassword = Password.dirty(state.repeatPassword.value);

    state = state.copyWith(
      fullName: fullName,
      email: email,
      password: password,
      repeatPassword: repeatPassword,
      isValid: Formz.validate([fullName, email, password, repeatPassword]),
    );
  }

  onFullNameChange(String value) {

    final newFullName = FullName.dirty(value);

    state = state.copyWith(
      fullName: newFullName,
      isValid: Formz.validate([newFullName, state.email, state.password, state.repeatPassword])
      );
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);

    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password, state.fullName, state.repeatPassword])
      );

  }
  
  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.fullName, state.repeatPassword, state.email])
      );

  }

  onRepeatPasswordChange(String value) {
    final newRepeatPassword = Password.dirty(value);

    state = state.copyWith(
      repeatPassword: newRepeatPassword,
      isValid: Formz.validate([newRepeatPassword, state.fullName, state.email, state.password])
      );

  }
}


class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final FullName fullName;
  final Email email;
  final Password password;
  final Password repeatPassword;

  RegisterFormState({
    this.isPosting = false, 
    this.isFormPosted = false, 
    this.isValid = false,
    this.fullName = const FullName.pure(), 
    this.email = const Email.pure(), 
    this.password = const Password.pure(), 
    this.repeatPassword = const Password.pure()
  });


  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    FullName? fullName,
    Email? email,
    Password? password,
    Password? repeatPassword,
    bool? isValid,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    password: password ?? this.password,
    repeatPassword: repeatPassword ?? this.repeatPassword,
    isValid: isValid ?? this.isValid,
  );

  @override
  String toString() {
    return '''
LoginFormState:
  isPosting: $isPosting  
  isFormPosted: $isFormPosted  
  isValid: $isValid  
  email: $email  
  password: $password  
''';
  }

}