import requests : Request;
import std.process : environment;

void main()
{
    immutable awsLambdaRuntimeAPI = environment.get("AWS_LAMBDA_RUNTIME_API");
    while (true)
    {
        auto request = Request();
        auto response = request.get(
                "http://" ~ awsLambdaRuntimeAPI ~ "/2018-06-01/runtime/invocation/next");

        immutable requestId = response.responseHeaders["lambda-runtime-aws-request-id"];

        request.post("http://" ~ awsLambdaRuntimeAPI ~ "/2018-06-01/runtime/invocation/" ~ requestId ~ "/response",
                `{
                    "statusCode": 200,
                    "body": "Hello from D on AWS Lambda!",
                    "headers": {
                        "Content-Type": "text/plain"
                    }
                }`);
    }
}
