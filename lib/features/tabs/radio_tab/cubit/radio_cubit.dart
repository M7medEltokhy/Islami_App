import 'package:bloc/bloc.dart';
import 'package:islami/features/tabs/radio_tab/cubit/radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit() : super(RadioInitial());


  void getRadio() {
    emit(RadioLoading());
    
    emit(RadioSuccess());
  }
}
