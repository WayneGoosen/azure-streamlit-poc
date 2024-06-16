# Deploy Streamlit using Docker 🐳

This folder contains a Dockerfile & relevant app files for running a Streamlit application within a container. The main application file is `app.py`.

View a full [walkthrough of containerizing this Streamlit application.](https://blog.waynegoosen.com/post/streamlit-deployment-guide-part-1-containerization/)

## Building the Docker Image

To build the Docker image, navigate to the directory containing the Dockerfile and run the following command:

```bash
docker build -t streamlit-app .
```

## Running the Docker Container

To run the Docker container, use the following command:

```bash
docker run -p 8501:80 streamlit-app:latest
```

# References

- [Deploy streamlit using Docker](https://docs.streamlit.io/deploy/tutorials/docker)