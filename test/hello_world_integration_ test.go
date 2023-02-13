package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

// Replace thest with the proper paths to your modules
const dbDirStage = "../../live/stage/data-stores/postgres"
const appDirStage = "../../live/stage/services/hello-world-app"

func TestHelloWorldAppStage(t *testing.T) {
	t.parallel()

	// Deploy the Postgres DB
	dbOpts := createDbOpts(t, dbDirStage)
	defer terraform.Destroy(t, dbOpts)
	terraform.InitAndApply(t, dbOpts)

	// Deploy the hello-world-app
	helloOpts := createHelloOpts(dbOpts, appDirStage)
	defer terraform.Destroy(t, helloOpts)
	terraform.InitAndApply(t, helloOpts)

	// Validate the hello-world-app works
	validateHelloApp(t, helloOpts)

}

func createDbOpts(t *testing.T, terraformDir string) *terraform.Options {
	UniqueId := random.UniqueId()

}
