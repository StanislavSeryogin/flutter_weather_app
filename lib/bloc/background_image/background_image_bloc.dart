import 'package:flutter_bloc/flutter_bloc.dart';

part 'background_image_event.dart';
part 'background_image_state.dart';

class BackgroundImageBloc extends Bloc<BackgroundImageEvent, BackgroundImageState> {
  BackgroundImageBloc() : super(BackgroundImageInitial()) {
    on<UpdateBackgroundImage>((event, emit) {
      final newPath = 'assets/images/${event.description.replaceAll(' ', '').toLowerCase()}.jpg';
      emit(BackgroundImageUpdated(newPath));
    });
  }
}
