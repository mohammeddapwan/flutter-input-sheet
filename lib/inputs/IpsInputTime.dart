import 'package:flutter/widgets.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:input_sheet/inputs/IpsInput.dart';
import 'package:intl/intl.dart';

class IpsInputTime extends IpsInput {
  final Function(String) _onDone;
  final String value;
  final String format;
  final String pickerFormat;
  final int minuteDivider;
  final DateTimePickerLocale locale;
  final DateTime minDateTime;
  final DateTime maxDateTime;

  final _IpsInputTime state = _IpsInputTime();

  IpsInputTime(
    this._onDone, {
    this.value,
    this.minDateTime,
    this.maxDateTime,
    this.locale = DateTimePickerLocale.en_us,
    this.format = "HH:mm:ss",
    this.pickerFormat = "HH|mm|ss",
    this.minuteDivider = 1,
  });

  @override
  onDone() {
    if (_onDone != null) {
      state.done();
    }
  }

  @override
  State<StatefulWidget> createState() => state;
}

class _IpsInputTime extends State<IpsInputTime> {
  DateTime _currentDatetime;

  void done() {
    this
        .widget
        ._onDone(new DateFormat(this.widget.format).format(_currentDatetime));
  }

  @override
  void initState() {
    super.initState();
    _currentDatetime = this.widget.value == null
        ? DateTime.now()
        : new DateFormat(this.widget.format).parse(this.widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return TimePickerWidget(
      locale: this.widget.locale,
      pickerTheme: DateTimePickerTheme(
        showTitle: false,
      ),
      dateFormat: this.widget.pickerFormat,
      minDateTime: this.widget.minDateTime,
      maxDateTime: this.widget.maxDateTime,
      minuteDivider: this.widget.minuteDivider,
      initDateTime: this._currentDatetime,
      onChange: (DateTime newValue, List<int> ints) {
        setState(() {
          _currentDatetime = newValue;
        });
      },
    );
  }
}
