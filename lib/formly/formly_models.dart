part of formly;


typedef ValidatorFn = String Function (dynamic model, FieldConfig field);
typedef AsyncValidatorFn = Future<dynamic> Function (dynamic model, FieldConfig field);
typedef FormlyWidgetBuilder = Widget Function(
    BuildContext context, FieldConfig field, FormlyBloc bloc);
typedef HideFn = bool Function(FieldConfig, dynamic model);

class FieldConfig {
  String key;
  String type;
  String id;
  String name;
  dynamic defaultValue;
  dynamic value;
  List<FieldConfig> fields;
  List<SelectOption> options;
  FormlyTemplateOptions templateOptions;
  List<String> optionsTypes;
  bool hide;
  bool disabled;
  String errorText;
  Function expressionProperties;
  HideFn hideFunction;
  Function onChange;
  String hideExpression;

  List<FormlyValidator> validators;
  List<AsyncFormlyValidator> asyncValidators;

  bool isTouched;
  bool isValid;
  
}

class FormlyTemplateOptions {
  String type;
  String label;
  String placeholder;
  Icon icon;
  String hint;
  Color fillColor;
  bool obscureText;
  bool disabled;
  dynamic options;
  int rows;
  int cols;
  String description;
  bool hidden;
  int max;
  int min;
  int maxLength;
  int minLength;
  RegExp pattern;
  bool required;
}

class SelectOption {
  String name;
  dynamic value;

  @override
  operator == (other) {
    return other is SelectOption &&
      this.name == other.name &&
      this.value == other.value;
  }

  @override
  int get hashCode => 
    this.name.hashCode ^ this.value.hashCode;

}

abstract class FormlyBaseValidator{
  String name;

}
class FormlyValidator extends FormlyBaseValidator {
  bool onChange = false;  
  ValidatorFn validator;
}
class AsyncFormlyValidator extends FormlyBaseValidator {
  bool onChange = false;  
  String message;
  AsyncValidatorFn validator;
}


