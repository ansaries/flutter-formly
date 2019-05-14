# flutter_formly
Create Dynamic Flutter Forms with customization of field logic from JSON.

## Getting Started
Include flutter_formly in your pubspec.yaml and save to download the package.

### Components
Formly Contains widgets and different types to create a fully functional Flutter form, some of the major types are as follows:
### FormlyForm
A Statefull widget Container to create the all formly fields as a ListView in its builder.
### FieldConfig
A class to create a dynamic field. Field config has following properties:

a. **key** is a the json property of the form Map model.    
b. **type** tell the FormlyForm to create an appropriate field e.g ```..type = 'radio'``` will create a radio type field.    
c. **onChange** call back method on every change event.    
d. **validators** takes an array of ```FormlyValidator``` which runs onChange or onSubmit based on ```FormlyValidator``` bool propery onChange. Each ```FormlyValidator``` class has property validator which is a callback method for validation, which should return null on all times except when error and then it should return an error message string.    
e. **asyncValidators** similar to validators but designed for Future returning validators of type ```AsyncFormlyValidator```. The future should however return a true or false. The message property will be used on error message.    
f. **templateOptions** takes an object of type ```FormlyTemplateOptions``` which has properties for setting ```label```, ```hint``` and ```icon``` for the field.    
g. **options**  takes an array of ```SelectOption``` for type ```radio``` and ```select``` fields.
h. **hideFunction** takes a call back function which if returns true will hide this field.
        
### Create a basic Formly Form
In your builder method of statefull or state less widget use the FormlyForm widget like below:
    
```
    class Demo extends StatefulWidget {
      final Widget child;

      Demo({Key key, this.child}) : super(key: key);

      _DemoState createState() => _DemoState();
    }
    class DemoState extends State<Demo> {
        var _lights = false;
        List<FieldConfig> createFields() {
            return <FieldConfig>[
                FieldConfig()
                ..key = 'radio'
                ..type = 'radio' 
                ..onChange = print
                ..defaultValue = 'female'
                ..validators = [
                  FormlyValidator()
                  ..name = 'male'
                  ..onChange = true
                  ..validator = (model, field) => model[field.key] == 'male' ? null : 'Only Males allowed'
                ]
                ..asyncValidators = [
                  AsyncFormlyValidator()
                  ..name = 'maleAsync'
                  ..message = 'Only Males Allowed'
                  ..onChange = true
                  ..validator = (model, field) => Future.delayed(Duration(seconds: 1)).then((v) => NullThrownError())
                ]
                ..options = [
                  SelectOption()
                  ..name = 'Male'
                  ..value = 'male',
                  SelectOption()
                  ..name = 'Female'
                  ..value = 'female'
                ]            
                ..templateOptions = (FormlyTemplateOptions()
                ..label = 'Label comes here'
                // ..hint = 'Check box hin'
                ..icon = Icon(Icons.label)
                ),
                FieldConfig()
                  ..key = 'select'
                  ..type = 'select'
                  ..onChange = print
                  ..defaultValue = 'female'
                  ..options = [
                    SelectOption()
                      ..name = 'Male'
                      ..value = 'male',
                    SelectOption()
                      ..name = 'Female'
                      ..value = 'female'
                  ]
                  ..templateOptions = (FormlyTemplateOptions()
                    ..label = 'Label comes here'
                  // ..hint = 'Check box hin'
                    ..icon = Icon(Icons.label)
                  ),
                FieldConfig()
                  ..key = 'date'
                  ..type = 'date'
                  ..onChange = print
                  ..templateOptions = (FormlyTemplateOptions()
                    ..label = 'Date'
                  // ..hint = 'Check box hin'
                    ..icon = Icon(Icons.label)
                  ),
                FieldConfig()
                  ..key = 'datetime'
                  ..type = 'datetime'
                  ..onChange = print
                  ..templateOptions = (FormlyTemplateOptions()
                    ..label = 'Date and Time'
                  // ..hint = 'Check box hin'
                    ..icon = Icon(Icons.label)
                  ),
                FieldConfig()
                  ..key = 'switch'
                  ..type = 'switch'
                  ..onChange = print
                  ..templateOptions = (FormlyTemplateOptions()
                    ..label = 'Switch'
                  // ..hint = 'Check box hin'
                    ..icon = Icon(Icons.label)
                  ),
                FieldConfig()
                  ..key = 'check'
                  ..type = 'checkbox'
                  ..onChange = print
                  ..templateOptions = (FormlyTemplateOptions()
                    ..label = 'Switch'
                  // ..hint = 'Check box hin'
                    ..icon = Icon(Icons.label)
                  ),
            ];
        }

        @override
        Widget build(BuildContext context) {
        return Scaffold(     
          body: Container(
            child: FormlyForm(
              fields: createFields(),
              model: {},
              onChange: print,
            ),
          )      
        );
      }
    }

```

### Create a Formly Form with bloc

There are times when you want to validate a form on submittion and/or want to observe change reactively using streams or rxDart subject, you may consider more advanced implementation of the same form like below:

   ```
class Demo extends StatefulWidget {
  final Widget child;

  Demo({Key key, this.child}) : super(key: key);

  _DemoState createState() => _DemoState();
}
class DemoState extends State<Demo> {
    var _lights = false;
    FormlyBloc bloc;
    _DemoState() {
        bloc = new FormlyBloc({}, createFields());
    }
    //... implementation of createFields ommited here...
    @override
    Widget build(BuildContext context) {
    return Scaffold(     
      body: Column(
        children: <Widget>[
          Container(
            child: FormlyForm(
              bloc: bloc,          
              onChange: print,
            ),
          ),
          MaterialButton(
            child: Text('Submit'),
            onPressed: () async {
              if(await bloc.validateForm()) {
                // Form valid here
                print(bloc.modelValue);
              }
              // else errors will show.
            },
          )
        ],
      )      
    );
  }
}

```

