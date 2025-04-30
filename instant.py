import argparse
import re
import os
import shutil

def smart_replace(text, old_phrase, new_phrase):
    def replacement(match):
        matched = match.group(0)
        if matched.isupper():
            return new_phrase.upper()
        elif matched[0].isupper():
            return new_phrase.capitalize()
        else:
            return new_phrase
    return re.sub(re.escape(old_phrase), replacement, text, flags=re.IGNORECASE)

def smart_rename(name, old_phrase, new_phrase):
    def replace_match(match):
        matched = match.group(0)
        if matched.isupper():
            return new_phrase.upper()
        elif matched[0].isupper():
            return new_phrase.capitalize()
        else:
            return new_phrase
    return re.sub(re.escape(old_phrase), replace_match, name, flags=re.IGNORECASE)

def process_file(filepath, replacements):
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Check for file-level pragma
    if lines and '// ut_del_pragma_file' in lines[0]:
        os.remove(filepath)
        print(f'File deleted due to pragma: {filepath}')
        return

    # Process content
    new_lines = []
    skip_block = False
    for line in lines:
        if '// ut_del_pragma_begin' in line:
            skip_block = True
            continue
        if '// ut_del_pragma_end' in line:
            skip_block = False
            continue
        if skip_block:
            continue
        if '// ut_del_pragma' in line:
            continue
        new_lines.append(line)

    # Apply smart replacements
    content = ''.join(new_lines)
    for old_phrase, new_phrase in replacements:
        content = smart_replace(content, old_phrase, new_phrase)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f'Content updated: {filepath}')


def ignore_hidden(dir, files):
    return [f for f in files if f.startswith('.')]  

def rename_structure(root_dir, replacements):
    for current_root, dirs, files in os.walk(root_dir, topdown=False):

        dirs[:] = [d for d in dirs if not d.startswith('.')]
        files = [f for f in files if not f.startswith('.')]
        
        for name in files:
            old_path = os.path.join(current_root, name)
            new_name = name
            for old, new in replacements:
                new_name = smart_rename(new_name, old, new)
            new_path = os.path.join(current_root, new_name)
            if new_path != old_path:
                os.rename(old_path, new_path)
                print(f'File renamed: {old_path} → {new_path}')
                old_path = new_path
            process_file(new_path, replacements)

        for name in dirs:
            old_dir = os.path.join(current_root, name)
            new_name = name
            for old, new in replacements:
                new_name = smart_rename(new_name, old, new)
            new_dir = os.path.join(current_root, new_name)
            if new_dir != old_dir:
                os.rename(old_dir, new_dir)
                print(f'Dir renamed: {old_dir} → {new_dir}')

def main():
    parser = argparse.ArgumentParser(description="Template instantiation: copy and rename.")

    parser.add_argument('--mode', choices=['env', 'agent'], default='env',
                        help='Mode of operation: env or agent (default: env)')
    parser.add_argument('--company', default='work',
                        help='Company name (default: work)')
    parser.add_argument('--name', default='project',
                        help='Environment or agent name (default: project)')
    parser.add_argument('--target_dir', default='./output',
                        help='Where to copy the template and instantiate (default: ./output)')

    args = parser.parse_args()

    print(f"Instantiating {args.mode} for {args.company}/{args.name} into {args.target_dir}")

    template_dir = "./comp1_agent1_agent" if args.mode == "agent" else "./comp1_env1_env"

    template_basename = os.path.basename(template_dir)
    dst_raw = os.path.join(args.target_dir, template_basename)

    shutil.copytree(template_dir, dst_raw, dirs_exist_ok=True,ignore=ignore_hidden)
    print(f"Template copied: {dst_raw}")

    replacements = [("comp1", args.company), ("env1", args.name), ("agent1", args.name)]

    rename_structure(dst_raw, replacements)

    final_dirname = template_basename
    for old, new in replacements:
        final_dirname = smart_rename(final_dirname, old, new)

    final_dst = os.path.join(args.target_dir, final_dirname)
    if final_dst != dst_raw:
        os.rename(dst_raw, final_dst)
        print(f"Dir renamed: {dst_raw} → {final_dst}")

    print("Template fully instantiated.")

if __name__ == '__main__':
    main()