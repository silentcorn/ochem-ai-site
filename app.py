from flask import Flask, render_template, request, url_for
from rdkit import Chem
from rdkit.Chem import Draw
from rdkit.Chem.Draw import rdMolDraw2D
from DECIMER import predict_SMILES

# To do: ...

#testing again


app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")


# Results page route (empty for now)
@app.route("/results", methods=["GET", "POST"])
def results():
    return render_template("results.html")

if __name__ == "__main__":
    app.run(debug=True)