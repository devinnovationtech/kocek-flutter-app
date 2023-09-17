part of '../cubit/kocek_image_uploader_cubit.dart';

class KocekImageUploaderStates extends Equatable {
  const KocekImageUploaderStates();

  @override
  List<Object?> get props => [];
}

class KocekImageUploaderOnIdle extends KocekImageUploaderStates {}

class KocekImageUploaderOnGoing extends KocekImageUploaderStates {}

class KocekImageUploaderOnSucceed extends KocekImageUploaderStates {
  const KocekImageUploaderOnSucceed({required this.model});
  final KocekImageUploaderModel model;

  @override
  List<Object?> get props => ["model: $model"];
}

class KocekImageUploaderOnFailed extends KocekImageUploaderStates {
  const KocekImageUploaderOnFailed({required this.model});
  final KocekImageUploaderModel model;

  @override
  List<Object?> get props => ["model: $model"];
}

class KocekImageUploaderOnError extends KocekImageUploaderStates {
  const KocekImageUploaderOnError({required this.model});
  final KocekImageUploaderModel model;

  @override
  List<Object?> get props => ["model: $model"];
}
