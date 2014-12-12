# INSTALATION


* (Install nodejs)[http://nodejs.org/]
* (Install grunt)[http://gruntjs.com/getting-started]
* (Install bower)[http://bower.io/]


## After installation go to the project's root directory and run the next commands

* npm install
* grunt bower:install
* grunt brew:server
* Visit http://0.0.0.0:3333


## In Case u have a proxy and bower install gives you a git error, you can try the next

Create a file named `.bowerrc` in your project's root directory and set your proxy


```
{
  "directory": "bower_components",
  "proxy": "http://192.168.5.1:8080",
  "https-proxy": "http://192.168.5.1:8080"
}
```

