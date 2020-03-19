# vim-composer

Vim support for [Composer PHP][composer] projects.

[![Build Status][buildimg]](https://travis-ci.org/noahfrederick/vim-composer)
[![Release][release]](https://github.com/noahfrederick/vim-composer/releases)

[composer]: https://getcomposer.org/
[buildimg]: https://img.shields.io/travis/noahfrederick/vim-composer/master.svg
[release]:  https://img.shields.io/github/tag/noahfrederick/vim-composer.svg?maxAge=2592000

## Features

Composer.vim provides conveniences for working with Composer PHP projects.
Some features include:

* `:Composer` command wrapper around `composer` with smart completion
* Navigate to source files using Composer's autoloader
* Insert `use` statement for the class/interface/trait under cursor
* [Projectionist][projectionist] support (e.g., `:Ecomposer` to edit your
  `composer.json`, `:A` to jump to `composer.lock` and back)
* [Dispatch][dispatch] support (`:Dispatch` runs `composer dump-autoload`)

See `:help composer` for details.

## Installation and Requirements

Using vim-plug, for example:

	Plug 'noahfrederick/vim-composer'

Optionally install [Dispatch.vim][dispatch] and
[Projectionist.vim][projectionist] for projections and asynchronous command
execution:

	Plug 'tpope/vim-dispatch'
	Plug 'tpope/vim-projectionist'

**Note**: either Projectionist.vim or Vim version 7.4.1304 or later is required
for JSON support.

## Credits and License

Thanks to Tim Pope for [Bundler.vim][bundler] on which Composer.vim is modeled.

Copyright © Noah Frederick. Distributed under the same terms as Vim itself.
See `:help license`.

[projectionist]: https://github.com/tpope/vim-projectionist
[dispatch]: https://github.com/tpope/vim-dispatch
[bundler]: https://github.com/tpope/vim-bundler
