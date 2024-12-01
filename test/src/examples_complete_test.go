package test

import (
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func cleanup(t *testing.T, terraformOptions *terraform.Options, tempTestFolder string) {
	terraform.Destroy(t, terraformOptions)
	os.RemoveAll(tempTestFolder)
}

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()
	randID := strings.ToLower(random.UniqueId())
	attributes := []string{randID}

	rootFolder := "../../"
	terraformFolderRelativeToRoot := "examples/complete"
	varFiles := []string{"fixtures.us-east-2.tfvars"}

	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: varFiles,
		Vars: map[string]interface{}{
			"attributes": attributes,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer cleanup(t, terraformOptions, tempTestFolder)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	vpcCidr := terraform.Output(t, terraformOptions, "vpc_cidr")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "172.16.0.0/16", vpcCidr)

	// Run `terraform output` to get the value of an output variable
	privateSubnetCidrs := terraform.OutputList(t, terraformOptions, "private_subnet_cidrs")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, []string{"172.16.0.0/19", "172.16.32.0/19"}, privateSubnetCidrs)

	// Run `terraform output` to get the value of an output variable
	publicSubnetCidrs := terraform.OutputList(t, terraformOptions, "public_subnet_cidrs")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, []string{"172.16.96.0/19", "172.16.128.0/19"}, publicSubnetCidrs)

	// Run `terraform output` to get the value of an output variable
	accessLogsBucketId := terraform.Output(t, terraformOptions, "access_logs_bucket_id")
	// Verify we're getting back the outputs we expect eg-test-alb-25346-alb-access-logs
	assert.Equal(t, "eg-test-alb-"+attributes[0]+"-alb-access-logs", accessLogsBucketId)

	// Run `terraform output` to get the value of an output variable
	albName := terraform.Output(t, terraformOptions, "alb_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "eg-test-alb-"+attributes[0], albName)

	// Run `terraform output` to get the value of an output variable
	defaultTargetGroupArn := terraform.Output(t, terraformOptions, "default_target_group_arn")
	// Verify we're getting back the outputs we expect something like "arn:aws:elasticloadbalancing:us-east-2:799847381734:targetgroup/eg-test-alb-11514-default/89e9fe401fc63cf7
	assert.Contains(t, defaultTargetGroupArn, "arn:aws:elasticloadbalancing:us-east-2:799847381734:targetgroup/eg-test-alb-"+attributes[0]+"-default")

	// Run `terraform output` to get the value of an output variable
	httpListenerArn := terraform.Output(t, terraformOptions, "http_listener_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, httpListenerArn, "arn:aws:elasticloadbalancing:us-east-2:799847381734:listener/app/eg-test-alb-"+attributes[0])
}
