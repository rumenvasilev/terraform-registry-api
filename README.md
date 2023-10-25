# terraform-registry-api

In case you want to build a terraform registry, I wrote the API spec. With [smithy](https://github.com/smithy-lang/smithy). Because smithy is cool :). And because it has many features, like the one that will tell you you're breaking the API or another that won't let you return 200 with empty response. And OpenAPI spec can be generated from it (with the cli tool). I used it with [prism](https://github.com/stoplightio/prism) to develop it 1:1 (unless I missed something) against opentofu registry implementation. Because I am familiar with that codebase and because it's OSS so I can actually see what the server is supposed to do. Anyhow, API is the same for hashicorp's terraform.

## Why?

Some companies want self-hosted registries to control versions, binaries, but mainly to avoid supply chain attacks and getting on the front page of hackernews. This API definition will help you do the server implementation and with tools like [prism's validation proxy](https://docs.stoplight.io/docs/prism/72d69fb629de0-validation-proxy) you'd be able to do [contract testing](https://www.techtarget.com/searchapparchitecture/tip/Why-contract-testing-can-be-essential-for-microservices) as well. So ongoing dev work will not break the API.


## How I get started here?

First and foremost, you need smithy-cli. If you don't have it, you can install it with homebrew (`brew tap smithy-lang/tap && brew install smithy-cli`) or download an executable for your OS from https://github.com/smithy-lang/smithy/releases. More information on smithy - https://smithy.io/.
Run `smithy build model/` and you'll have the OpenAPI spec in `build/source/openapi` directory (that's in case you don't want the [released version](https://github.com/rumenvasilev/terraform-registry-api/releases)). From there the entire OpenAPI ecosystem is at your disposal.

Next you'd probably need a server that can use the OpenAPI spec. I use prism, because it has validation proxy, as well as mock server, that generates dynamic responses (pretty cool!), which help you catch edge cases. Prism is easy. To run mock server:
```
docker run --init -p 4010:4010 -v $(pwd)/build/smithy/source/openapi:/tmp/ \
  stoplight/prism:4 mock -h 0.0.0.0 /tmp/Registry.openapi.json
```
If you want to go a step further and use the validation proxy:
```
docker run --init -p 4010:4010 -v $(pwd)/build/smithy/source/openapi:/tmp/ \
  stoplight/prism:4 proxy -h 0.0.0.0 /tmp/Registry.openapi.json http://your-api-server-implementation.com
```
The former would mock all responses and return semi-random data (I've set some hard examples in the model), while the latter would proxy the requests towards your server (or you could test it against opentofu or hashicorp's registries).

Finally you could use a tool like [Postman](https://www.postman.com/), import the OpenAPI spec and you're ready to call the API. Examples are prefilled, just update the baseUrl from the collection variables.

## I don't want to write my server...

Then go get OpenTofu's OSS registry serverless implementation from here https://github.com/opentofu/registry and deploy it to your AWS account. Shouldn't take you more than half an hour altogether.

## Why did you use these tools?

Smithy is cool, like I've said already :) It has codegen for many languages, although it's still young for many of them. But mostly I like how strict it is and the built-in validations and models (with baked-in official standards in there). It forces you to do things in a uniform way.

Prism because of the mock with dynamic response generation. Proxy (contract-testing) is another great feature. All-in-one. I've tried other tools, none of which could do all that, based off a single OpenAPI manifest and no code.

Postman - well, I like the integration with OpenAPI and how easy it is to make calls. One could totally do curl + jq. I guess I just like the UIs more nowadays.

## Releases

I follow semver.

## Contributions

Are welcome! Create an Issue/PR and lets have a chat.
