class BaseViewModel extends BaseViewModelInput with BaseViewModelOutput {
  @override
  start() {
    print('start');
  }

  @override
  finish() {
    print('finish');
  }
}

abstract class BaseViewModelInput {
  start();

  finish();
}

abstract class BaseViewModelOutput {}
