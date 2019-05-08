import std.net.curl : HTTP;
import std.process : environment;

void main()
{
    immutable awsLambdaRuntimeAPI = environment.get("AWS_LAMBDA_RUNTIME_API");
    while (true)
    {
        auto requestHTTP = HTTP(
                "http://" ~ awsLambdaRuntimeAPI ~ "/2018-06-01/runtime/invocation/next");
        requestHTTP.perform();
        immutable requestId = requestHTTP.responseHeaders["lambda-runtime-aws-request-id"];

        auto responseHTTP = HTTP(
                "http://" ~ awsLambdaRuntimeAPI
                ~ "/2018-06-01/runtime/invocation/" ~ requestId ~ "/response");
        responseHTTP.method = HTTP.Method.post;
        responseHTTP.setPostData(`{
                    "statusCode": 200,
                    "body": "Hello from D on AWS Lambda!",
                    "headers": {
                        "Content-Type": "text/plain"
                    }
                }`, "application/json");
        responseHTTP.perform();
    }
}
