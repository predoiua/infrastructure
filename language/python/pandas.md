
import pandas as pd

# Create a list of data
data = [
    {'ID': 1, 'Name': 'John Doe', 'Age': 32, 'City': 'New York'},
    {'ID': 2, 'Name': 'Jane Doe', 'Age': 28, 'City': 'Chicago'},
    {'ID': 3, 'Name': 'Peter Jones', 'Age': 45, 'City': 'Los Angeles'},
    {'ID': 4, 'Name': 'Mary Smith', 'Age': 23, 'City': 'San Francisco'},
    {'ID': 5, 'Name': 'David Williams', 'Age': 51, 'City': 'Houston'},
]

# Create a DataFrame
df = pd.DataFrame(data)

# Display the DataFrame
print(df)

df.loc[df['Name'] == 'John Doe', 'City'] = 'New York City'
df

# Iterate over the distinct cities
distinct_cities = df['City'].unique()
for city in distinct_cities:
  print(city, type(city))