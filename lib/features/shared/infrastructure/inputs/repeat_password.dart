import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// Define input validation errors
enum RepeatPasswordError { notEqual }

// Extend FormzInput and provide the input type and error type.
class RepeatPassword extends FormzInput<String, RepeatPasswordError> {

  final Password password;

  // Call super.pure to represent an unmodified form input.
  const RepeatPassword.pure(this.password) : super.pure('');

  // Call super.dirty to represent a modified form input.
  const RepeatPassword.dirty( String value, this.password ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == RepeatPasswordError.notEqual ) return 'Las contraseñas no coinciden';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  RepeatPasswordError? validator(String value) {

    if (value != password.value) return RepeatPasswordError.notEqual;

    return null;
  }
}