from keras.models  import load_model
from flask import Flask, render_template, request

app = Flask("dismodelapp")
model  =  load_model("pima_indians_diabetes_model.h5")

@app.route("/home")
def home():
    return render_template("mform.html")

@app.route("/output" , methods=[ "GET" ] )
def dia():
        x1 = request.args.get("z1")
        x2 = request.args.get("z2")
        x3 = request.args.get("z3")
        x4 = request.args.get("z4")
        x5 = request.args.get("z5")
        x6 = request.args.get("z6")
        x7 = request.args.get("z7")
        x8 = request.args.get("z8")
        output = model.predict([[ int(x1) , int(x2) , int(x3),  int(x4), int(x5), float(x6) , float(x7) ,  int(x8)  ]])
        
        if (round(output[0][0])) == 1:
            print("Sorry to say, you are suffering from diabetes")

        else:
            print("You can enjoy your sweets, you have no diabetes")

        return(""str(round(output[0][0])))

app.run(host="0.0.0.0" ,  port=80)
