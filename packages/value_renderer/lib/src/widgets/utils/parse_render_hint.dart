import 'package:enmeshed_types/enmeshed_types.dart';

RenderHintsEditType parseEditType(String editType) {
  switch (editType) {
    case 'InputLike':
      return RenderHintsEditType.InputLike;
    case 'ButtonLike':
      return RenderHintsEditType.ButtonLike;
    case 'RadioButtonLike':
      return RenderHintsEditType.RadioButtonLike;
    case 'SelectLike':
      return RenderHintsEditType.SelectLike;
    case 'SliderLike':
      return RenderHintsEditType.SliderLike;
    case 'Complex':
      return RenderHintsEditType.Complex;
    case 'Secret':
      return RenderHintsEditType.Secret;
    case 'TextArea':
      return RenderHintsEditType.TextArea;
    case 'Upload':
      return RenderHintsEditType.Upload;
    default:
      return RenderHintsEditType.InputLike;
  }
}

RenderHintsTechnicalType parseTechnicalType(String technicalType) {
  switch (technicalType) {
    case 'Boolean':
      return RenderHintsTechnicalType.Boolean;
    case 'Float':
      return RenderHintsTechnicalType.Float;
    case 'Integer':
      return RenderHintsTechnicalType.Integer;
    case 'Object':
      return RenderHintsTechnicalType.Object;
    case 'String':
      return RenderHintsTechnicalType.String;
    default:
      return RenderHintsTechnicalType.String;
  }
}

RenderHintsDataType parseDataType(String dataType) {
  switch (dataType) {
    case 'Country':
      return RenderHintsDataType.Country;
    case 'DataURL':
      return RenderHintsDataType.DataURL;
    case 'EMailAddress':
      return RenderHintsDataType.EMailAddress;
    case 'HEXColor':
      return RenderHintsDataType.HEXColor;
    case 'Language':
      return RenderHintsDataType.Language;
    case 'PhoneNumber':
      return RenderHintsDataType.PhoneNumber;
    case 'URL':
      return RenderHintsDataType.URL;
    case 'FileReference':
      return RenderHintsDataType.FileReference;
    case 'Date':
      return RenderHintsDataType.Date;
    case 'DatePeriod':
      return RenderHintsDataType.DatePeriod;
    case 'DateTime':
      return RenderHintsDataType.DateTime;
    case 'DateTimePeriod':
      return RenderHintsDataType.DateTimePeriod;
    case 'Time':
      return RenderHintsDataType.Time;
    case 'TimePeriod':
      return RenderHintsDataType.TimePeriod;
    case 'Day':
      return RenderHintsDataType.Day;
    case 'Month':
      return RenderHintsDataType.Month;
    case 'Year':
      return RenderHintsDataType.Year;
    default:
      return RenderHintsDataType.Country;
  }
}
