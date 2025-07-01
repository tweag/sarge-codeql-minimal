from flask import Flask, request

import sarge  # type: ignore

app = Flask(__name__)


@app.route("/", methods=["POST"])
def user_to_sarge_run():
    """This function shows a vulnerability: it forwards user input (through a POST request)
    to sarge.run. This vulnerability is caught thanks to our custom CodeQL rule."""
    print("/ handler")
    if request.method != "POST":
        return "Method not allowed"
    received: str = request.form.get("key", "default")
    print(f"Received: {received}")
    sarge.run(received)  # type: ignore # Unsafe, don't do that!
    return "Called sarge"
