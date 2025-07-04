#!/usr/bin/env python3

import os
import sys
from pathlib import Path

CONFIG_FILE = Path(__file__)
CONFIG_DIR = CONFIG_FILE.parent
THEMES_DIR = CONFIG_DIR / "themes"
qute_buf = os.environ.get('QUTE_FIFO')

SOURCE_FILES = [
    CONFIG_DIR / "bindings.py",
]

term = "termite"
editor = "vim"

search_engines = {
    'kagi':     'https://kagi.com',
    'youtube':  'https://yewtu.be',
    'github':   'https://github.com',
}
search_default = 'kagi'
start_page = search_engines['kagi']
darkmode = True
theme = 'gruvbox'


for f in SOURCE_FILES:
    exec(open(f).read())

def qute_print(msg):
    with open(qute_buf, 'w') as fifo:
        fifo.write(f":spawn --output-messages echo {msg}\n")

def qute_exec(cmd):
    with open(qute_buf, 'w') as fifo:
        fifo.write(f':spawn {cmd}\n')

def qute_init():
    config.load_autoconfig(False)
    c.url.start_pages = start_page

    sq = "/search?q={}"
    c.url.searchengines['DEFAULT'] = search_engines[search_default] + sq
    for key, val in search_engines.items():
        c.url.searchengines[key] = val + sq

    for d in [default_bindings, bindings]:
        for mode, kp in bindings.items():
            for key, val in kp.items():
                config.bind(key, val, mode=mode)

    config.set("editor.command", [term, "-e", editor + " {file}"])
    config.set("colors.webpage.darkmode.enabled", darkmode)

    theme_file = THEMES_DIR / f"{theme}.py"
    if Path.absolute(theme_file):
        config.source(theme_file)
    else:
        qute_print(str(theme_file))

def dict_to_page(f, dic):
    for mode, d in dic.items():
        f.write(f"{mode:<15}\n")
        for key, val in d.items():
            f.write(f"{" ":<15}{key:<15}{" ":<15}{val:<15}\n")
        f.write("\n")

def display_user():
    file_path = CONFIG_DIR / "user_bindings.txt"

    # Write bindings to the file
    with open(file_path, 'w') as f:
        f.write(f"User Bindings from {CONFIG_FILE}\n\n")
        dict_to_page(f, bindings)

    # Open the file in a new tab
    with open(qute_buf, 'w') as fifo:
        fifo.write(f"open -t {file_path}")

def display_defaults():
    file_path = CONFIG_DIR / "default_bindings.txt"
    default_dict = CONFIG_DIR / "default_bindings.py"

    # Write bindings to the file
    with open(file_path, 'w') as f:
        f.write(f"Default Bindings from {default_dict}\n\n")
        dict_to_page(f, default_bindings)

    # Open the file in a new tab
    with open(qute_buf, 'w') as fifo:
        fifo.write(f"open -t {file_path}")

# config.py can be invoked directly as a userscript
if __name__ == "__main__":
    cmd = sys.argv[1]
    if cmd == "help":
        display_user()
    if cmd == "defaults":
        display_defaults()
    
else:
    qute_init()
