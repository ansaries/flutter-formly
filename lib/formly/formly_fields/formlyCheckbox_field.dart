part of formly;


class FormlyCheckboxFormField extends FormlyFieldBase {
  final FieldConfig field;
  final FormlyBloc bloc;  
  bool _value = false;
  FormlyCheckboxFormField({Key key, this.field, this.bloc}) : super(key: key, field: field, bloc:bloc) {
    _value = bloc.modelValue[field.key] ?? false;
    superInit();
  }
  
  @override
  Widget buildField(BuildContext context) {
    return Container(
      // color: Colors.white,      
      child: CheckboxListTile(
        title: Text(field.templateOptions?.label ?? ''),
        subtitle: field.templateOptions.hint !=null ? Text(field.templateOptions.hint) : null,
        value: _value,        
        onChanged: (value) { 
          _value = value;
          onFieldChange$.add(value);
        },
        secondary: field.templateOptions?.icon ?? Container(),
        controlAffinity: ListTileControlAffinity.trailing,
      )
    );
  }
}