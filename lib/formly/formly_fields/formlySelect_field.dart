part of formly;

class FormlySelectFormField extends FormlyFieldBase {
  FormlySelectFormField({Key key, this.field, this.bloc}) : super(key: key, field: field, bloc: bloc){
    _dropDownMenuItems = getDropDownMenuItems() ?? [];
    var t = _dropDownMenuItems.firstWhere((item) => item.value?.value == bloc.modelValue[field.key], orElse: () => _dropDownMenuItems[0]);
    _selectedItem =  t!= null ? t.value : _dropDownMenuItems[0].value;
    superInit();
  }
  final FieldConfig field;
  final FormlyBloc bloc;  
  
  List<DropdownMenuItem<SelectOption>> _dropDownMenuItems;
  SelectOption _selectedItem;

  List<DropdownMenuItem<SelectOption>> getDropDownMenuItems() {
    return field.options.map((o) => DropdownMenuItem(
          value: o,
          child: new Text(o.name)
      )).toList();    
  }

  @override
  Widget buildField(BuildContext context) {
    return Container(
    color: Colors.white,
    
    child: Row(
      children: <Widget>[
        field.templateOptions?.icon != null
          ? Padding(padding: EdgeInsets.only(right: 16), child: field.templateOptions?.icon)
          : Container(),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),            
            child: DropdownButton(
               hint:  SizedBox(
                     width: MediaQuery.of(context).size.width - (field.templateOptions?.icon != null ? 84 : 45),
                     child: Text(field.templateOptions?.label),
               ),               
               value: _selectedItem,
               items: _dropDownMenuItems,
               onChanged: changedDropDownItem,
             
           ),
        ),
      ],
    ),
  );
  }

  void changedDropDownItem(SelectOption selected) {
    _selectedItem = selected;
    onFieldChange$.add(selected.value);
  }

}