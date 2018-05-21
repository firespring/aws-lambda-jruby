# aws-lambda-jruby
Run ruby code via JRuby on AWS Lambda (java)

This is a Dockerized gradle project for packaging a Ruby project into a zip file for execution in AWS Lambda using the Java 8 runtime.

### Building
* Create a ruby project in a directory `my_ruby_lambda`
  * The project directory should contain a `Gemfile` for any external libraries you are using
    * This file may be blank
  * The project directory should contain a `main.rb` ruby file which will be the entrypoint for the lambda

* Add any other ruby code you need
  * The directory structure might look something like this:
```
|-- my_ruby_lambda
    |-- Gemfile
    |-- main.rb
    |-- lib
        |-- awesome_sauce.rb
        |-- ...
```

* Build `app.zip` in the project directory
  * `docker run -v my_ruby_lambda:/usr/src/code firespring/aws-lambda-jruby`

### Execution
* Create an AWS Lambda fuction on AWS
  * Use an appropriate name
  * Set the runtime to `Java 8`
  * Set an appropriate role for the lambda

* Upload the lambda function code
  * Code entry type should be `.ZIP file`
  * Runtime should be `Java 8`
  * Set the handler value to `AWSLambdaJRuby::handler`
  * Click `Upload` and select `app.zip`
  * Save your changes

* You can now run your lambda
  * **NOTE: The first time your lambda runs it may take up to 60 seconds to execute**
  * (subsequent executions should be sufficiently fast)
