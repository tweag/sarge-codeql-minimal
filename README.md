## sarge-codeql-minimal

Code accompanying the [Getting started with CodeQL](TBD) blog post on the Tweag blog, modeling the
[sarge](https://github.com/vsajip/sarge) Python library. This repository is purposedly kept small,
a more complete version of this code can be found at [smelc/sarge-security-codeql](https://github.com/smelc/sarge-security-codeql).

You may also be interested in a variant of this repository that uses Java as the target programming language:
[tweag/java-security-codeql](https://github.com/tweag/java-security-codeql).

## Installing CodeQL

Download the CodeQL archive from its [releases page](https://github.com/github/codeql-cli-binaries/releases)
(this repository used codeql 2.20.0), and make sure the `codeql` binary is in your `PATH`. Then install
CodeQL's standard library and this repository as follows:

```shell
mkdir codeql-tutorial
cd codeql-tutorial
git clone https://github.com/github/codeql
git clone https://github.com/tweag/sarge-codeql-minimal
# At this point the "codeql" and "sarge-codeql-minimal" folders are siblings
cd sarge-codeql-minimal
```

### Running CodeQL

Create the CodeQL database as follows:

```shell
./create-codeql-db.sh
```

Then run analyses as follows:

```shell
./run-codeql-analysis.sh
```

### Development instructions

Prepare the environment as follows (to do only once):

```shell
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt -r dev-requirements.txt
```

Then run the application in one terminal:

```shell
flask --debug run
```

In another terminal, trigger the vulnerability:

```shell
curl -X POST http://localhost:5000/ -d "key=ls"
```

Now observe that in the terminal running the app, the `ls` command (provided by the user! 💣) was executed:

```shell
/ handler
Received: ls
app.py	__pycache__  README.md	requirements.txt
```
