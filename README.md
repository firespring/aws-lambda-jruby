# aws-lambda-jruby
Run ruby code on JRuby on AWS Lambda Java

This is a Dockerized gradle project for packaging a Ruby project into a zip file for execution in AWS Lambda using the Java 8 runtime.

# Example Usage
1. Create a directory `my_ruby_lambda`, and a directory `project` within `my_ruby_lambda`. 

2. Add your Ruby code to a file named `main.rb` within the `project` directory. Add to the `project` directory a `Gemfile` and any other files that you're `main.rb` script will need.

3. Create an output directory called `build` within the `my_ruby_lambda` directory.

  
  The directory structure might look something like this:

```
my_ruby_lambda
└───build
└───project
    │   Gemfile
    │   main.rb
    │
    └───lib
        │   awesome_sauce.rb
        │   ...
```

4. Build a Lambda `.zip` file named `my_ruby_lambda.zip` and output it to the `build` directory using this command:

      [from within the `my_ruby_lambda` directory]

      ```docker run -v $(pwd)/project:/usr/src/code/my_ruby_lambda -v $(pwd)/build:/usr/src/build firespring/aws-lambda-jruby```

5. Create an AWS Lambda fuction on AWS
  put "AWSLambdaJRuby::handler" to handler setting
  
6. Upload zip the file that was created
  (`my_ruby_lambda/build/my_ruby_lambda.zip`)
 
7. Run Lambda function
