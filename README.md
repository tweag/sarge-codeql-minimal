## sarge-codeql-minimal

Code accompanying the [Getting started with CodeQL](TBD) blog post on the Tweag blog, modeling the
[sarge](https://github.com/vsajip/sarge) Python library. This repository is purposedly kept small,
a more complete version of this code can be found at [smelc/sarge-security-codeql](https://github.com/smelc/sarge-security-codeql).

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
