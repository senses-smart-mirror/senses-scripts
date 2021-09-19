
# How to use scripts

This file will describe the way you can create, build & import new Smart Mirror widgets. Follow the guidelines in order to use out of the box blueprints that will setup a starter kit to develop your new widget. 

  Create widget: will create the folder structure and install dependencies. By default the helper class (Typescript) will also be set up. 
  Build widget: build the widget for production. Build the Vue files and build the helper files and package everything into a zip file. 
  Import widget: import zip file (which contains the widget) onto the Smart Mirror. After importing the widget will show up in the Smart Mirror App. 

## Build multiple widgets
The following command will build all widgets inside the specified folder. 

```$ sh scripts/build-widgets.sh $folder```

So you would use it like this: 

```$ sh scripts/build-widgets.sh wigdets```


## Build one widget
This command will build the 'my-new-widget' widget in the 'widgets' folder.

```$ sh scripts/build-widget.sh $folder/$widgetName ```

So you would use it like this:

```$ sh scripts/build-widget.sh widgets/my-new-widget ```


## Create a widget
The following command will generate a Smart Mirror widget based on a blueprint.

```$ sh scripts/create-widget.sh $widgetName $folder ```

So you would use it like this:

```$ sh scripts/create-widget.sh my-new-widget widgets ```