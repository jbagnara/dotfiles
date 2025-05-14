#!/usr/bin/env python3

import os
import sys
from pathlib import Path

THIS_FILE = Path(__file__)
CONFIG_DIR = THIS_FILE.parent
THEMES_DIR = CONFIG_DIR / "themes"
qute_buf = os.environ.get('QUTE_FIFO')

term = "termite"
editor = "vim"

search_engines = {
    'kagi': 'https://kagi.com',
    'youtube': 'https://yewtu.be',
}
search_default = 'kagi'
start_page = search_engines['kagi']
darkmode = True
theme = 'gruvbox'

leader = '<Space>'
bindings = {
    'normal': {
        f'{leader}1':       f'tab-focus 1',
        f'{leader}2':       f'tab-focus 2',
        f'{leader}3':       f'tab-focus 3',
        f'{leader}4':       f'tab-focus 4',
        f'{leader}5':       f'tab-focus 5',
        f'{leader}6':       f'tab-focus 6',
        f'{leader}7':       f'tab-focus 7',
        f'{leader}8':       f'tab-focus 8',
        f'{leader}9':       f'tab-focus -1',
        f'{leader}n':       f'tab',
        f'{leader}q':       f'tab-close',
        f'{leader}n':       f'cmd-set-text -s :open -t',
        f'{leader}N':       f'cmd-set-text -s :open kagi',
        f'{leader}r':       f'reload',
        f'{leader}yt':      f'cmd-set-text -s :open -t youtube',
        f'{leader}yp':      f'hint links fill :spawn mpv {{hint-url}}',
        f'{leader}h':       f'spawn --userscript {THIS_FILE} help',
        f'{leader}e':       f'edit-text;; mode-enter insert',

        'u':                'back',
        '<Ctrl-r>':         'forward',
        '<Ctrl-c>':         'config-source',
        'J':                'scroll-page 0 0.5',
        'K':                'scroll-page 0 -0.5',
        ':M':               'hint links spawn mpv {hint-url}',
        '[':                'mode-enter caret',
        's':                'cmd-set-text -s :open',

# vim editor bindings
# from https://github.com/SamuelFe/qute-vim-text-edit/blob/main/bindings.py
        '$':                'fake-key <End>',
        '0':                'fake-key <Home>',
        'I':                'fake-key <Home>;; mode-enter insert',
        'A':                'fake-key <End>;; mode-enter insert',
        'cw':               'fake-key <Ctrl-Delete>;; mode-enter insert',
        'cc':               'fake-key <Home><Shift-End><Delete>;; mode-enter insert',
        'c$':               'fake-key <Shift-End><Delete>;; mode-enter insert',
    },

    'insert': {
        '\\':               'mode-enter normal',
    },
}

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

    for mode, d in bindings.items():
        for key, val in d.items():
            config.bind(key, val, mode=mode)

    config.set("editor.command", [term, "-e", editor + " {file}"])
    config.set("colors.webpage.darkmode.enabled", darkmode)

    theme_file = THEMES_DIR / f"{theme}.py"
    if Path.absolute(theme_file):
        config.source(theme_file)
    else:
        qute_print(str(theme_file))

# Display ONLY user defined bindings
def display_help():
    file_path = CONFIG_DIR / "user_bindings.txt"

    # Write bindings to the file
    with open(file_path, 'w') as f:
        f.write(f"User Bindings from {THIS_FILE}\n\n")
        for mode, d in bindings.items():
            f.write(f"{mode:<10}\n")
            for key, val in d.items():
                f.write(f"{" ":<10}{key:<10}{" ":<10}{val:<10}\n")
            f.write("\n")

    # Open the file in a new tab
    with open(qute_buf, 'w') as fifo:
        fifo.write(f"open -t {file_path}")

# config.py can be invoked directly as a userscript
if __name__ == "__main__":
    cmd = sys.argv[1]
    if cmd == "help":
        display_help()
    
else:
    qute_init()
