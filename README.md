# Rendr CLI [![Build Status](https://travis-ci.org/technicolorenvy/rendr-cli.png)](https://travis-ci.org/technicolorenvy/rendr-cli)


The goal of Rendr CLI is to provide the ablility to generate [Rendr](https://github.com/airbnb/rendr) apps and app components quickly and efficiently.

##Due to recent priority shifts and the launch of my current muli-year side project, 'child 1.0' I am shopping for a maintainer for this project. If you are interested, please message me.


## Getting Started

Assuming Node and npm are present and accounted for, install the Rendr CLI with:

    npm install rendr-cli -g


## Usage

    Usage: rendr <command> [options]

    Options:

      -h, --help                       output usage information
      -V, --version                    output the version number
      -c, --coffee                     generators in Coffeescript
      -u, --url <url>                  Set a url (evaluated when generating a model or collection)
      -a, --api <api>                  Set an apiHost (evaluated when generating a model or collection)
      -i, --idAttribute <idAttribute>  Set an idAttribute (evaluated when generating a model)
      --addCollection                  Will generate the corresponding collection (evaluated when generating a model
      --noTemplates                    Do not generate templates (evaluated when generating a view)

    Commands:

       n, new <appName>                               Creates a new Rendr project
       g, generate <component> <name> [options]       Generate a model/view/controller/scaffold with <name>
       g, generate collection <modelName> [options]   Generate a collection with <modelName>


### Creating a Rendr App
The `rendr new` command creates a new Rendr application with a default directory structure
and configuration relative to the directory you are executing the command from.

For example:

    rendr new APPNAME

This generates a skeletal Rendr installation in `<current path>/APPNAME`.


### Generating Models:
By default, generating a model will provide you a bare-bones scaffolded model file.

For example:

    rendr generate model MODELNAME

This generates a nearly empty model at `APPNAME/app/models/MODELNAME`

You may make the model more useful by optionally setting the `--url`, `--idAttrubute`,
or `--api` options. These flagnames match exactly the resulting keys, and values,
that are produced in the generated model.

Additionally, you may also pass the `--addCollection` option which will generate a corresponding collection for your model.


### Generating Collections
When generating a collection, like the model generator, pass the model name that you wish to associate the collection with.

For example:

    rendr generate collection MODELNAME

You may make the collection more useful by optionally setting the `--url`, or `--api` options. These flagnames match exactly the resulting keys, and values, that are produced in the generated collection.


### Generating Views:
Generating a view will produce multiple bare view files. One for each action (`index`, if none are specified).

Additionally, views will automatically generate the associated templates directories/files unless the `--noTemplates` option is specified

If you wish to add more actions to your view, beyond the default `index` action you may pass additional arguments to the generator like so

For example

    rendr generate view VIEWNAME ACTION1 ACTION2 ACTION3

Will generate the `ACTION1`, `ACTION2`, and `ACTION3` view files in the `APPNAME/app/views/VIEWNAME` directory.
AND templates for `ACTION1`, `ACTION2`, and `ACTION3` in the `APPNAME/app/templates/VIEWNAME` directory.


### Controllers:
Controller files will be generated with an entry for each action (`index`, if none are specified).

Like views, if you wish to add more actions to your controller, beyond the default `index` action, you may pass additional arguments to the generator like so

For example

    rendr generate controller CONTROLLERNAME ACTION1 ACTION2 ACTION3

Will generate the `ACTION1`, `ACTION2`, and `ACTION3` controller entries in the `APPNAME/app/controllers/CONTROLLERNAME` file.

### Scaffolds:
Scaffolds will generate views and controllers, as such they follow all the same rules and optional flags

For example

    rendr generate scaffold SCAFFOLDNAME ACTION1 ACTION2 ACTION3

Will generate the `ACTION1`, `ACTION2`, and `ACTION3` view files in the `APPNAME/app/views/SCAFFOLDNAME` directory.  
AND templates for `ACTION1`, `ACTION2`, and `ACTION3` in the `APPNAME/app/templates/SCAFFOLDNAME` directory.  
AND generate the `ACTION1`, `ACTION2`, and `ACTION3` controller entries in the `APPNAME/app/controllers/SCAFFOLDNAME` file.  


## Contributing
If you have a bug fix or feature proposal, submit a pull request with a clear description of the change, plus tests.

## License
Copyright (c) 2013 Joseph (Jos) Smith  
Licensed under the MIT license.
