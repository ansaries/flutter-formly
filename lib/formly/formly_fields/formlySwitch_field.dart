part of formly;

class FormlySwitchFormField extends FormlyFieldBase {
  final FieldConfig field;
  final FormlyBloc bloc;  
  bool _value = false;
  FormlySwitchFormField({Key key, this.field, this.bloc}) : super(key: key, field:field, bloc:bloc) {
    _value = bloc.modelValue[field.key] ?? false;
    superInit();
  }

  @override
  Widget buildField(BuildContext context) {
    return Container(
      // color: Colors.white,      
      child: SwitchListTile(
        title: Text(field.templateOptions?.label ?? ''),
        value: _value,
        onChanged: _onChange,
        secondary: field.templateOptions?.icon ?? Container(),
      )
    );
  }

  void _onChange(bool value) {    
      _value = value;      
      onFieldChange$.add(value);
  }

}