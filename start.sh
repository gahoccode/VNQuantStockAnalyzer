#!/bin/bash
# start.sh - Script to run the Streamlit application on Render

# Make the script fail on error
set -o errexit

# Use the PORT environment variable provided by Render
export PORT=${PORT:-8501}

# Streamlit uses its own server, we just need to tell it which port to use
exec streamlit run --server.port=$PORT --server.address=0.0.0.0 app.py
