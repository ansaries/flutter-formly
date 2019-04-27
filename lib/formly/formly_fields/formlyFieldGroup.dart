part of formly;

class FormlyFieldGroup extends StatelessWidget {
  FormlyFieldGroup({Key key, this.field, this.fields, this.bloc}) : super(key: key);
  final FieldConfig field;
  final List<FieldConfig> fields;
  final FormlyBloc bloc;
  
  @override
  Widget build(BuildContext context) {        
    return FormlyForm(
          fields: fields,
          model: bloc.modelValue[field.key] ??  Map(),
          onChange: _onChange );
  }

  void _onChange(dynamic _model) {
    bloc.changeEvent(
      PropertyChangeEvent(
        property: field.key,
        value: _model,
      ),
    );

    if(field.onChange != null) {
      field.onChange(_model);
    }
  }
}
