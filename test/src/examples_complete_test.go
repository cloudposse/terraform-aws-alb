package test

import (
	"testing"

	"math/rand"
	"strconv"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()
	rand.Seed(time.Now().UnixNano())

	attributes := []string{strconv.Itoa(rand.Intn(100000))}

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
		Vars: map[string]interface{}{
			"attributes": attributes,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

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
	// Verify we're getting back the outputs we expect something like "arn:aws:elasticloadbalancing:us-east-2:126450723953:targetgroup/eg-test-alb-11514-default/89e9fe401fc63cf7
	assert.Contains(t, defaultTargetGroupArn, "arn:aws:elasticloadbalancing:us-east-2:126450723953:targetgroup/eg-test-alb-"+attributes[0]+"-default")

	// Run `terraform output` to get the value of an output variable
	httpListenerArn := terraform.Output(t, terraformOptions, "http_listener_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, httpListenerArn, "arn:aws:elasticloadbalancing:us-east-2:126450723953:listener/app/eg-test-alb-"+attributes[0])

	// Run `terraform output` to get the value of an output variable
	securityGroupName := terraform.Output(t, terraformOptions, "security_group_name")
	expectedSecurityGroupName := "eg-test-alb-" + attributes[0]
	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedSecurityGroupName, securityGroupName)

	// Run `terraform output` to get the value of an output variable
	securityGroupID := terraform.Output(t, terraformOptions, "security_group_id")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, securityGroupID, "sg-", "SG ID should contains substring 'sg-'")

	// Run `terraform output` to get the value of an output variable
	securityGroupARN := terraform.Output(t, terraformOptions, "security_group_arn")
	// Verify we're getting back the outputs we expect
	assert.Contains(t, securityGroupARN, "arn:aws:ec2", "SG ID should contains substring 'arn:aws:ec2'")
}
