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
  include zsh
  include ohmyzsh
  include flux
  include gimp

  include osx::global::enable_keyboard_control_access
  include osx::global::enable_standard_function_keys
  include osx::global::expand_save_dialog
  include osx::dock::clear_dock
  include osx::finder::show_hidden_files
  include osx::finder::enable_quicklook_text_selection

  include osx::universal_access::enable_scrollwheel_zoom
  include osx::disable_app_quarantine
  include osx::no_network_dsstores
  include osx::dock::autohide

  class { 'osx::global::natural_mouse_scrolling':
    enabled => false
  }

  exec { "osx: mouse scaling":
    provider => 'shell',
    command => "env -i bash -c 'defaults write -g com.apple.mouse.scaling -float 2.1'"
  }

  exec { "finder: show file extensions":
    provider => 'shell',
    command => "env -i bash -c 'defaults write com.apple.finder AppleShowAllExtensions -boolean true'"
  }

  # OSX: Kill the dashboard
  exec { "osx: disable dashboard":
    provider => 'shell',
    command => "env -i bash -c 'defaults write com.apple.dashboard mcx-disabled -boolean true'"
  }

  exec { "Setup pictures":
    provider => 'shell',
    command => "env -i bash -c 'mkdir -p ~/Pictures/Screenshots && defaults write com.apple.screencapture location ~/Pictures/Screenshots/ && killall SystemUIServer'"
  }

  # Skype
  exec { "Skype: DisableAllVisualNotifications":
    provider => 'shell',
    command => "env -i bash -c 'defaults write com.skype.skype DisableAllVisualNotifications -boolean true'"
  }

  # Safari
  exec { "Safari: enable dev mode":
    provider => 'shell',
    command => "env -i bash -c 'defaults write com.apple.Safari IncludeDevelopMenu -boolean true'"
  }

  #XCode
  exec { "XCode: turn on line numbers":
    provider => 'shell',
    command => "env -i bash -c 'defaults write com.apple.dt.Xcode DVTTextShowLineNumbers YES'"
  }

  exec { "XCode: set to the midnight theme":
    provider => 'shell',
    command => "env -i bash -c 'defaults write com.apple.dt.Xcode DVTFontAndColorCurrentTheme \'Midnight.dvtcolortheme\''"
  }


  file { $my:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'staxmanade/dotfiles-mac',
    require => File[$my]
  }
}
