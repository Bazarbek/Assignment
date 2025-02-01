# Load the transactions CSV, skipping the first line if it contains unexpected data
input_file = '/path/to/transactions.csv'  # Replace with your file path
output_file = '/path/to/transactions_cleaned.csv'  # Cleaned file to be saved here

with open(input_file, 'r') as file:
    lines = file.readlines()

# Check if the first line contains metadata like 'Company 1'
if lines[0].startswith('Company'):
    cleaned_lines = lines[1:]  # Skip the first line
else:
    cleaned_lines = lines  # No changes if the first line is valid

# Save the cleaned data to a new file
with open(output_file, 'w') as file:
    file.writelines(cleaned_lines)

print("File cleaned and saved to:", output_file)
