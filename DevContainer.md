# FIX THIS
I got this from https://github.com/0mmadawn/TerraformAwsDevContainer  
but it doesn't work properly - the container won't build.

Additionally, I want to change it so the AWS creds aren't baked into the image.  

## Before Use

Before open this DevContainer as remote,  
you have to set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.  
[https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)

See `.devcontainer/devcontainer.json` > `build.args`

```
// TODO set env values(AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) to your host machine
// if localEnv doesnt load during build, restart docker may solve it...
// https://code.visualstudio.com/docs/remote/devcontainerjson-reference
// or write directly!!
"AWS_ACCESS_KEY_ID": "${localEnv:AWS_ACCESS_KEY_ID}",
"AWS_SECRET_ACCESS_KEY": "${localEnv:AWS_SECRET_ACCESS_KEY}"
```

## Use (Open as Remote)

`Remote-Containers: Rebuild and Reopen Container`

After build, you can use terraform and aws-cli.

```sh
$ terraform --version
Terraform v0.14.10
$ aws --version
aws-cli/2.1.36 Python/3.8.8 Linux/5.10.25-linuxkit docker/x86_64.amzn.2 prompt/off
```


Sample 

```sh
$ cd /workspaces/terraform_test/src
$ terraform init
$ terraform plan
$ terraform apply
```

References

* https://qiita.com/reflet/items/de57ae767c8f368372ba
* https://qiita.com/hoisjp/items/3285c1b3e1fb49df711b
