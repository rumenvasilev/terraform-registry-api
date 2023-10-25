$version: "2"

namespace tf.registry.shapes

// PATTERNS
@pattern("^amd64|arm64|arm|386$")
string Arch

// terraform-provider-aws_5.20.1_darwin_amd64.zip
@pattern(
    "^terraform-provider-([a-z]+(-[a-z]+)?)_(([0-9]{1}|[1-9][0-9])\\.){2}([0-9]{1}|[1-9][0-9])_(darwin|linux|windows)_(amd64|arm|arm64|386)\\.zip$"
)
string Filename

@pattern("^darwin|linux|windows|openbsd|freebsd|solaris$")
string OS

// 4
// 4.0
// 5.1
// 4.0,5.0 - more an exception, but still seen in https://registry.terraform.io/v1/providers/hashicorp/aws/versions -> 2.70.3
@pattern("^(\\d{1,2}(\\.\\d)?)$|(\\d{1,2}(\\.\\d)?),(\\d{1,2}(\\.\\d)?)$")
string Protocol

@pattern("^[a-z0-9]{64}$")
string SHASum

@pattern("^[A-Z0-9]{16}$")
string GPGKeyID

// "X-Terraform-Get": fmt.Sprintf("git::https://github.com/%s/%s?ref=%s", params.Namespace, repoName, releaseTag)}
@pattern(
    "^git::https://github.com/((\\w+-)+)?\\w+/((\\w+-)+)?\\w+\\?ref=v(([0-9]{1}|[1-9][0-9])\\.){2}([0-9]{1}|[1-9][0-9]{1,2})$"
)
string githubModuleDownloadURL

@pattern("^terraform-[a-z0-9]+-[a-z0-9]+$")
string NamespaceDef

// semver
@pattern("^(([0-9]{1}|[1-9][0-9])\\.){2}([0-9]{1}|[1-9][0-9]{1,2})$")
string SemVer

// terraform version
// semver | semver-beta
@pattern(
    "^((([0-9]{1}|[1-9][0-9])\\.){2}([0-9]{1}|[1-9][0-9]{1,2}))$|(([0-9]{1}|[1-9][0-9])\\.){2}([0-9]{1}|[1-9][0-9]{1,2})-\\w+$"
)
string TFVersion
