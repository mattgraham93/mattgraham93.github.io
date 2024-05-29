# https://medium.com/google-cloud/deploy-a-python-flask-server-using-google-cloud-run-d47f728cc864
# https://cloud.google.com/run/docs/quickstarts/build-and-deploy/python

import os
from flask import Flask, jsonify, Response
import config
import json
import time

def create_app():
  app = Flask(__name__)
  @app.after_request
  
  # Adds additional data to the response object before it is sent back to the client.
  def after_request(response):
    if response and response.get_json():
      data = response.get_json()
      data["time_request"] = int(time.time())
      data["version"] = config.VERSION

      response.set_data(json.dumps(data))
    return response
  
  # Error 404 handler
  @app.errorhandler(404)
  def resource_not_found(e):
    return jsonify(error=str(e)), 404
  # Error 405 handler
  @app.errorhandler(405)
  def resource_not_found(e):
    return jsonify(error=str(e)), 405
  # Error 401 handler
  @app.errorhandler(401)
  def custom_401(error):
    return Response("API Key required.", 401)
  
  @app.route("/ping")
  def hello_world():
     return "pong"
  
  @app.route("/version", methods=['GET'], strict_slashes=False)
  def version():
    response_body = {
      "success": 1
    }
    return jsonify(response_body)
  
app = create_app()

if __name__ == "__main__":
  #    app = create_app()
  print(" Starting app...")
  app.run(host="0.0.0.0", port=5000)