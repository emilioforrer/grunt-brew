# Grunt Brew

Grunt-brew its a set of grunt tasks that help's you to develop faster frontend javascripts applications.

It provides the next features:

* Asset pipeline and precompilers like Jade, Sass with Compass and CoffeeScript. (No more HTML, js and css files)
* A build it server to test your application and with live reload that watch your files.
* A ES6 transpiler so you can try and test the new features of ECMAScript 6 (the next version of javascript)
* Convention Over Configuration


## Installation

* Clone the git repository
* (Install nodejs)[http://nodejs.org/]
* (Install grunt)[http://gruntjs.com/getting-started]
* (Install bower)[http://bower.io/]


## After installation go to the project's root directory and run the next commands

* npm install
* grunt bower:install
* grunt brew:server
* Visit http://0.0.0.0:3333


## In case u have a proxy and bower install gives you a git error, you can try the next

Create a file named `.bowerrc` in your project's root directory and set your proxy


```
{
  "directory": "bower_components",
  "proxy": "http://192.168.5.1:8080",
  "https-proxy": "http://192.168.5.1:8080"
}
```


## Assets pipeline 

By default the project has the next directory structure


```
  app/
    assets/
    jade/
      index.jade
  dist/
  tmp/
    bower/
    build/
  public/
  brew.config

```

### Directories

**`app`:** The main application watch directory any .coffee, .sass that you put in here it will be precompiled

**`app/assets`:** Any file that you put in here it will be copied to the public directory, perfect for assets like images, fonts, etc.

**`app/jade`:** Any .jade file in here it will be precompiled and copied to the public directory

**`dist`:** This is the ouput folder for your precompiled application and vendor assets which by default are:

* **`app.js`:** Concatenated file of all your precompiled coffescript files in `app` directory
* **`app.min.js`:** Minified version of `app.js`
* **`bundle.js`:** ES6 transpiled version of the your precompiled coffescript for you to require
* **`bundle.min.js`:** Minified version of `bundle.js`
* **`vendor.js`:** Concatenated file of all  the third party javascripts (bower, node_modules, or any file that you especify on the brew.config file under the vendor key)
* **`vendor.min.js`:** Minified version of `vendor.js`
* **`app.css`:** Concatenated file of all your precompiled sass files in `app` directory
* **`app.min.css`:** Minified version of `app.css`
* **`vendor.css`:** Concatenated file of all  the third party css especified on the brew.config
* **`vendor.min.css`:** Minified version of `vendor.css`

**`public`:** the root (www) directory of the webserver application

**`tmp`:** output directory for asset precompiles and `grunt bower:install`


### Configuration File

The project has the `brew.json` file to configure the main features such as directories, vendor files, etc. So you can customize it to suit your needs.