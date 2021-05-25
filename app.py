from keras.models  import load_model
from flask import Flask, render_template, request, url_for

app = Flask("dismodelapp")
model  =  load_model("pima_indians_diabetes_model.h5")

@app.route("/home")
def home():
    return render_template("form.html")

@app.route("/output" , methods=[ "GET" ] )
def dia():
        x1 = request.args.get("p1")
        x2 = request.args.get("p2")
        x3 = request.args.get("p3")
        x4 = request.args.get("p4")
        x5 = request.args.get("p5")
        x6 = request.args.get("p6")
        x7 = request.args.get("p7")
        x8 = request.args.get("p8")
        output = model.predict([[ int(x1) , int(x2) , int(x3),  int(x4), int(x5), float(x6) , float(x7) ,  int(x8)  ]])
        
        if (round(output[0][0])) == 1:
            return render_template("positive.html")

        else:
            return render_template("negative.html")
        
app.run(host="0.0.0.0" ,  port=80)
