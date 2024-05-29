# Use an official lightweight Python image.
# https://hub.docker.com/_/python

# thank you to https://medium.com/google-cloud/deploy-a-python-flask-server-using-google-cloud-run-d47f728cc864
FROM python:3.10-slim

# Turn off Python's buffering: any output is directly written to the terminal.
ENV PYTHONUNBUFFERED True

# Set the working directory to /app
ENV APP_HOME /app

# Set the port the app runs on
ENV PORT 5000

# Set the working directory in the Docker image to be /app
WORKDIR $APP_HOME

# Copy the current directory (on your machine) to the /app folder in the Docker image
COPY . ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Run the command to start your application
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 src.main:app