def process_file(input_file_path, output_file_path, encoding='utf-8'):
    try:
        # Open the input file for reading with specified encoding
        with open(input_file_path, 'r', encoding=encoding) as input_file:
            # Open the output file for writing with the same encoding
            with open(output_file_path, 'w', encoding=encoding) as output_file:
                # Read each line from the input file
                for line in input_file:
                    # Find the position where '.jpeg' needs to be inserted
                    insert_position = line.find("),")
                    # Check if the line is correctly formatted before attempting to modify it
                    if insert_position != -1:
                        # Insert '.jpeg' before the closing parenthesis of the image path
                        modified_line = line[:insert_position] + ".jpeg'" + line[insert_position:]
                        # Write the modified line to the output file
                        output_file.write(modified_line)
        print("Processing complete. Check the output file for updated data.")
    except UnicodeDecodeError as e:
        print(f"Error reading file: {e}. Try changing the encoding parameter.")

# Specify the path to your input and output files
input_file_path = '363_P1\images.txt'
output_file_path = 'output.txt'

# Try different encodings if 'utf-8' doesn't work, such as 'cp1252' or 'latin1'
process_file(input_file_path, output_file_path, encoding='utf-8')
# If you encounter the UnicodeDecodeError with utf-8, try using 'cp1252' or 'latin1' instead
# process_file(input_file_path, output_file_path, encoding='cp1252')
