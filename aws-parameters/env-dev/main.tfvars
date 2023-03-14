parameters = [

{ name: "test1", value = "hello Pritam", type: "String"}
{ name: "dev.frontend.CATALOGUE_URL", value = {{ lookup('amazon.aws.aws_ssm', 'test1', region='us-east-1') }}", type: "String"}
]