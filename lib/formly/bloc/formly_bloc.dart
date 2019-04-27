part of formly;

abstract class IFormlyBloc{
  List<FieldConfig> get fields;
  Function(ModelEvents) get changeEvent;
  dynamic get modelValue;
  dynamic get valid;
  Stream<dynamic> get onSubmit;
  Stream<dynamic> get onModelChanges;
}

class FormlyBloc extends Object with 
  Validators implements IFormlyBloc
{
  bool _valid;
  dynamic _model;
  List<FieldConfig> _fields;

  @override
  List<FieldConfig> get fields => _fields;
  final _modelStateController = BehaviorSubject<dynamic>();
  final _formSubmitController = BehaviorSubject<dynamic>();
  final _modelEventController = BehaviorSubject<ModelEvents>();
  
  // Return data as stream
  @override
  Stream<dynamic> get onModelChanges => _modelStateController.stream;
  @override
  Stream<dynamic> get onSubmit => _formSubmitController.stream;
  
  @override
  dynamic get modelValue => _model;
  @override
  dynamic get valid => _valid;

  // change data
  @override
  Function(ModelEvents) get changeEvent => _modelEventController.sink.add;
  

  FormlyBloc(dynamic model, List<FieldConfig>fields) {
    _model = model;
    this._fields = fields;

    _modelEventController
    .listen(_mapEventToState);
  }

  void _mapEventToState(ModelEvents event) {
    if (event is PropertyChangeEvent) {
      _model[event.property] = event.value;
      _modelStateController.add(_model);
    }

    if(event is ModelChangeEvent) {
      _model = event.model;
      _modelStateController.add(_model);
    }


    if(event is AddFormErrorEvent) {      
      _errors.add(event.error);
    }

    if(event is RemoveFormErrorEvent) {      
      _removeError(event.error);
    }

  }
  
  

  
  dispose() {
    _modelStateController.close();
    _modelEventController.close();
    _formSubmitController.close();
  }

  
}
