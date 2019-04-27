part of formly;

class _DateTimePicker extends StatefulWidget {
  const _DateTimePicker({
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
  __DateTimePickerState createState() => __DateTimePickerState();
}

class __DateTimePickerState extends State<_DateTimePicker> {
  TimeOfDay _time;
  DateTime _date;

  void initState() {
    super.initState();
    _time = TimeOfDay.fromDateTime(widget.initialDate);
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null) 
    setState(() {
      setTime(picked);
    });
  }

  setTime(TimeOfDay time) {
      _time = time;
      setDate();    
  }

  setDate({DateTime date}) {
    if (date != null)
      _date =
          DateTime(date.year, date.month, date.day, _time.hour, _time.minute);
    else
      _date = DateTime(
          _date.year, _date.month, _date.day, _time.hour, _time.minute);
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
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: InputDropdown(
            valueText: _time.format(context),
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

class FormlyDateTimeFormField extends FormlyFieldBase {
  FormlyDateTimeFormField({Key key, @required this.field, @required this.bloc}) : super(key: key, field: field, bloc:bloc){
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
      : _DateTimePicker(
        labelText: field.templateOptions?.label ?? 'Date Time',
        initialDate: getDateAndTime(),
        icon: field.templateOptions?.icon,
        onChange: (value) => onFieldChange$.add(DateTimeToMap(value))
      );
  }
}
