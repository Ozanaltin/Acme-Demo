import os

# Define the directory to scan (e.g., force-app/main/default)
root_directory = "force-app/main/default"

# Metadata templates
metadata_templates = {
    "cls": """<?xml version="1.0" encoding="UTF-8"?>
<ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>62.0</apiVersion>
    <status>Active</status>
</ApexClass>
""",
    "trigger": """<?xml version="1.0" encoding="UTF-8"?>
<ApexTrigger xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>62.0</apiVersion>
    <status>Active</status>
</ApexTrigger>
""",
    # Add other metadata types as needed
}

# Walk through the project directory
for dirpath, _, filenames in os.walk(root_directory):
    for filename in filenames:
        ext = filename.split('.')[-1]  # Get file extension
        if ext in metadata_templates:
            # Check if the corresponding -meta.xml file exists
            base_name = os.path.splitext(filename)[0]
            meta_file_path = os.path.join(dirpath, f"{base_name}.{ext}-meta.xml")
            if not os.path.exists(meta_file_path):
                # Create the metadata file
                with open(meta_file_path, "w") as meta_file:
                    meta_file.write(metadata_templates[ext])
                print(f"Generated: {meta_file_path}")
