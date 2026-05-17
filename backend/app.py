from flask import Flask

app = Flask(__name__)


@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def placeholder(path: str) -> str:
    return "InvoiceOps backend placeholder — replace in day 2 de-risking"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
