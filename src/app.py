# app.py
from flask import Flask
import os

app = Flask(__name__)

@app.route('/hello')
def hello():
    return "Hello I am reachable! from " + os.getenv("HOSTNAME")

@app.route('/healthz')
def healthz():
    return '', 200

@app.route('/ready')
def ready():
    return '', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)