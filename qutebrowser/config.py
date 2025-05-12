config.load_autoconfig()

kagi = 'https://kagi.com'
search_default = kagi

c.url.searchengines = {
    'DEFAULT':  search_default + "/search?q={}",
    'kagi':     search_default + "/search?q={}",
}

c.url.start_pages = search_default

leader = '<Space>'
config.bind(f'{leader}1', 'tab-focus 1')
config.bind(f'{leader}2', 'tab-focus 2')
config.bind(f'{leader}3', 'tab-focus 3')
config.bind(f'{leader}4', 'tab-focus 4')
config.bind(f'{leader}5', 'tab-focus 5')
config.bind(f'{leader}6', 'tab-focus 6')
config.bind(f'{leader}7', 'tab-focus 7')
config.bind(f'{leader}8', 'tab-focus 8')
config.bind(f'{leader}9', 'tab-focus -1')
config.bind(f'{leader}n', 'tab')
config.bind(f'{leader}q', 'tab-close')
config.bind(f'{leader}n', f'cmd-set-text -s :open -t')
config.bind(f'{leader}N', f'cmd-set-text -s :open -t {search_default}')
config.bind(f'{leader}r', 'reload')
config.bind('u', 'back')
config.bind('<Ctrl-R>', 'forward')
config.bind('<Ctrl-r>', 'config-source')
config.bind('J', 'scroll-page 0 0.5')
config.bind('K', 'scroll-page 0 -0.5')
config.bind(',m', 'spawn mpv {url}')
config.bind(',M', 'hint links spawn mpv {hint-url}')
config.bind('[', 'mode-enter caret')
config.bind(f's', f'cmd-set-text -s :open')

# vim editor bindings
# from https://github.com/SamuelFe/qute-vim-text-edit/blob/main/bindings.py
config.bind('\\', 'mode-enter normal', mode='insert')
config.bind('$', 'fake-key <End>')
config.bind('0', 'fake-key <Home>')
config.bind('I', 'fake-key <Home>;; mode-enter insert')
config.bind('A', 'fake-key <End>;; mode-enter insert')
config.bind('cw', 'fake-key <Ctrl-Delete>;; mode-enter insert')
config.bind('cc', 'fake-key <Home><Shift-End><Delete>;; mode-enter insert')
config.bind('c$', 'fake-key <Shift-End><Delete>;; mode-enter insert')

config.set("editor.command", ["termite", "-e", "vim {file}"])
config.set("colors.webpage.darkmode.enabled", True)
config.source("gruvbox.py")
