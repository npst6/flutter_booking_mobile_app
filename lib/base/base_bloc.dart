///Note file base_bloc.dart

///
abstract class BaseBloc {
  void init();    ///
  void dispose(); ///
}

enum UIState {
  LOADING,
  SUCCESS,
  ERROR,
  UPDATED,
  NONE,
}