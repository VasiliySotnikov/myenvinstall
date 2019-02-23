if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.wl		setfiletype mma
    au! BufRead,BufNewFile *.m		setfiletype mma
augroup END
