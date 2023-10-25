$version: "2"

namespace tf.registry.errors

@error("client")
@httpError(404)
structure NotFound {
    errors: ErrorNotFoundList
}

list ErrorNotFoundList {
    member: String
}
