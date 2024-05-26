# Streamlit Docker

This is a Dockerfile & relevant app files for running a Streamlit application. The main application file is `app.py`.

## Dockerfile Details

- The base image is `python:3.9-slim`.
- The Dockerfile creates a working directory at `/app`.
- It updates the package lists for upgrades and new package installations.
- It copies `requirements.txt` into the Docker image and installs the Python dependencies.
- It copies `app.py` (the main application file) into the Docker image.
- It creates a group `appgroup` and a user `appuser` with group ID and user ID 1005, respectively. It then changes the ownership of the `/app` directory to `appuser:appgroup`.
- It exposes port 8501 for the Streamlit application.
- It sets `appuser` as the user to run the subsequent commands and the application.
- The entrypoint is set to `streamlit run`, and the command is set to run `app.py` with server port 8501 and server address 0.0.0.0.

## Building the Docker Image

To build the Docker image, navigate to the directory containing the Dockerfile and run the following command:

```bash
docker build -t my-streamlit-app .
```

## Running the Docker Container

To run the Docker container, use the following command:

```bash
docker run -p 8501:80 my-streamlit-app:latest
```

# Streamlit configuration

Besides the config.toml the configuration can be passed as a param:
- "--server.port=8501"
- "--server.address=127.0.0.1"
- "--client.showErrorDetails=true"
- "--client.toolbarMode=minimal"

Find more configuration [here](https://docs.streamlit.io/develop/api-reference/configuration/config.toml)

# References

- [Deploy streamlit using Docker](https://docs.streamlit.io/deploy/tutorials/docker)