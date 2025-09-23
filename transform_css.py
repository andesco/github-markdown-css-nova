import re
import os
import glob
import argparse

def transform_css_file(input_filepath, replace_existing=False, root_selector=None):
    # Read the content of the input file
    with open(input_filepath, 'r') as f:
        content = f.read()

    # 1. replace ".markdown-body {" with "body {"
    content = content.replace(".markdown-body {", "body {")

    # 2. replace ".markdown-body " with ""
    content = content.replace(".markdown-body ", "")

    # 3. replace ".markdown-body," with "body,"
    content = content.replace(".markdown-body,", "body,")

    # 4. remove remaining CSS rules that matches this regex: ^\s*\.markdown-body[^{]*\{[^}]*\}
    
    content = re.sub(r'^\s*\.markdown-body[^{]*\{[^}]*\}', '', content, flags=re.MULTILINE)

    # 5. Insert the specified block at the start of the file
    # If --root-selector=body is used, prepend body-styles-prepend.css content
    if root_selector == 'body':
        body_css_path = os.path.join(os.path.dirname(input_filepath), 'body-styles-prepend.css')
        if os.path.exists(body_css_path):
            with open(body_css_path, 'r') as f:
                header_block = f.read() + '\n'
        else:
            # Fall back to default if body-styles-prepend.css doesn't exist
            header_block = """body {
  box-sizing: border-box;
  min-width: 200px;
  max-width: 980px;
  margin: 0 auto;
  padding: 45px;
}
@media (max-width: 767px) {
  body {
    padding: 15px;
  }
}
"""
    else:
        header_block = """body {
  box-sizing: border-box;
  min-width: 200px;
  max-width: 980px;
  margin: 0 auto;
  padding: 45px;
}
@media (max-width: 767px) {
  body {
    padding: 15px;
  }
}
"""
    content = header_block + content

    # Construct the new filename by appending "-nova"
    directory, filename = os.path.split(input_filepath)
    name, ext = os.path.splitext(filename)
    output_filename = f"{name}-nova{ext}"
    output_filepath = os.path.join(directory, output_filename)

    # Check if output file exists and handle replacement confirmation
    if os.path.exists(output_filepath) and not replace_existing:
        response = input(f"File {output_filepath} already exists. Overwrite? (y/n): ")
        if response.lower() != 'y':
            print(f"Skipping {output_filepath}.")
            return

    # Write the modified content to the new file
    with open(output_filepath, 'w') as f:
        f.write(content)

    print(f"Transformed file saved to: {output_filepath}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Transform CSS files.")
    parser.add_argument("input_file", nargs='?', help="The CSS file to transform. If not specified, all .css files not ending in -nova.css will be processed.")
    parser.add_argument("--replace", action="store_true", help="Do not ask for confirmation before overwriting existing files.")
    parser.add_argument("--root-selector", type=str, help="Specify root selector. If set to 'body', prepends body.css content to the generated file.")

    args = parser.parse_args()

    if args.input_file:
        transform_css_file(args.input_file, args.replace, args.root_selector)
    else:
        # No file specified, process all .css files not ending in -nova.css
        css_files = glob.glob("*.css")
        for css_file in css_files:
            if not css_file.endswith("-nova.css") and css_file != "body-styles-prepend.css":
                print(f"Processing {css_file}...")
                transform_css_file(css_file, args.replace, args.root_selector)
