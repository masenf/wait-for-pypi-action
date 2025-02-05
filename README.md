# wait-for-pypi

This action allows you to wait for a pypi package to become available.

Typically used after pushing a new package and you want to push a docker image with the preinstalled binary after.

[![Tests](https://github.com/databutton/wait-for-pypi-action/actions/workflows/test.yml/badge.svg)](https://github.com/databutton/wait-for-pypi-action/actions/workflows/test.yml)
## Usage

### Pre-requisites
Create a workflow `.yml` file in your repositories `.github/workflows` directory. An [example workflow](#example-workflow) is available below.

### Inputs

* `package_name` - The name of the package as you would use it in `pip install package_name`. **Required**.
* `package_version` - The version of the package that should be waited for. Example: `1.4.2`. **Required**.
* `timeout` - How long we should maximum wait in seconds. Example: `60`, default: `30`.
* `delay_between_requests` - Delay between requests in seconds. Example: `5`, default: `1`.

### Example workflow

```yaml
name: Release on pip and dockerhub

on: push

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    # Assuming this has outputs.version
    - name: release pip package
      id: release
      run: ./release-sh

    - name: Wait for package to become available
      uses: databutton/wait-for-pypi-action@main
      with:
        package_name: my-package
        package_version: ${{ steps.release.outputs.version }}

    # This runs after the pip package is available, so you can now push the docker image
    - name: Release on dockerhub
      run: docker build -t $IMAGE_NAME:${{ steps.release.outputs.version }}

```

## License
The scripts and documentation in this project are released under the [MIT License](LICENSE)
