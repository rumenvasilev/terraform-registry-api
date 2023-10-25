$version: "2"

namespace tf.registry.wellknown

// .well-known/terraform.json
resource WellKnown {read: GetWellKnown}

@readonly
@http(method: "GET", uri: "/.well-known/terraform.json", code: 200)
operation GetWellKnown {
    output: GetWellKnownOutput
}

@output
structure GetWellKnownOutput {
    @required
    @jsonName("modules.v1")
    @default("/v1/modules/")
    modulesv1: modulesMetadataVersion

    @required
    @jsonName("providers.v1")
    @default("/v1/providers/")
    providersv1: providersMetadataVersion
}

enum modulesMetadataVersion {
    V1 = "/v1/modules/"
}

enum providersMetadataVersion {
    V1 = "/v1/providers/"
}
