abstract class NewsState {}

class InitState extends NewsState {}

class ChangeBottomNavi extends NewsState {}

class LoadingNewsState extends NewsState {}

class SuccessNewsState extends NewsState {}

class ErrorNewsState extends NewsState {
  var error;
  ErrorNewsState(this.error);
}

class changeCAtegoryState extends NewsState {}

class changeCountryyState extends NewsState {}

class changeArchiveState extends NewsState {}

class SearchLoadingState extends NewsState {}

class SearchGet extends NewsState {}

class SearchErrorState extends NewsState {
  var error;
  SearchErrorState(this.error);
}

class LoadingfirebaseState extends NewsState {}

class SuccesspushfirebaseState extends NewsState {}

class SuccessgetfirebaseState extends NewsState {}

class SuccessdeletefirebaseState extends NewsState {}

class ErrorfirebaseState extends NewsState {
  var error;
  ErrorfirebaseState(this.error);
}
