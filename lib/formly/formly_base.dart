part of formly;



abstract class FormlyFieldBase extends StatelessWidget{
  FormlyFieldBase({Key key, this.field, this.bloc}) : super(key: key);
  final FieldConfig field;
  final FormlyBloc bloc;
  final BehaviorSubject onFieldChange$ = new BehaviorSubject();

  superInit() {
    _checkHideStatus(bloc.modelValue);
    bloc.onModelChanges    
    .listen(_checkHideStatus);
   
    onFieldChange$
    .debounce(Duration(milliseconds: 500))
    .listen((v) => bloc.validateField(field, false));

    onFieldChange$
    .listen((v) => onChange(v));

    
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: bloc.onModelChanges,
      builder: (ctx, snapshot) => buildField(context)
  );

  Widget buildField(BuildContext context) {
    return Center(child: Text('buildField not implemented'));
  }

  void onChange(value) {
    field.isTouched = true;
    field.value = value;

    bloc.changeEvent(
      PropertyChangeEvent(
        property: field.key,
        value: value,
      ),
    );

    if(field.onChange != null) {
      field.onChange(value);
    }
  }
  
  void _checkHideStatus(value) {
    final f = field;
    if (f.hideFunction != null)
      f.hideFunction(f, value) == true ? f.hide = true : f.hide = false;
  }
  
}