part of formly;
abstract class Validators implements IFormlyBloc {
  List<String> _errors = [];

  void onChange(v, FieldConfig field) {
    field.value = v;
    changeEvent(
      PropertyChangeEvent(
        property: field.key,
        value: v,
      ),
    );

    if(field.onChange != null) {
      field.onChange(v);
    }
  }
  bool _updateFieldValidStatus(String r, FieldConfig f, dynamic _val, FormlyBaseValidator v) { 
      f.errorText = r;
      f.isValid = r == null;
      if(!f.isValid) _errors.add('${f.key}-${v.name}');
      else _removeError('${f.key}-${v.name}');
      onChange(_val, f);   
      return !f.isValid;
  }
  validateForm({List<FieldConfig> flds, bool onSubmit = true}) async{
    flds = flds ?? this.fields;
    for(int i=0; i< flds.length; i++) {
      FieldConfig f = flds[i];
      await validateField(f, onSubmit);
    }
    
    if(_errors.length > 0) {
      return false;
    }

    return true;
  }

  validateField(FieldConfig f, bool onSubmit) async {
    if(f.validators !=null && f.validators.length >0) {
      f.validators.forEach((v) {
        if(v.onChange != null && v.onChange || onSubmit) {
          String r = v.validator(modelValue, f);
          _updateFieldValidStatus(r, f, modelValue[f.key], v);
        }
      });
    }
    if(f.asyncValidators!=null && f.asyncValidators.length >0) {
      for(int j=0; j< f.asyncValidators.length; j++) {
        AsyncFormlyValidator v = f.asyncValidators[j];
         if(v.onChange != null && v.onChange || onSubmit) {
          dynamic _v = await v.validator(modelValue, f);
          if(_v == true) {
              _updateFieldValidStatus(null, f, modelValue[f.key], v);
          } else {
            _updateFieldValidStatus(v.message, f, modelValue[f.key], v);
          }
         }
      }        
    }

    if(f.fields != null && f.fields.length > 0){
      validateForm(flds: fields, onSubmit: onSubmit);
    }
  }

  _removeError(name) {
    if(_errors.remove(name)) _removeError(name);
  }
}
