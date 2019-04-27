part of formly;


class FormlyRadioGroupField extends FormlyFieldBase {
  final FieldConfig field;
  final FormlyBloc bloc;  
  
  FormlyRadioGroupField({Key key, this.field, this.bloc}) : super(key: key, field: field, bloc:bloc) {    
    superInit();
    _radioList = getRadios() ?? [];
    var t = _radioList.firstWhere((item) => item.value?.value == bloc.modelValue[field.key], orElse: () => _radioList[0]);
    _selectedItem =  t!= null ? t.value : _radioList[0].value;       
  }  
  List<RadioListTile<SelectOption>> _radioList;
  SelectOption _selectedItem;

  List<Widget> getRadios() {
    return field.options.map((o) => RadioListTile(
        value: o,
        groupValue: _selectedItem,
        onChanged: (value) { 
          _selectedItem = value;
          onFieldChange$.add(value.value);
        },
        controlAffinity: ListTileControlAffinity.trailing,
        title: Text(o.name ?? o.value),       
      //  subtitle: o.hint != null ? Text(o.hint) : null,
     )).toList();    
  }
  bool get hasError => field?.errorText != null;

  @override
  Widget buildField(BuildContext context) {    
    return Stack(
      children: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(field.templateOptions?.label ?? '', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          top: 16,
        ),
        Container(child: Column(children: getRadios()), padding: EdgeInsets.only(top: 20, bottom: 20),),
        Positioned(
          bottom: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: !hasError? 0 : 15,            
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(field.errorText ?? '', style: TextStyle(color: Colors.red, fontSize: 12)),
            ),
          ),
        )
      ],
    );
  }  
}