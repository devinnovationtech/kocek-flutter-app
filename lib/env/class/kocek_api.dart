part of 'package:kocek_app/env/class/kocek_environment.dart';

class KocekApi {
  ///`Dev Server` : http://149.129.217.146:8000/api
  ///`New Dev Server` : http://38.47.180.116/api
  ///`Production Server` : http://103.164.216.46/api
  static const String baseURL = "http://38.47.180.116/api";

  static Future<KocekModel> sendReport({required KocekReportModel model}) async {
    try {
      Response response = await Dio().get(
          "https://script.google.com/macros/s/AKfycbyonUKcBqnCKpywtaYcCYitOzkdjwIJDr4xp_Qw8AAEcyl_DloNzcldB3i3dfuytrAt/exec",
          queryParameters: model.toJson());
      return KocekModel.fromJson(response.data);
    } catch (e) {
      return KocekModel(status: false, message: "$e");
    }
  }

  static Future<bool> keepToken({required String token}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.setString("token", token);
  }

  static Future<bool> setPermission({required String permission}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.setString("permission", permission);
  }

  static Future<bool> removeToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.remove("token");
  }

  static Future<Response<T>> get<T extends Object>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      final dio = Dio();
      dio.addSentry();

      final transaction = Sentry.startTransaction(
        'dio-web-request',
        'request',
        bindToScope: true,
      );
      try {
        final response =  await dio.get<T>(baseURL + path,
            queryParameters: param,
            options: Options(
                headers: {"Authorization": "Bearer ${token!}"},
                receiveTimeout: timeout,
                sendTimeout: timeout));

        transaction.status =
            SpanStatus.fromHttpStatusCode(response.statusCode ?? -1);

        return response;
      } catch (e) {
        log("dio error : $e");
        transaction.throwable = e;
        transaction.status = const SpanStatus.internalError();
        throw Exception(token == null ? "Missing Token" : "$e");
      } finally {
        await transaction.finish();
      }
    } else {
      return await Dio().get<T>(baseURL + path,
          queryParameters: param,
          options: Options(receiveTimeout: timeout, sendTimeout: timeout));
    }
  }

  static Future<Response> download(
      {required String path,
      required String filePath,
      bool withToken = true}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        return await Dio().download(baseURL + path, filePath,
            options: Options(
                headers: {"Authorization": "Bearer ${token!}"},
                receiveTimeout: timeout,
                sendTimeout: timeout));
      } catch (e) {
        throw Exception(token == null ? "Missing Token" : "$e");
      }
    } else {
      return await Dio().download(baseURL + path, filePath,
          options: Options(receiveTimeout: timeout, sendTimeout: timeout));
    }
  }

  static Future<Response<T>> delete<T extends Object>(
      {required String path, bool withToken = true}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        return await Dio().delete<T>(baseURL + path,
            options: Options(
                headers: {"Authorization": "Bearer ${token!}"},
                receiveTimeout: timeout,
                sendTimeout: timeout));
      } catch (e) {
        throw Exception(token == null ? "Missing Token" : "$e");
      }
    } else {
      return await Dio().delete<T>(baseURL + path,
          options: Options(receiveTimeout: timeout, sendTimeout: timeout));
    }
  }

  static Future<Response<T>> post<T extends Object>(
      {required String path,
      bool withToken = true,
      int minute = 1,
      Map<String, dynamic>? formdata,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      log("formdata : $formdata");

      final dio = Dio();
      dio.addSentry();

      final transaction = Sentry.startTransaction(
        'dio-web-request',
        'request',
        bindToScope: true,
      );

      try {
        final response =  await dio.post<T>(baseURL + path,
            queryParameters: param,
            options: Options(
                headers: {"Authorization": "Bearer ${token!}"},
                receiveTimeout: timeout,
                sendTimeout: timeout),
            data: formdata != null ? FormData.fromMap(formdata) : null);

        transaction.status =
            SpanStatus.fromHttpStatusCode(response.statusCode ?? -1);

        return response;
      } catch (e) {
        if(e is DioError){
          log("dio error : ${e.error.toString()}");
        }

        log("dio error : $e");

        transaction.throwable = e;
        transaction.status = const SpanStatus.internalError();

        throw Exception(token == null ? "Missing Token" : "$e");
      } finally {
        await transaction.finish();
      }
    } else {
      return await Dio().post<T>(baseURL + path,
          data: formdata != null ? FormData.fromMap(formdata) : null,
          options: Options(
              receiveTimeout: timeout, sendTimeout: timeout));
    }
  }

  static Future<Response<T>> put<T extends Object>(
      {required String path,
      bool withToken = true,
      Map<String, dynamic>? formdata,
      Map<String, dynamic>? param}) async {
    if (withToken) {
      SharedPreferences storage = await SharedPreferences.getInstance();
      String? token = storage.getString("token");
      try {
        return await Dio().put<T>(baseURL + path,
            queryParameters: param,
            options: Options(
                headers: {"Authorization": "Bearer ${token!}"},
                receiveTimeout: timeout,
                sendTimeout: timeout),
            data: formdata != null ? FormData.fromMap(formdata) : null);
      } catch (e) {
        throw Exception(token == null ? "Missing Token" : "$e");
      }
    } else {
      return await Dio().put<T>(baseURL + path,
          queryParameters: param,
          data: formdata != null ? FormData.fromMap(formdata) : null,
          options: Options(receiveTimeout: timeout, sendTimeout: timeout));
    }
  }

  /// Parsing Error Message Mostly From API
  static String parse(String value) {
    if (value.contains(
        "type 'String' is not a subtype of type 'Map<String, dynamic>'")) {
      return "[1015] Invalid JSON Response\n\nData yang diminta tidak sesuai\n\nHubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains("[DioErrorType.connectTimeout]")) {
      return "[522] Connection Timed Out\n\nServer Membutuhkan Waktu Terlalu Lama untuk Membalas Permintaan Data dari Perangkat Ini\n\nCoba Muat Ulang";
    } else if (value.contains("[DioErrorType.receiveTimeout]")) {
      return "[522] Received Timed Out\n\nPerangkat Membutuhkan Waktu Terlalu Lama untuk Menerima Permintaan Data dari Server\n\nCoba Muat Ulang";
    } else if (value.contains("Http status error [503]")) {
      return "[503] Service Unavailable\n\nLayanan Tidak Tersedia Entah Karena Kelebihan Muatan Atau Sedang Perawatan\n\nTunggu Selama Beberapa Saat Lagi";
    } else if (value.contains("Http status error [500]")) {
      return "[500] Internal Server Error\n\nKesalahan Dalam Server\n\nHubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains('Http status error [429]')) {
      return "[429] Too Many Request\n\nPembatasan Server Karena Terlalu Sering Memuat Halaman\n\nCoba Logout dan Login Kembali atau Tunggu Beberapa Saat Sebelum Memuat Ulang Lagi";
    } else if (value.contains("Http status error [414]")) {
      return "[414] URI Too Long\n\nServer tidak mampu menampung kiriman data dari perangkat\n\nHubungi Pengembang untuk Memperbaikinya";
    } else if (value.contains("Http status error [413]")) {
      return "[413] Request entity too large\n\nServer tidak mampu menampung kiriman data melebihi batasan yang ditentukan\n\nHubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains('Http status error [410]')) {
      return "[410] Gone\n\nJalur Yang Diakses Tidak Tersedia\n\nKembali dan Jelajahi Halaman Lainnya";
    } else if (value.contains("Http status error [405]")) {
      return "[405] Method Not Allowed\n\nServer Tidak Mendukung Permintaan Akses\n\nHubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains("Http status error [404]")) {
      return "[404] Not Found\n\nJalur Yang Diakses Telah Dihapus atau Sudah Dipindahkan\n\nHubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains("Http status error [403]")) {
      return "[403] Forbidden\n\nToken Sudah Kadaluwarsa, sepertinya ada yang menggunakan akunmu diperangkat lain\n\nLog Out dan coba Log In lagi";
    } else if (value.contains("Http status error [302]")) {
      return "[302] Found\n\nSumber daya yang diminta sudah dipindah.\n\nHubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains("Http status error [301]")) {
      return "[301] Moved Permanently\n\nSumber daya yang diminta sudah dipindah.\n\nHubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains("No route to host")) {
      return "[113] No Route to Host\n\nKoneksi Internet Tidak Dapat Mengakses Server.\n\nCoba Periksa Apakah Perangkatmu Terhubung Ke Internet atau Tidak";
    } else if (value.contains("Connection refused, errno = 111")) {
      return "[111] Connection Refused\n\nUpaya Untuk Menghubungkan Server dengan Aplikasi Ditolak.\n\nCoba Tunggu Beberapa Saat Lagi atau Hubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains("Connection reset by peer")) {
      return "[104] Connection Reset By Peer\n\nServer menolak kiriman data.\n\nHubungi Pengembang Untuk Memperbaikinya";
    } else if (value.contains("Network is unreachable, errno = 101")) {
      return "[101] Network Error\n\nJaringan Internet Bermasalah.\n\nCoba Periksa Apakah Perangkatmu Terhubung Ke Internet atau Tidak";
    } else if (value.contains("Broken pipe, errno = 32")) {
      return "[32] Broken Pipe\n\nMasalah dari Jaringan atau dari Sisi Server.\n\nCoba Periksa Apakah Perangkatmu Terhubung Ke Internet atau Hubungi Pengembang Untuk Memperbaikinya";
    } else {
      return value;
    }
  }
}
