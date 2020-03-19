# ![Laravel.vim](https://noahfrederick.com/pi/vim-laravel-888by140-40a40a.png)

Vim support for [Laravel/Lumen 5+][laravel] projects.

[![Release][release]](https://github.com/noahfrederick/vim-laravel/releases)

> :warning: This is a prerelease version, which may introduce breaking changes.

[laravel]:  https://laravel.com/
[release]:  https://img.shields.io/github/tag/noahfrederick/vim-laravel.svg?maxAge=2592000

## Features

* The `:Artisan` command wraps `!php artisan` with intelligent completion.
* Automatically edit new files generated by `:Artisan make:*` commands.
* Navigation commands (requires [projectionist.vim][projectionist]):

| Command               | Applies to...                  |
|-----------------------|--------------------------------|
| `:{E,S,V,T}asset`     | Anything under `assets/`       |
| `:Ebootstrap`         | Bootstrap files in `boostrap/` |
| `:Echannel`           | Broadcast channels             |
| `:Ecommand`           | Console commands               |
| `:Econfig`            | Configuration files            |
| `:Econtroller`        | HTTP controllers               |
| `:Edoc`               | The `README.md` file           |
| `:Eenv`               | Your `.env` and `.env.example` |
| `:Eevent`             | Events                         |
| `:Eexception`         | Exceptions                     |
| `:Efactory`           | Model factories                |
| `:Ejob`               | Jobs                           |
| `:Elanguage`          | Messages/translations          |
| `:Elib`               | All class files under `app/`   |
| `:Elistener`          | Event listeners                |
| `:Email`              | Mailables                      |
| `:Emiddleware`        | HTTP middleware                |
| `:Emigration`         | Database migrations            |
| `:Enotification`      | Notifications                  |
| `:Epolicy`            | Auth policies                  |
| `:Eprovider`          | Service providers              |
| `:Erequest`           | HTTP form requests             |
| `:Eresource`          | HTTP resources                 |
| `:Eroutes`            | HTTP routes files              |
| `:Erule`              | Validation rules               |
| `:Eseeder`            | Database seeders               |
| `:Etest`              | All class files under `tests/` |
| `:Eview`              | Blade templates                |

* Enhanced `gf` command works on class names, template names, config and translation keys.
* Complete view/route names in insert mode.
* Use `:Console` to fire up a REPL (`artisan tinker`).

## Installation

Laravel.vim has optional dependencies on [composer.vim][vim-composer],
[dispatch.vim][dispatch] (the `:Console` command),
[projectionist.vim][projectionist] (navigation commands), and
[nvim-completion-manager][ncm] (insert-mode completion):

	Plug 'tpope/vim-dispatch'             "| Optional
	Plug 'tpope/vim-projectionist'        "|
	Plug 'roxma/nvim-completion-manager'  "|
	Plug 'noahfrederick/vim-composer'     "|
	Plug 'noahfrederick/vim-laravel'

## Credits and License

Thanks to Tim Pope for [rails.vim][rails] on which Laravel.vim is modeled.

Copyright © Noah Frederick. Distributed under the same terms as Vim itself.
See `:help license`.

[vim-composer]: https://github.com/noahfrederick/vim-composer
[projectionist]: https://github.com/tpope/vim-projectionist
[dispatch]: https://github.com/tpope/vim-dispatch
[ncm]: https://github.com/roxma/nvim-completion-manager
[rails]: https://github.com/tpope/vim-rails