part of 'background_image_bloc.dart';

abstract class BackgroundImageEvent {}

class UpdateBackgroundImage extends BackgroundImageEvent {
  final String description;

  UpdateBackgroundImage(this.description);
}
