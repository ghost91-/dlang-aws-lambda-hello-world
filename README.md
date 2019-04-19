# DLang AWS Lambda Hello World

A simple demo application for D on AWS Lambda.

## Building

Simply run

```bash
dub build
```

This creates a file `bootstrap.zip` which contains all the code and can be used
to create a Function on AWS Lambda.

If you compile with LDC, a staticly linked binary is created. You can achieve this by running
```bash
dub build --compiler=ldc2
```


## Deploying to AWS Lambda via [serverless](https://serverless.com/)

1. Setup AWS credentials for serverless as described [here](https://serverless.com/framework/docs/providers/aws/guide/credentials/).
2. Build the application as described in the previous section.
3. Run
   ```bash
   serverless deploy
   ```
