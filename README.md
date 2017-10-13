# npm-package-sandbox

This script tests a npm package in a Docker container. It runs the `npm install` command for the package, calls `require()` on the package, and tries to call the imported library as a function. The network activity of the Docker container on ports 80 (HTTP) and 443 (HTTPS) during this process is captured by `tcpdump` and written to a `.pcap` file.

The sandbox will run and capture traffic until the process terminates or after 5 minutes.

## Requirements
- Bash shell environment
- [Docker](https://www.docker.com/)
- `sudo` rights

## Usage
`./script.sh [package name]` will run the script for the spacified package, e.g. `./script.sh left-pad` will capture traffic for the installation of the `left-pad` package.
