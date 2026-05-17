FROM python:3.11-slim
RUN pip install --no-cache-dir flask==3.1.0
WORKDIR /app
COPY app.py .
EXPOSE 5000
CMD ["python", "app.py"]
