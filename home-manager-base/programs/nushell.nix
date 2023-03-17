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
      let-env config = {
        show_banner: false
        edit_mode: vi
        max_history_size: 100000
        filesize_metric: false
        table_mode: rounded
        use_ls_colors: true
        hooks: {
          pre_prompt: [{
            code: "
              let direnv = (direnv export json | from json)
              let direnv = if ($direnv | length) == 1 { $direnv } else { {} }
              $direnv | load-env
            "
          }]
        }
      }
      source ~/.zoxide.nu
      source ~/.cache/starship/init.nu
      old-alias cd = z
      old-alias exa = exa --icons --git
      old-alias la = exa --icons --git -a
      old-alias ll = exa --icons --git -l
      old-alias lt = exa --icons --tree
      old-alias grep = rg
      old-alias cat = bat --style=plain
      old-alias cloc = tokei
      old-alias top = btm
      old-alias htop = btm
      old-alias vi = nvim
      old-alias vim = nvim
      old-alias nv = neovide
    '';
  };
}
