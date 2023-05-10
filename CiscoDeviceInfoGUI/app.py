from flask import Flask, render_template, request, url_for
from netmiko import ConnectHandler

app = Flask(__name__)

@app.route('/', methods=["GET", "POST"])

def index():
    if request.method == "POST":
        device = {
            "device_type": "cisco_ios",
            "ip": request.form["device"],
            "username": request.form["username"],
            "password": request.form["password"],
        }
        with ConnectHandler(**device) as net_connect:
            output = net_connect.send_command(request.form["command"])
        return render_template('index.html', output=output)
    else:
        return render_template('index.html')

if __name__ == "__main__":
    app.run(debug=True)