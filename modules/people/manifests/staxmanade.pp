class people::staxmanade {

  notify { 'initializing custom programs...': }
  $home     = "/Users/${::boxen_user}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"


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
  include flux
  include gimp

  include osx::global::enable_keyboard_control_access
  include osx::global::enable_standard_function_keys
  include osx::global::expand_save_dialog
  include osx::dock::clear_dock
  include osx::finder::show_hidden_files

  include osx::universal_access::enable_scrollwheel_zoom
  include osx::disable_app_quarantine
  include osx::no_network_dsstores

  exec { "XCode: turn on line numbers":
    provider => 'shell',
    command => "env -i bash -c 'defaults write com.apple.dt.Xcode DVTTextShowLineNumbers YES'"
  }

  exec { "XCode: set to the midnight theme":
    provider => 'shell',
    command => "env -i bash -c 'defaults write com.apple.dt.Xcode DVTFontAndColorCurrentTheme \'Midnight.dvtcolortheme\''"
  }

  class { 'osx::global::natural_mouse_scrolling':
    enabled => false
  }

  exec { "Setup pictures":
    provider => 'shell',
    command => "env -i bash -c 'mkdir -p ~/Pictures/Screenshots && defaults write com.apple.screencapture location ~/Pictures/Screenshots/ && killall SystemUIServer'"
  }


  file { $my:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'staxmanade/dotfiles-mac',
    require => File[$my]
  }
}
