import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/features/forgot_password/domain/usecases/forgot_password_usecase.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordCubit(this.forgotPasswordUseCase)
    : super(const ForgotPasswordInitial());

  Future<void> sendPasswordResetEmail(String email) async {
    emit(const ForgotPasswordLoading());

    final result = await forgotPasswordUseCase.call(email);

    result.fold(
      (failure) => emit(ForgotPasswordFailure(failure.message)),
      (code) => emit(
        ForgotPasswordSuccess('Password reset code sent to your email!', code),
      ),
    );
  }
}
