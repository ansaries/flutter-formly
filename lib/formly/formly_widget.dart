part of formly;



class FormlyForm extends StatefulWidget {
  final List<FieldConfig> fields;
  final Function onChange;
  final dynamic model;
  final FormlyBloc bloc;

  FormlyForm({
    @required this.model,
    @required this.onChange,
    this.fields,
    this.bloc,
  });

  @override
  _FormlyFormState createState() => _FormlyFormState(model: model, bloc: bloc, fields: fields);
}

class _FormlyFormState extends State<FormlyForm> {
  FormlyBloc bloc;
  List<FieldConfig> fields;
  Map<String, Function> formlyWidgetBuilderObject;
  ScrollController _scrollController = ScrollController();
  dynamic model;
  _FormlyFormState({this.model, this.bloc, this.fields}) {
    bloc = bloc ?? new FormlyBloc(model, fields);
    this.fields = bloc.fields;
    // bloc.onChangeEvent(ModelChangeEvent(model: model));
  }
  @override
  void initState() {
    // TODO: implement initState
    bloc.onModelChanges.listen(widget.onChange);
    formlyWidgetBuilderObject = {
      'input': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlyInputFormField(field: field, bloc: bloc,),
      'textarea': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlyInputFormField(field: field, bloc: bloc,),
      'datetime': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlyDateTimeFormField(field: field, bloc: bloc,),
      'date': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlyDateFormField(field: field, bloc: bloc,),
      'select': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlySelectFormField(field: field, bloc: bloc,),
      'switch': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlySwitchFormField(field: field, bloc: bloc,),
      'checkbox': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlyCheckboxFormField(field: field, bloc: bloc,),
      'radio': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlyRadioGroupField(field: field, bloc: bloc,),
      'fieldGroup': (FieldConfig field, BuildContext ctx, FormlyBloc bloc, {List<FieldConfig> fields}) =>
          FormlyFieldGroup(field: field, fields: fields, bloc: bloc,),
    };
    super.initState();
  }
  @override
  Widget build(BuildContext context) {        
    return ListView(
      controller: _scrollController,
      shrinkWrap: true,
      children: fields.map((f) => _selectFormInputField(f, context)).toList(),
    );
  }

  Widget _selectFormInputField(FieldConfig field, BuildContext context) {
    if (field.type != null) {
      if (!formlyWidgetBuilderObject.containsKey(field.type)) {
        return Text('No widget for Type: ${field.type}');
      }
      return formlyWidgetBuilderObject[field.type](field, context, bloc, fields: field.fields);
    } else {
      return Text('No widget for Type: ${field.type}');
    }
  }
}
