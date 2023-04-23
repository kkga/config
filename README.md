Relatively simple Linux config for desktop, managed with a
[chezmoi][https://www.chezmoi.io/].

![](/private_dot_local/private_share/desktop.png)

- **os**: [Void Linux]
- **desktop**: [Sway] ([sway-config])
- **bar**: [yambar] ([yambar-config])
- **menu**: [fzf-menu]
- **term**: [foot] ([config][foot-config])
- **shell**: [fish] ([config][fish-config])
- **editor**: [Kakoune] ([config][kak-config])
- **ui font**: [Inter]
- **mono font**: [MD IO]
- **colors**: [saturn]

[git-bare]: https://www.atlassian.com/git/tutorials/dotfiles
[yadm]: https://github.com/TheLocehiliosan/yadm
[void linux]: https://voidlinux.org
[sway]: https://github.com/swaywm/sway/
[sway-config]: /.config/sway/config
[yambar]: https://codeberg.org/dnkl/yambar
[yambar-config]: /.config/yambar/config.tml
[fish]: https://fishshell.com/
[fish-config]: /.config/fish/config.fish
[foot]: https://codeberg.org/dnkl/foot
[foot-config]: /.config/foot/foot.ini
[kakoune]: https://kakoune.org
[kak-config]: /.config/kak/
[fzf-menu]: /.local/bin/fzf-menu
[saturn]: https://github.com/kkga/saturn.kak
[Inter]: https://rsms.me/inter/
[MD IO]: https://www.futurefonts.xyz/mass-driver/io

- [.local/bin][bin]: scripts intended for interactive usage
- [.local/libexec][libexec]: scripts not intended for interactive usage
- [.local/sv][sv]: [runit][runit-void] user services

[bin]: ./.local/bin/
[libexec]: ./.local/libexec/
[sv]: ./.local/sv/
[runit-void]: https://docs.voidlinux.org/config/services/index.html
