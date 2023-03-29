import 'package:enmeshed_types/enmeshed_types.dart';

List<FileDTO> fileListTransformer(dynamic v) => List<FileDTO>.from(v.map((e) => FileDTO.fromJson(e)));
FileDTO fileTransformer(dynamic v) => FileDTO.fromJson(v);

List<TokenDTO> tokenListTransformer(dynamic v) => List<TokenDTO>.from(v.map((e) => TokenDTO.fromJson(e)));
TokenDTO tokenTransformer(dynamic v) => TokenDTO.fromJson(v);
