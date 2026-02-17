config = {}
config.screen = {}
config.screen.top_left = 1
config.screen.bottom_left = 2
config.screen.bottom_right = 3
config.applications = {
  ['Brave'] = {
    bundleID = 'com.brave.Browser',
    preferred_display = config.screen.top_left
  },
  ['Firefox'] = {
    bundleID = 'org.mozilla.firefox',
    preferred_display = config.screen.top_left
  },
  ['Google Calendar'] = {
    bundleID = 'com.google.Chrome.app.kjbdgfilnfhdoflbpgamdcdgpehopbep',
    preferred_display = config.screen.top_left
  },
  ['Podman Desktop'] = {
    bundleID = 'io.podmandesktop.PodmanDesktop',
    preferred_display = config.screen.top_left
  },
  ['Slack'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    preferred_display = config.screen.top_left
  },

  ['Google Chrome'] = {
    bundleID = 'com.google.Chrome'
  },
  ['Terminal'] = {
    bundleID = 'com.apple.Terminal'
  },
  ['Visual Studio Code'] = {
    bundleID = 'com.microsoft.VSCode',
    preferred_display = config.screen.bottom_right
  },

  ['Crunchyroll'] = {
    bundleID = 'com.google.Chrome.app.hjlhbeffadgkonmpnblkfmhckmocohah',
    preferred_display = config.screen.bottom_right
  },
  ['Netflix'] = {
    bundleID = 'com.google.Chrome.app.eppojlglocelodeimnohnlnionkobfln',
    preferred_display = config.screen.bottom_right
  },
  ['Xbox'] = {
    bundleID = 'com.google.Chrome.app.chcecgcbjkilfgeccdhoeaillkophnhg',
    preferred_display = config.screen.bottom_right
  },

  ['Discord'] = {
    bundleID = 'com.hnc.Discord',
    preferred_display = config.screen.bottom_left
  },
  ['Hammerspoon'] = {
    bundleID = 'org.hammerspoon.Hammerspoon',
    preferred_display = config.screen.bottom_left
  },
  ['Instagram'] = {
    bundleID = 'com.google.Chrome.app.akpamiohjfcnimfljfndmaldlcfphjmp',
    preferred_display = config.screen.bottom_left
  },
  ['Line'] = {
    bundleID = 'jp.naver.line.mac',
    preferred_display = config.screen.bottom_left
  },
  ['Messages'] = {
    bundleID = 'com.apple.MobileSMS',
    preferred_display = config.screen.bottom_left
  },
  ['Signal'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    preferred_display = config.screen.bottom_left
  },
  ['WhatsApp'] = {
    bundleID = 'com.google.Chrome.app.hnpfjngllnobngcgfapefoaidbinmjnm',
    preferred_display = config.screen.bottom_left
  },

  ['Keychron'] = {
    bundleID = 'com.google.Chrome.app.cbfedpnlilnlbdcikokpfoibmlbghlhg',
    preferred_display = config.screen.bottom_left
  },
  ['NuphyIO'] = {
    bundleID = 'com.google.Chrome.app.opaefnjafkemdihlmdiocmmmmdkhgjfg',
    preferred_display = config.screen.bottom_left
  }
}

return config
