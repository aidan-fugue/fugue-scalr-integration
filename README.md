# Integrating Regula with Scalr
## Regula for IaC Security :handshake: Scalr for Terraform Automation and Collaboration

[Scalr](https://www.scalr.com/home-navattic) is a remote state & operations backend for Terraform with full CLI support, integration with OPA, a hierarchical configuration model, and quality of life features. [Regula](https://regula.dev/index.html) is a tool that evaluates infrastructure as code files for potential AWS, Azure, Google Cloud, and Kubernetes security and compliance violations prior to deployment.

Pairing Regula's powerful, easy-to-use IaC scanning capabilities with Scalr's Terraform automation and collaboration capabilities enables you to move quickly without sacrificing security in the cloud.

### Goal
Pair Regula and Scalr to automate the *secure* deployment of cloud infrastructure with Terraform.

### Preparation
I started by signing up for a [free Scalr trial account](https://scalr.io/#/public/signup). Upon request, Sclar was kind enough to grant me trial access to the premium [Custom Hooks](https://docs.scalr.com/en/latest/workspaces.html#custom-hooks) feature, which allowed me to customize my terraform workflow. Next, I created a [workspace](https://docs.scalr.com/en/latest/workspaces.html#create-workspace), added my [AWS credentials](https://docs.scalr.com/en/latest/cloud_credentials.html#provider-credentials) (very convenient not to have to include these in my Terraform `.gitignore` file and instead have Scalr automate the authentication with AWS), and added a version control system (VCS) [provider](https://docs.scalr.com/en/latest/vcs_providers.html#vcs-providers) (I used GitHub). Finally, I downloaded the latest version of Regula from the [Regula GitHub repository](https://github.com/fugue/regula/releases) (use the Linux x86_64 release for compatability with Scalr). If you want to follow along, you can clone my repository:

```git clone https://github.com/aidan-fugue/fugue-scalr-integration.git```

### What's in the repo?
![file structure](/img/tree.png "file structure")
What you see above is a visual representation of the file structure for the above repo, which contains Terraform files in `main.tf` and `/s3/`, scripts that will be run as custom hooks in `/scripts/`, and rule waivers in `waivers.rego`.



### File Structure and Explanation

#### `/s3`
Terraform files
#### `/scripts`
##### `/before-plan.bash`
Checks for security and validates terraform
```bash
./regula run --include waivers.rego
terraform validate
```
##### `/after-plan.bash`
Adjusts formatting per HCL canonical standards
```bash
terraform fmt $f
```
(where $f = all files in repo with .tf extensions)

### The full pipeline
```
git add <files>
git commit -m "initiating the scalr terraform pipeline
git push
```

### Waivers
```go
package fugue.regula.config

waivers[waiver] {
  waiver := {
    #Waiving the bucket logging rule (logging bucket)
    "rule_id": "FG_R00274",
    "resource_id": "module.s3.aws_s3_bucket.logbucket"
  }
}

rules[rule] {
  rule := {
    #Disabling this cross-region replication rule (budgetary purposes)
    "rule_id": "FG_R00275",
    "status": "DISABLED"
  }
}
```

### Execution snapshots