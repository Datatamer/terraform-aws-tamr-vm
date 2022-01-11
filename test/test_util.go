package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// VmTestCase defines a test case for a Tamr VM
type VmTestCase struct {
	testName         string
	expectApplyError bool
	vars             map[string]interface{}
}

// validateModule validates
func validateModule(t *testing.T, terraformOptions *terraform.Options, awsRegion string, expectedNameTag string) {
	// Run `terraform output` to get the value of an output variable
	instanceID := terraform.Output(t, terraformOptions, "tamr_vm_id")
	testTagValue := "testing-tag-value"
	testTagKey := "testing"

	t.Run("validate_add_tags", func(t *testing.T) {
		aws.AddTagsToResource(t, awsRegion, instanceID, map[string]string{testTagKey: testTagValue})
	})

	t.Run("validate_get_tags", func(t *testing.T) {
		// Look up the tags for the given Instance ID
		instanceTags := aws.GetTagsForEc2Instance(t, awsRegion, instanceID)

		// Check if the EC2 instance with a given tag and name is set.
		resourceTag, containsTestingTag := instanceTags[testTagKey]
		assert.True(t, containsTestingTag)
		assert.Equal(t, testTagValue, resourceTag)

		// Verify that our expected name tag is one of the tags
		nameTag, containsNameTag := instanceTags["Name"]
		assert.True(t, containsNameTag)
		assert.Equal(t, expectedNameTag, nameTag)
	})
}
