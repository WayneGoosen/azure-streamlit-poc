FROM python:3.9-slim

LABEL maintainer="Wayne Goosen"
LABEL version="1.0.0"
LABEL description="Streamlit template for Docker. Uses app.py as the main file."

WORKDIR /app

RUN apt-get update \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip3 install -r requirements.txt

COPY .streamlit/config.toml .streamlit/
COPY app.py .

RUN groupadd -r appgroup && \
    useradd -r -g appgroup -u 1005 appuser && \
    chown -R appuser:appgroup /app

EXPOSE 80

USER appuser

ENTRYPOINT ["streamlit", "run"]
CMD ["app.py"]