FROM python:3.12-slim

LABEL org.opencontainers.image.authors="Wayne Goosen" \
      org.opencontainers.image.description="Streamlit template for Docker. Uses app.py as the main file." \
      org.opencontainers.image.source="https://github.com/WayneGoosen/azure-streamlit-poc"

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

RUN groupadd -g 1005 appgroup && \
    useradd -u 1005 -g appgroup --create-home appuser

COPY --chown=appuser:appgroup requirements.txt .
RUN pip install -r requirements.txt

COPY --chown=appuser:appgroup .streamlit/config.toml .streamlit/
COPY --chown=appuser:appgroup app.py .

EXPOSE 80

USER appuser

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://localhost:80/_stcore/health').status==200 else 1)"

ENTRYPOINT ["streamlit", "run"]
CMD ["app.py"]
