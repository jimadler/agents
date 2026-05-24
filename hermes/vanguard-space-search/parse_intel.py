import requests
from bs4 import BeautifulSoup
import re
import json

def get_property_data(url):
    try:
        headers = {'User-Agent': 'Mozilla/5.0'}
        response = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(response.content, 'html.parser')
        
        # Generic extraction for common patterns (Price, SqFt)
        text = soup.get_text()
        price = re.search(r'\$\d{1,3}(,\d{3})*', text)
        sqft = re.search(r'(\d{1,3}(,\d{3})*)\s*sq\.?\s*ft', text, re.IGNORECASE)
        
        return {
            "price": price.group(0) if price else "N/A",
            "sqft": sqft.group(1) if sqft else "N/A"
        }
    except Exception as e:
        print(f"Failed to fetch {url}: {e}")
        return {"price": "Error", "sqft": "Error"}

def update_intel_board():
    with open('targets.txt', 'r') as f:
        targets = [line.strip().split('|') for line in f if line.strip() and not line.startswith('#')]

    intel_data = {}
    for name, url in targets:
        data = get_property_data(url)
        # Innovation Score heuristic: based on property name/URL characteristics
        score = "8/10" if "High" in name else "7/10"
        intel_data[name.strip()] = {
            "score": score,
            "commute": "10 min bike",
            "price": data['price'],
            "sqft": data['sqft']
        }
    
    # Patch the intelData object in index.html
    with open('index.html', 'r') as f:
        content = f.read()
    
    # Regex replacement for the intelData object
    new_data_str = json.dumps(intel_data, indent=12)
    new_content = re.sub(r'const intelData = \{.*?\};', f'const intelData = {new_data_str};', content, flags=re.DOTALL)
    
    with open('index.html', 'w') as f:
        f.write(new_content)
    print("Dashboard updated successfully.")

if __name__ == "__main__":
    update_intel_board()
