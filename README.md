# ImgFlo.swift [![Build Status](https://travis-ci.org/the-grid/ImgFlo.swift.svg)](https://travis-ci.org/the-grid/ImgFlo.swift)

Conveniently produce authorized [imgflo](https://github.com/jonnor/imgflo) URLs.

## Usage

```swift
import ImgFlo

let imgflo = ImgFlo.Client(
  server: "https://yourimgfloserver.com",
  key: "your-imgflo-key",
  secret: "your-imgflo-secret"
)

let graph: Graph = .Passthrough(width: 750, height: 1334)
let imageURL = "http://yourserver.com/yourimage.png"

let URL = imgflo.getURL(graph, input)
```

## Development

### Installing dependencies

The following script requires [Carthage](https://github.com/Carthage/Carthage) to be installed.

```sh
./script/update
```

### Running tests

The following script requires [xctool](https://github.com/facebook/xctool) to be installed.

```sh
./script/test
```
