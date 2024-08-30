function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert \cf forward-word
    bind \cF forward-word
    bind -M insert \ce accept-autosuggestion
    bind \cE accept-autosuggestion
end

#fzf_key_bindings
