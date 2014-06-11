class people::staxmanade {

  notify { 'initializing custom programs...': }

  include alfred
  include iterm2::stable
  include hub
  include dropbox
  include chrome
  include chrome::canary
  include mou               # Markdown Editor
  include spectacle         # window manager
  include cloudapp
  include zsh
  include ohmyzsh

  include osx::global::enable_keyboard_control_access
  include osx::global::enable_standard_function_keys
  include osx::global::expand_save_dialog
  include osx::dock::clear_dock
  include osx::finder::show_hidden_files

  include osx::universal_access::enable_scrollwheel_zoom
  include osx::disable_app_quarantine
  include osx::no_network_dsstores

  class { 'osx::global::natural_mouse_scrolling':
    enabled => false
  }

  $home     = "/Users/${::boxen_user}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  file { $my:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'staxmanade/dotfiles',
    require => File[$my]
  }
}
