FROM python:3.10-slim

# Install necessary system dependencies
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Hugging Face runs containers as a non-root user (id=1000)
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

# Copy requirements and install via pip
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY --chown=user . .

# Ensure start script is executable
RUN chmod +x start.sh

# Expose the Streamlit port
EXPOSE 7860

# Run both the API and Dashboard
CMD ["./start.sh"]
