part of 'background_image_bloc.dart';

abstract class BackgroundImageState {
  final String imagePath;
  
  BackgroundImageState(this.imagePath);
}

class BackgroundImageInitial extends BackgroundImageState {
  BackgroundImageInitial() : super('assets/images/default.jpg');
}

class BackgroundImageUpdated extends BackgroundImageState {
  BackgroundImageUpdated(String newPath) : super(newPath);
}
