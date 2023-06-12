package: {
  inherit package;
  enable = true;

  envFile = {
    text = ''
      zoxide init nushell
        | str replace '&&' 'and'
        | str replace '\|\|' 'or'
        | save -f ~/.zoxide.nu

      mkdir ~/.cache/starship
      starship init nu
        | save -f ~/.cache/starship/init.nu
    '';
  };

  configFile = {
    text = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
      }
      let-env config = {
        show_banner: false
        edit_mode: vi
        history: {
          max_size: 100000
        }
        filesize: {
          metric: true
        }
        ls: {
          use_ls_colors: true
        }
        table: {
          mode: rounded
        }
        hooks: {
          pre_prompt: [{
            code: "
              let direnv = (direnv export json | from json)
              let direnv = if ($direnv | length) == 1 { $direnv } else { {} }
              $direnv | load-env
            "
          }]
        }
        completions: {
          external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
          }
          algorithm: "fuzzy"
        }
      }
      source ~/.zoxide.nu
      source ~/.cache/starship/init.nu
      alias cd = z
      alias exa = exa --icons --git
      alias la = exa --icons --git -a
      alias ll = exa --icons --git -l
      alias lt = exa --icons --tree
      alias grep = rg
      alias cat = bat --style=plain
      alias cloc = tokei
      alias top = btm
      alias htop = btm
      alias vi = nvim
      alias vim = nvim
      alias nv = neovide
      alias :e = nvim
      alias :q = exit
      alias :qa = exit
      alias :wq = exit
      alias :x = exit
      alias :w = cowsay 'You are not in neovim anymore.'
      alias :wa = cowsay 'You are not in neovim anymore.'
    '';
  };
}
