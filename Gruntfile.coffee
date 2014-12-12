module.exports = (grunt) ->
  cfg = grunt.file.readJSON("brew.json");
  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    cfg: cfg

    # Tasks
    clean:
      build: [
        "<%= cfg.directories.tmp.js %>", 
        "<%= cfg.directories.tmp.css %>",
        "<%= cfg.directories.dist %>",
        "<%= cfg.directories.www %>" 
      ]

    jade: 
      compile: 
        options: 
          pretty: true
          data: 
            debug: true
        files: [
          expand: true
          cwd: "<%= cfg.directories.src %>/jade"
          src: "**/**/**/*.jade"
          ext: ".html"
          dest: "<%= cfg.directories.tmp.html %>"
        ]

    coffee: 
      compile: 
        options: 
          bare: true
        files: [
          expand: true
          src: "**/**/**/*.coffee"
          cwd: "<%= cfg.directories.src %>"
          ext: ".js"
          dest: "<%= cfg.directories.tmp.js %>"
        ]

    sass: 
      dist: 
        options: 
          compass: true
          style: 'expanded'
       
        files: [
          expand: true
          src: "<%= cfg.directories.src %>/**/**/**/*.sass"
          dest: "<%= cfg.directories.tmp.css %>"
          ext: '.css'
        ]

    transpile: 
      build: 
        type: 'amd'
        moduleName: (path) ->
          return "app" + path; 
        files: [
          {
            expand: true
            cwd: "<%= cfg.directories.tmp.js %>"
            src: '**/**/**/*.js'
            dest: "<%= cfg.directories.tmp.transpiled %>"   
          }
        ] 

    bower: 
      install: 
        options:
          targetDir: "<%= cfg.directories.tmp.bower %>"
          layout: 'byType'
          install: true
          verbose: false
          cleanTargetDir: false
          cleanBowerDir: false
          bowerOptions: {}

    concat:
      build: 
        files: 
          "<%= cfg.directories.dist %>/vendor.js": cfg.directories.vendor,
          "<%= cfg.directories.dist %>/app.js": ["<%= cfg.directories.tmp.js %>/**/**/**/*.js"]
          "<%= cfg.directories.dist %>/bundle.js": ["<%= cfg.directories.tmp.transpiled %>/**/**/**/*.js"]
          "<%= cfg.directories.dist %>/vendor.css": ["<%= cfg.directories.tmp.bower %>/**/**/**/*.css"]
          "<%= cfg.directories.dist %>/app.css": ["<%= cfg.directories.tmp.css %>/**/**/**/*.css"]

    copy:
      build:
        files: [
          {
            expand: true
            cwd: "<%= cfg.directories.tmp.html %>"
            src: ["**/**/**/*"]
            dest: "<%= cfg.directories.www %>"
            filter: "isFile"
          }
          {
            expand: true
            cwd: "<%= cfg.directories.assets %>"
            src: ["**/**/**/*"]
            dest: "<%= cfg.directories.www %>"
            filter: "isFile"
          }
          {
            expand: true
            cwd: "<%= cfg.directories.dist %>"
            src: ["**/**/**/*.js"]
            dest: "<%= cfg.directories.www %>/js"
            filter: "isFile"
          }
          {
            expand: true
            cwd: "<%= cfg.directories.dist %>"
            src: ["**/**/**/*.css"]
            dest: "<%= cfg.directories.www %>/css"
            filter: "isFile"
          }
          
        ]

      
    uglify:
      options:
        banner: ""
        mangle: false
      build: 
        files: 
          "<%= cfg.directories.dist %>/vendor.min.js": [
            "<%= cfg.directories.dist %>/vendor.js"
          ]
          "<%= cfg.directories.dist %>/app.min.js": [
            "<%= cfg.directories.dist %>/app.js"
          ]
          "<%= cfg.directories.dist %>/bundle.min.js": [
            "<%= cfg.directories.dist %>/bundle.js"
          ]
          
    cssmin: 
      build: 
        files: 
          "<%= cfg.directories.dist %>/vendor.min.css": [
            "<%= cfg.directories.dist %>/vendor.css"
          ]
          "<%= cfg.directories.dist %>/app.min.css": [
            "<%= cfg.directories.dist %>/app.css"
          ]
    
    watch: 
      build: 
        files: "<%= cfg.directories.src %>/**/**/**/*.*"
        tasks: ['brew']
        options: 
          livereload: true

    connect: 
      server: 
        options: 
          port: 3333
          hostname: '*'
          livereload: true
          keepalive: false
          base: "<%= cfg.directories.www %>"


  

  grunt.loadNpmTasks('grunt-bower-task')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks("grunt-contrib-uglify")
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-es6-module-transpiler')
  
  grunt.registerTask 'brew', 'Deploy Task', (target) ->
    buildTasks = ["clean","jade","coffee", "sass", "concat:build","cssmin:build","uglify:build","transpile", "copy:build"]
    grunt.log.writeln("== Brew Task Running ==")
  

    switch target  
      when "server"
        grunt.log.writeln("== Target Server ==")
        buildTasks.push("connect")
        buildTasks.push("watch")
      when "watch"
        grunt.log.writeln("== Target Watch ==")
        buildTasks.push("watch")
      else 
        # TODO

    # Running build tasks   
    grunt.task.run(buildTasks)
    
  # Default task(s).
  grunt.registerTask "default", ["brew:server"]