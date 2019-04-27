part of formly;


class FormlyInputFormField extends FormlyFieldBase {
  FormlyInputFormField({Key key, this.field, this.bloc}):super(key: key, field: field, bloc:bloc) {        
    initState();
  }
  final FieldConfig field;
  final FormlyBloc bloc;
  final textController = TextEditingController();
  // final FocusNode textFocus = new FocusNode();


  


  _getKeyboardType(String type) {
    switch (type) {
      case 'text':
        return TextInputType.text;
      case 'number':
        return TextInputType.number;
      case 'email':
        return TextInputType.emailAddress;
      case 'date':
        return TextInputType.datetime;
      case 'phone':
        return TextInputType.phone;
    }
  }

  void initState() {
    textController.text = field.defaultValue ?? (bloc.modelValue[field.key] != null ? bloc.modelValue[field.key].toString() : bloc.modelValue[field.key]);
    textController.selection = new TextSelection(
        baseOffset: textController.text?.length ?? 0,
        extentOffset: textController.text?.length ?? 0);    
    superInit();
    
  }
  

  

  @override
  Widget buildField(BuildContext context) {
    return field.hide == true
      ? Container() 
      : TextField(
          controller: textController,
          
          // focusNode: textFocus,                  
          keyboardType:
              _getKeyboardType(field.templateOptions.type),
          onChanged: onFieldChange$.add,
          maxLines: field.type == 'textarea'
              ? field.templateOptions?.rows ?? 3
              : 1,
          obscureText:
              field?.templateOptions?.obscureText != null
                  ? field.templateOptions.obscureText
                  : false,
          decoration: InputDecoration(
            hintText: field?.templateOptions?.hint,
            labelText: field?.templateOptions?.label,
            icon: field?.templateOptions?.icon,
            fillColor: field?.templateOptions?.fillColor ??
                Colors.transparent,
            enabled: field?.disabled != true,
            errorText: field?.errorText,
          ),
        );
  }
}
