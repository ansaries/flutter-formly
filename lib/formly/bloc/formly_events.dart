part of formly;
abstract class ModelEvents {}

class ModelChangeEvent extends ModelEvents {
  final Map<dynamic, dynamic> model;
  ModelChangeEvent({
    @required this.model,
  });
}

class PropertyChangeEvent extends ModelEvents {
  final String property;
  final value;

  PropertyChangeEvent({
    @required this.property,
    @required this.value,
  });
}
class FormSubmitEvent extends ModelEvents {  
  final Map<dynamic, dynamic> model;
  FormSubmitEvent({this.model});
}
class AddFormErrorEvent extends ModelEvents {  
  String error;
  AddFormErrorEvent({this.error});
}
class RemoveFormErrorEvent extends ModelEvents {  
  String error;
  RemoveFormErrorEvent({this.error});
}
