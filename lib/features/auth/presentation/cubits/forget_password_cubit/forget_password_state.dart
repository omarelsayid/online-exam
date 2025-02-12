import 'package:online_exam/core/utils/base_api_state.dart';

class ForgetPasswordViewModelState {
  late BaseApiState forgetPasswordState;
  ForgetPasswordViewModelState(this.forgetPasswordState);
  ForgetPasswordViewModelState.initial() {
    forgetPasswordState = BaseIdleState();
  }
}
