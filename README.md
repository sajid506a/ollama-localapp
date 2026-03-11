# Restaurant Review Expert 🍔

An AI-powered application that answers questions about restaurant reviews using RAG (Retrieval-Augmented Generation) with Ollama and LangChain.

## 🚀 Quick Start

The easiest way to run the application is using the provided `run.sh` script (requires Git Bash or WSL on Windows).

### 🐳 Run with Docker (Recommended)
This starts Ollama, downloads the models (`llama3.2` and `mxbai-embed-large`), and runs the app.
```bash
./run.sh docker
```

### 💻 Run Locally
This sets up a Python virtual environment and runs the app on your host machine.
```bash
./run.sh local
```

## 🏗️ Project Structure

- `main.py`: The entry point for the interactive chat session.
- `vector.py`: Handles document loading, embeddings, and vector storage (Chroma).
- `realistic_restaurant_reviews.csv`: The dataset containing restaurant reviews.
- `Dockerfile` & `docker-compose.yml`: Docker configuration for the app and Ollama.
- `run.sh`: Unified bash script for running the project.

## 🛠️ Manual Setup

If you prefer not to use the script:

1. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

2. **Setup Ollama**:
   Ensure Ollama is running and the models are pulled:
   ```bash
   ollama pull llama3.2
   ollama pull mxbai-embed-large
   ```

3. **Run**:
   ```bash
   python main.py
   ```

## ⚙️ Configuration

The application uses environment variables for configuration. You can modify the `.env` file:
- `OLLAMA_BASE_URL`: The URL where Ollama is hosted (default: `http://localhost:11434`).
