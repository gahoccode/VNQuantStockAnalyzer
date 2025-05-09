# VNQuant Stock Analyzer

A Streamlit-based application for Vietnamese stock market data analysis and visualization with Modern Portfolio Theory (MPT) optimization using the VNQuant library.

## Features

- **Stock Data Retrieval**: Load data from CAFEF, VND, SSI sources for Vietnamese stocks
- **Interactive Visualization**: Candlestick charts with volume and technical indicators
- **Statistical Analysis**: Calculate key metrics like returns, volatility, and max drawdown
- **Portfolio Optimization**: Apply Modern Portfolio Theory to find optimal portfolios
- **Data Export**: Download stock data for further analysis

## Installation

### Requirements

- Python 3.10.11 or newer
- Required libraries (see requirements.txt)

### Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/gahoccode/VNQuantStockAnalyzer.git
   cd VNQuantStockAnalyzer
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   # On Windows
   venv\Scripts\activate
   # On Linux/Mac
   source venv/bin/activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run the application:
   ```bash
   streamlit run app.py
   ```

## Docker Deployment

For containerized deployment, VNQuant Stock Analyzer provides a Docker setup that ensures consistent environments across different systems.

### Prerequisites
- Docker installed on your system
- Docker Compose (optional, for easier management)

### Quick Start with Docker

1. **Build the Docker Image**
```bash
# From the project directory
docker build -t vnquant-stockanalyzer .
```

2. **Run the Container**
```bash
# Run with default settings
docker run -p 8501:8501 vnquant-stockanalyzer

# Run with custom volume for data persistence
docker run -p 8501:8501 -v $(pwd)/data:/app/data vnquant-stockanalyzer
```

3. **Access the Application**
- Open your browser and navigate to `http://localhost:8501`
- The Streamlit interface will load with all features:
  - Stock data visualization
  - Modern Portfolio Theory analysis
  - Portfolio optimization tools

### Environment Variables
You can customize the deployment using environment variables:
```bash
docker run -p 8501:8501 \
  -e STREAMLIT_SERVER_PORT=8501 \
  -e STREAMLIT_SERVER_ADDRESS=0.0.0.0 \
  vnquant-stockanalyzer
```

### Data Handling and Persistence
- Mount a volume to persist data between container restarts
- Useful for saving analysis results and configurations
```bash
docker run -p 8501:8501 \
  -v $(pwd)/data:/app/data \
  vnquant-stockanalyzer
```

## Usage

### Using the Streamlit Application

1. Select stock symbols from the sidebar
2. Choose a date range and data source (CAFE or VND)
3. Click "Generate Chart" to create visualizations
4. For multiple symbols, set portfolio weights using sliders
5. View Modern Portfolio Theory optimizations on the MPT page

### Features

- **Stock Selection**: Multiple stock selection with date range filtering
- **Data Source Options**: Support for VND and CAFE data sources
- **Interactive Charts**: Candlestick charts with technical indicators
- **Portfolio Analysis**: Performance metrics and optimization
- **Modern Portfolio Theory**: Efficient frontier visualization and optimal portfolio allocation
- **Data Export**: Download stock data for further analysis

## Project Structure

- `app.py`: Main Streamlit application entry point
- `data_loader.py`: Functions for loading stock data from various sources
- `stock_analysis.py`: Statistical analysis and calculation functions
- `visualization.py`: Chart generation and visualization components
- `streamlit_components.py`: Reusable UI components for Streamlit
- `mpt_analysis.py`: Modern Portfolio Theory implementation
- `tests/`: Unit tests for critical functionality

## Modular Application Structure

The VNQuant-GUI Stock Analyzer application has been modularized to improve code organization, maintainability, and extensibility. The application is now divided into the following modules:

### 1. data_loader.py

This module handles all data loading operations:

```python
import data_loader as dl

# Load data from VNQuant API
data = dl.load_stock_data(
    symbols=["REE", "FMC"],
    start_date="2024-12-01",
    end_date="2025-03-01",
    data_source="cafe",
    table_style="prefix"
)

# Load data from a CSV file
data = dl.load_stock_data_from_file("path/to/data.csv")

# Get price columns for a specific symbol
close_prices, adjust_prices = dl.get_price_columns(data, "REE", table_style="prefix")
```

### 2. stock_analysis.py

This module contains all analysis and calculation functions:

```python
import stock_analysis as sa

# Calculate returns using adjusted prices
returns = sa.calculate_returns(adjust_prices)

# Calculate price statistics
stats = sa.calculate_price_statistics(close_prices, adjust_prices)

# Calculate portfolio performance
portfolio_stats = sa.calculate_portfolio_performance(
    data,
    symbols=["REE", "FMC"],
    price_columns_func=dl.get_price_columns,
    table_style="prefix",
    weights={"REE": 0.6, "FMC": 0.4}
)

# Calculate risk metrics
risk_metrics = sa.calculate_risk_metrics(adjust_prices)
```

### 3. visualization.py

This module handles all visualization functions:

```python
import visualization as viz

# Generate candlestick chart
fig = viz.generate_candlestick_chart(
    symbol="REE",
    start_date="2024-12-01",
    end_date="2025-03-01",
    data_source="cafe",
    advanced_indicators=["volume", "macd"]
)

# Create returns chart
returns_chart = viz.create_returns_chart(returns, symbol="REE")

# Create portfolio comparison chart
portfolio_chart = viz.create_portfolio_comparison_chart(portfolio_stats)
```

### 4. streamlit_components.py

This module contains all UI components for the Streamlit app:

```python
import streamlit_components as sc

# Set up page configuration
sc.setup_page_config()

# Display app header
sc.display_header()

# Get user inputs from sidebar
inputs = sc.sidebar_inputs()

# Display data
sc.display_data(data)

# Display price statistics
sc.display_price_statistics(stats)

# Display returns
sc.display_returns(returns)

# Display chart
sc.display_chart(fig)
```

### 5. streamlit_app.py

This is the main application file that connects all the modules. Run it with:

```bash
streamlit run streamlit_app.py
```

## Important Notes About the Modular Structure

1. **Separation of Concerns**: Each module has a specific responsibility, making the code easier to maintain and extend.
2. **Adjusted Prices**: All stock performance calculations use adjusted prices as required by the rules.
3. **Data Loading**: The `data_loader.py` module supports loading data from both the VNQuant API and CSV files.
4. **Visualization**: The `visualization.py` module uses the VNQuant library's `vnquant_candle_stick` function for candlestick charts and Plotly for other visualizations.
5. **Portfolio Analysis**: The application supports portfolio performance analysis with custom weights for multiple stocks.

## Recent Changes

- Fixed portfolio comparison chart with time series data
- Added missing calculate_statistics function
- Improved error handling in portfolio performance calculations
- Enhanced UI feedback for data loading errors

## Troubleshooting

- If you encounter connection errors with data sources, try switching between CAFE and VND
- Ensure date format is 'YYYY-MM-DD' in all inputs
- For portfolio analysis, make sure to select at least two symbols
- If charts fail to render, check browser console for any JavaScript errors

## Credits

This application uses the [VNQuant library](https://github.com/phamdinhkhanh/vnquant) for Vietnamese stock data retrieval.
