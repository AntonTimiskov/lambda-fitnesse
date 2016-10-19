# LambdaFitnesse
Run your [Fitnesse](http://fitnesse.org/) tests on [AWS lambda](https://aws.amazon.com/lambda/details/)
- Runs every fitnesse test from suite in parallel
- Permanently stores test history on [AWS S3](https://aws.amazon.com/s3/)
- Aggregates test results
- The whole suite run will be less than 5 minutes!

# Principals
- Every test must be independent, and must be able to runs in parallel with others  
- Every test have to take less than 5 minutes including setup and teardown (AWS lambda restriction)  

# How to run your Fitnesse tests in AWS lambdas:
Docker image to build and deploy: [on Dockerhub](https://hub.docker.com/r/antontimiskov/lambda-fitnesse/)  
**TBD**

# See Also
[PySlim](https://github.com/VolodymyrLavrenchuk/PySlim) - A [SLIM](http://www.fitnesse.org/FitNesse.UserGuide.WritingAcceptanceTests.SliM) test system on Python (based on waferslim) to write Acceptance tests for REST APIs.

# License
[MIT](https://github.com/AntonTimiskov/lambda-fitnesse/blob/master/LICENSE)
