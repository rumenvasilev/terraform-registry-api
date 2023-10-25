$version: "2"

namespace tf.registry.module

use tf.registry.errors#NotFound
use tf.registry.shapes#NamespaceDef
use tf.registry.shapes#SemVer
use tf.registry.shapes#TFVersion
use tf.registry.shapes#githubModuleDownloadURL

resource Module {
    identifiers: {namespace: NamespaceDef, name: String, version: SemVer}
    read: GetModuleVersion
    list: ListModuleVersions
}

@suppress(["HttpUriConflict"])
@readonly
@http(method: "GET", uri: "/v1/modules/{namespace}/{name}/{system}/{version}/download", code: 204)
operation GetModuleVersion {
    input: GetModuleVersionInput
    output: GetModuleVersionOutput
    errors: [
        NotFound
    ]
}

@input
structure GetModuleVersionInput {
    @httpHeader("X-Terraform-Version")
    xterraformversion: TFVersion

    @required
    @httpLabel
    namespace: NamespaceDef = "terraform-aws-modules"

    @required
    @httpLabel
    name: String = "iam"

    @required
    @httpLabel
    system: String = "aws"

    @required
    @httpLabel
    version: SemVer = "5.2.0"
}

@output
structure GetModuleVersionOutput {
    @required
    @httpHeader("X-Terraform-Get")
    xterraformget: githubModuleDownloadURL = "git::https://github.com/terraform-aws-modules/terraform-aws-iam?ref=v5.30.0"
}

@suppress(["HttpUriConflict"])
@readonly
@http(method: "GET", uri: "/v1/modules/{namespace}/{name}/{system}/versions", code: 200)
operation ListModuleVersions {
    input: ListModuleVersionsInput
    output: ListModuleVersionsOutput
    errors: [
        NotFound
    ]
}

@input
structure ListModuleVersionsInput {
    @httpHeader("X-Terraform-Version")
    xterraformversion: TFVersion

    @required
    @httpLabel
    namespace: NamespaceDef = "terraform-aws-modules"

    @required
    @httpLabel
    name: String = "iam"

    @required
    @httpLabel
    system: String = "aws"
}

@output
structure ListModuleVersionsOutput {
    @required
    modules: Modules
}

@length(max: 1)
list Modules {
    member: VersionsModule
}

structure VersionsModule {
    @required
    versions: Versions
}

list Versions {
    member: Version
}

structure Version {
    @required
    version: SemVer
}
