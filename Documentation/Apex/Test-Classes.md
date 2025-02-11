## Unit Tests for Triggers  

The following are the benefits of Apex unit tests:
* Ensuring that your Apex classes and triggers work as expected
* Having a suite of regression tests that can be rerun every time classes and triggers are updated to ensure that future updates you make to your app don’t break existing functionality
* Meeting the code coverage requirements for deploying Apex to production or distributing Apex to customers via packages
* High-quality apps delivered to the production org, which makes production users more productive
* High-quality apps delivered to package subscribers, which increase your customers trust

# Writing Tests

Testing is the key to successful long-term development and is a critical component of the development process. Most projects are now focused on using a test-driven development process, that is, test development that occurs at the same time as code development.

To facilitate the development of robust, error-free code, Apex supports the creation and execution of unit tests. Unit tests are class methods that verify whether a particular piece of code is working properly. 

Unit test methods take no arguments, commit no data to the database, send no emails, and are flagged with the testMethod keyword or the @isTest annotation in the method definition. Also, test methods must be defined in test classes, that is, classes annotated with @isTest.

> [!NOTE]
> The testMethod keyword is now deprecated. Use the @isTest annotation on classes and methods instead.

<h3>How to write Test Classes</h3>

While only 75% of your Apex code must be covered by tests, don’t focus on the percentage of code that is covered. Instead, make sure that every use case of your application is covered, including :

* Positive Scenarios
* Negative Scenarios
* Single record and Bulk Data tests
* Tests with multiple user personas


<h3>Note the following key points:</h3>

* Unit tests must cover at least 75% of your Apex code, and all of those tests must complete successfully.
* When deploying Apex to a production organization, each unit test in your organization namespace is executed by default.
* Calls to System.debug are not counted as part of Apex code coverage.
* Test methods and test classes are not counted as part of Apex code coverage.
• Every trigger must have some test coverage, even though coverage might to be as a part of other classes.
• All classes and triggers must compile successfully.


## Cleaning Apex Code
* [Apex Code Analysis Tool using Tooling API and Canvas](https://github.com/afawcett/apex-codeanalysis)
* [Andy Fawcett - Spring Cleaning Apex Code](https://andyinthecloud.com/2013/02/02/spring-cleaning-apex-code-with-the-tooling-api/)
