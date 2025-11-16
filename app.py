from flask import Flask, render_template, request, url_for
from rdkit import Chem
from rdkit.Chem import Draw
from rdkit.Chem.Draw import rdMolDraw2D
from DECIMER import predict_SMILES
import os
# To do: ...

#testing again


app = Flask(__name__)

UPLOAD_FOLDER = "/static/uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER



@app.route("/")
def index():
    return render_template("index.html")


# Results page route (empty for now)
@app.route("/results", methods=["GET", "POST"])
def results():
    error = None
    smiles = None
    output_images = []
    predictions = {}

    folder = app.config['UPLOAD_FOLDER']

    if request.method == "POST":
        # Get smiles input
        smiles = request.form.get("smiles")

        # Get uploaded file
        file = request.files.get("image")


        # Run your python logic here
        if smiles and smiles.strip() != "":
            mol = Chem.MolFromSmiles(smiles)
            # Generate resonance structures
            resonance_structs = [m for m in Chem.ResonanceMolSupplier(mol)]
            
        elif file:
            if file and file.filename != "":
                filepath = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
                file.save(filepath)

                # Now filepath can be used in your python logic
                # example: output_images.append(filepath)

            smiles = predict_SMILES(filepath)
            mol = Chem.MolFromSmiles(smiles)

        filenames = []
        for i, res_mol in enumerate(resonance_structs):
            drawer = rdMolDraw2D.MolDraw2DSVG(300,300)
            rdMolDraw2D.PrepareAndDrawMolecule(drawer, res_mol)
            drawer.FinishDrawing()
            svg = drawer.GetDrawingText()
            filename = f"resonance_{i}.svg"
            filepath = os.path.join(folder, file.filename)
            #save svg

            with open(filepath, "w") as f:
                f.write(svg)
            output_images.append(filename)



    return render_template("results.html",
                           error=error,
                           smiles=smiles,
                           output_images=output_images,
                           predictions=predictions)

if __name__ == "__main__":
    app.run(debug=True)