FROM python:3.11-slim

WORKDIR /app

# Install system dependencies if any are needed for langchain-chroma
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Set environment variable to point to the ollama service in the docker network
ENV OLLAMA_BASE_URL=http://ollama:11434

# Since it's an interactive app, we'll run it with -u to avoid buffering
CMD ["python", "-u", "main.py"]
