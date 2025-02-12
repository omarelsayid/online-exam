import 'package:online_exam/core/utils/base_api_state.dart';

class VerifyResetCodeViewModelState {
  late BaseApiState verifyCodeState;
  VerifyResetCodeViewModelState(this.verifyCodeState);
  VerifyResetCodeViewModelState.initial() {
    verifyCodeState = BaseIdleState();
  }
}
