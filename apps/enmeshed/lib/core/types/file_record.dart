import 'package:enmeshed_types/enmeshed_types.dart';

typedef FileRecord = ({FileDVO file, LocalAttributeDVO? fileReferenceAttribute});

FileRecord createFileRecord({required FileDVO file, LocalAttributeDVO? fileReferenceAttribute}) {
  return (file: file, fileReferenceAttribute: fileReferenceAttribute);
}
