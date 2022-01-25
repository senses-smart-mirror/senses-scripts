
<p align="center"><a href="https://senses-mirror.io" target="_blank"><img width="360" alt="senses-logo-full" src="https://user-images.githubusercontent.com/3399093/134037048-2add52f7-05f8-4c8d-a25c-fa590d97b01c.png"></a></p>

# Senses - Smart Mirror Scripts
Severals scripts to work with the Senses - Smart Mirror software.

 > Please note that you can also use Senses CLI. You can find it on NPM. [Senses CLI](https://senses-smartmirror.com).

## Installation 

For a full installation on Raspberry Pi use the following: 

```bash -c  "$(curl -sL https://raw.githubusercontent.com/senses-smart-mirror/senses-scripts/main/lib/raspberry-pi-install.sh)"```

## How to use

The following will describe how you can create, build & import new Senses - Smart Mirror widgets. Follow the guidelines in order to use blueprints that will setup a starter kit to develop your new widget. 

**Create widget**: will create the folder structure and install dependencies. By default the helper class (Typescript) will also be set up. 

**Build widget**: build the widget for production. Build the Vue files and build the helper files and package everything into a zip file. 

**Import widget**: import zip file (which contains the widget) onto the Smart Mirror. After importing the widget will show up in the Smart Mirror App. 


## Build multiple widgets
The following command will build all widgets inside the specified folder. 

```$ sh scripts/build-widgets.sh $folder```

So you would use it like this inside the 'widgets' folder:

```$ sh scripts/build-widgets.sh widgets```


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


## Import Widget
The following command will import a widget zipfile onto the Senses - Smart Mirror.
