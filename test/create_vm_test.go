package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	terratestutils "github.com/Datatamer/go-terratest-functions/pkg/terratest_utils"
	"github.com/Datatamer/go-terratest-functions/pkg/types"
	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/require"
)

// initTestCases returns a list of VmTestCase. This is manually created by tester that will know what values should be applied in order to make the test run.
func initTestCases() []VmTestCase {
	return []VmTestCase{
		{
			testName:         "TestMinimal",
			tfDir:            "test_examples/minimal",
			expectApplyError: false,
			vars: map[string]interface{}{
				"name-prefix":               "",
				"name_tag":                  "Tamr_VM_Terratest",
				"vpc_cidr_block":            "172.20.0.0/18",
				"vm_subnet_cidr_block":      "172.20.0.0/24",
				"install_script_path":       "./install-pip.sh",
				"check_install_script_path": "./check-install.sh",
			},
		},
	}
}

// TestTamrVM runs all test cases
func TestTamrVM(t *testing.T) {
	const MODULE_NAME = "terraform-aws-tamr-vm"
	testCases := initTestCases()
	// Generate file containing GCS URL to be used on Jenkins.
	// TERRATEST_BACKEND_BUCKET_NAME and TERRATEST_URL_FILE_NAME are both set on Jenkins declaration.
	gcsTestExamplesURL := terratestutils.GenerateUrlFile(t, MODULE_NAME, os.Getenv("TERRATEST_BACKEND_BUCKET_NAME"), os.Getenv("TERRATEST_URL_FILE_NAME"))
	for _, testCase := range testCases {
		testCase := testCase

		t.Run(testCase.testName, func(t *testing.T) {
			t.Parallel()

			// Make a copy of the terraform module to a temporary directory. This allows running multiple tests in parallel
			// against the same terraform module.
			tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "../", testCase.tfDir)

			// this stage will generate a random `awsRegion` and a `uniqueId` to be used in tests.
			test_structure.RunTestStage(t, "pick_new_randoms", func() {
				usRegions := []string{"us-east-1", "us-east-2", "us-west-1", "us-west-2"}
				// This function will first check for the Env Var TERRATEST_REGION and return its value if != ""
				awsRegion := aws.GetRandomStableRegion(t, usRegions, nil)

				test_structure.SaveString(t, tempTestFolder, "region", awsRegion)
				test_structure.SaveString(t, tempTestFolder, "unique_id", strings.ToLower(random.UniqueId()))
			})

			test_structure.RunTestStage(t, "setup_options", func() {
				awsRegion := test_structure.LoadString(t, tempTestFolder, "region")
				uniqueID := test_structure.LoadString(t, tempTestFolder, "unique_id")
				backendConfig := terratestutils.ParseBackendConfig(t, gcsTestExamplesURL, testCase.testName, testCase.tfDir)

				testCase.vars["name-prefix"] = fmt.Sprintf("terratest-%s", uniqueID)

				terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
					TerraformDir: tempTestFolder,
					Vars:         testCase.vars,
					EnvVars: map[string]string{
						"AWS_REGION": awsRegion,
					},
					BackendConfig: backendConfig,
					MaxRetries:    2,
				})

				test_structure.SaveTerraformOptions(t, tempTestFolder, terraformOptions)
			})

			test_structure.RunTestStage(t, "create_vm", func() {
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				terraformConfig := &types.TerraformData{
					TerraformBackendConfig: terraformOptions.BackendConfig,
					TerraformVars:          terraformOptions.Vars,
					TerraformEnvVars:       terraformOptions.EnvVars,
				}
				if _, err := terratestutils.UploadFilesE(t, terraformConfig); err != nil {
					logger.Log(t, err)
				}
				_, err := terraform.InitAndApplyE(t, terraformOptions)

				if testCase.expectApplyError {
					require.Error(t, err)
					// If it failed as expected, we should skip the rest (validate function).
					t.SkipNow()
				}
			})

			// At the end of the test, run `terraform destroy` to clean up any resources that were created
			defer test_structure.RunTestStage(t, "teardown", func() {
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				terraformOptions.MaxRetries = 5

				_, err := terraform.DestroyE(t, terraformOptions)
				if err != nil {
					// If there is an error on destroy, it will be logged.
					logger.Log(t, err)
				}
			})

			test_structure.RunTestStage(t, "validate_vm", func() {
				awsRegion := test_structure.LoadString(t, tempTestFolder, "region")
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				validateModule(
					t,
					terraformOptions,
					awsRegion,
					testCase.vars["name_tag"].(string),
				)
			})
		})
	}
}
