part of formly;

class Provider extends InheritedWidget {
  // final bloc = FormlyBloc();


  Provider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static FormlyBloc of(BuildContext context) {
    //* What it does is through the "of" function, it looks through the context of a widget from the deepest in the widget tree
    //* and it keeps travelling up to each widget's parent's context until it finds a "Provider" widget
    //* and performs the type conversion to Provider through "as Provider" and then access the Provider's bloc instance variable
    // return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
