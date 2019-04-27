part of formly;

class _DatePicker extends StatefulWidget {
  const _DatePicker({
    Key key,
    this.icon,
    this.labelText,
    @required this.initialDate,
    this.onChange,
  }) : super(key: key);

  final String labelText;
  final DateTime initialDate;
  final ValueChanged<DateTime> onChange;
  final Icon icon;

  @override
  __DatePickerState createState() => __DatePickerState();
}
class __DatePickerState extends State<_DatePicker> {
  DateTime _date;

  void initState() {
    super.initState();
    _date = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1977, 1),
      lastDate: DateTime(2301),
    );
    if (picked != null) 
    setState(() {
      setDate(date: picked);
    });
  }

  setDate({DateTime date}) {
    if (date != null)
      _date = date;
    widget.onChange(_date);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        widget.icon != null
            ? Padding(padding: EdgeInsets.only(right: 16), child: widget.icon)
            : null,
        Expanded(
          flex: 4,
          child: InputDropdown(
            labelText: widget.labelText,
            valueText: DateFormat.yMMMd().format(_date),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),        
      ],
    );
  }
}
class FormlyDateFormField extends FormlyFieldBase {
  FormlyDateFormField({Key key, @required this.field, @required this.bloc}) : super(key: key, field: field, bloc:bloc) {
    superInit();
  }
  final FieldConfig field;
  final FormlyBloc bloc;

  DateTime getDateAndTime() {
    if(bloc.modelValue[field.key] != null)
      return DateTime.fromMillisecondsSinceEpoch(bloc.modelValue[field.key]['\$date']);
    else return field?.defaultValue ?? DateTime.now();
  }

  @override
  Widget buildField(BuildContext context) {
    return field.hide == true
      ? Container()
      : _DatePicker(
        labelText: field.templateOptions?.label ?? 'Date Time',
        initialDate: getDateAndTime(),
        icon: field.templateOptions?.icon,
        onChange: (value) => onFieldChange$.add(DateTimeToMap(value))
      );
  }
}
