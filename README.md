# Sharkbone

NOTE: The current version is still under development, chances are the first release is coming in the next few days...

Sharkbone was born from project needs for a controlled view managing system. It works on top of the popular javascript MVC framework BackboneJS, which means an application must be structured with BackboneJS in order to use Sharkbone.

This little library aims to make it easy to create heavy client-side applications that communicate with a RESTful API.

## Installation

To make use of Sharkbone, one must include the file opal-ext.js after Backbone itself has been defined.

## Usage

Sharkbone defines the Sharkbone namespace, and within it the following constructors:

1. Collection
2. Model
3. Router
4. View
5. ViewManager
6. Desktop
7. Mixin

Notice the name of constructors from 1 to 4, these extend their homologous from the Backbone namespace and you should extend from the ones under Sharkbone to get Opal's behavior.

### Collection

### Model

### Router

### View

### ViewManager

### Desktop

### Mixin

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
