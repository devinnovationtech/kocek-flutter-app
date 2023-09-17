import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kocek_app/env/class/kocek_environment.dart';
import 'package:kocek_app/utils/static/constant_variable.dart';

part '../model/kocek_image_uploader_model.dart';
part '../state/kocek_image_uploader_states.dart';

class KocekImageUploaderCubit extends Cubit<KocekImageUploaderStates> {
  KocekImageUploaderCubit() : super(KocekImageUploaderOnIdle());

  Future<void> go({required String path}) async {
    emit(KocekImageUploaderOnGoing());
    await Future.delayed(duration);

    try {
      Response response = await KocekApi.post(
          path: "/checklist/upload-image",
          formdata: {"image": KocekFunction.multipartFile(path)});
      var model = KocekImageUploaderModel.fromJson(response.data);
      if (model.success) {
        emit(KocekImageUploaderOnSucceed(model: model));
      } else {
        emit(KocekImageUploaderOnFailed(model: model));
      }
    } catch (e) {
      emit(KocekImageUploaderOnError(
          model: KocekImageUploaderModel(
              success: false, message: "$e", path: path)));
    }
  }
}
