# Changelog

## Latest

* Update provider version regex to capture all possible variants that are returned from the terraform registry today
* Added X-Terraform-Version request header for module calls
* Registry response to module version download path must be 204, not 200, because the server returns empty body. Download link is passed by means of X-Terraform-Get response header. Both terraform and opentofu support that (in fact they do support both 200 and 204).
* Added response errors to the model.
* Updated the regex for module download URL
* Added release github action, publishing the resulting openapi specification.

## v0.1.0

* Initial API specification release with both smithy and openapi.
* Added github action to validate, build the model.
