$version: "2"

namespace tf.registry

use aws.protocols#restJson1
use tf.registry.module#Module
use tf.registry.provider#Provider
use tf.registry.wellknown#WellKnown

@restJson1
service Registry {
    version: "2006-03-01"
    resources: [
        Provider
        Module
        WellKnown
    ]
}
