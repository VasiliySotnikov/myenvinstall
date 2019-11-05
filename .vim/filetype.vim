if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.wl		setfiletype mma
    au! BufRead,BufNewFile *.m		setfiletype mma
    au! BufRead,BufNewFile *.tex	setfiletype tex
    au! BufRead,BufNewFile *.dat        setfiletype sh
    au! BufRead,BufNewFile meson.build  setfiletype meson
    au! BufRead,BufNewFile meson_options.txt setfiletype meson
augroup END
