#!/bin/bash
# Start the Vigilant AI FastAPI backend in the background on port 8000
uvicorn api.main:app --host 0.0.0.0 --port 8000 &

# Start the Streamlit dashboard in the foreground on the Hugging Face requested port (7860)
streamlit run dashboard/app.py --server.port 7860 --server.address 0.0.0.0
