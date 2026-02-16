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
    preferred_display = config.screen.top_left,
    tags = {'#collab'}
  },
  ['Podman Desktop'] = {
    bundleID = 'io.podmandesktop.PodmanDesktop',
    preferred_display = config.screen.top_left,
    tags = {'#coding'}
  },
  ['Slack'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    preferred_display = config.screen.top_left,
    tags = {'#comms'}
  },

  ['Google Chrome'] = {
    bundleID = 'com.google.Chrome',
    preferred_display = config.screen.bottom_right
  },
  ['Terminal'] = {
    bundleID = 'com.apple.Terminal',
    preferred_display = config.screen.bottom_right,
    tags = {'#coding'}
  },
  ['Visual Studio Code'] = {
    bundleID = 'com.microsoft.VSCode',
    preferred_display = config.screen.bottom_right,
    tags = {'#coding'}
  },

  ['Crunchyroll'] = {
    bundleID = 'com.google.Chrome.app.hjlhbeffadgkonmpnblkfmhckmocohah',
    preferred_display = config.screen.bottom_right,
    tags = {'#entertain'}
  },
  ['Netflix'] = {
    bundleID = 'com.google.Chrome.app.eppojlglocelodeimnohnlnionkobfln',
    preferred_display = config.screen.bottom_right,
    tags = {'#entertain'}
  },
  ['Xbox'] = {
    bundleID = 'com.google.Chrome.app.chcecgcbjkilfgeccdhoeaillkophnhg',
    preferred_display = config.screen.bottom_right,
    tags = {'#entertain'}
  },

  ['Discord'] = {
    bundleID = 'com.hnc.Discord',
    preferred_display = config.screen.bottom_left,
    tags = {'#entertain'}
  },
  ['Instagram'] = {
    bundleID = 'com.google.Chrome.app.akpamiohjfcnimfljfndmaldlcfphjmp',
    preferred_display = config.screen.bottom_left,
    tags = {'#comms'}
  },
  ['Line'] = {
    bundleID = 'jp.naver.line.mac',
    preferred_display = config.screen.bottom_left,
    tags = {'#comms'}
  },
  ['Messages'] = {
    bundleID = 'com.apple.MobileSMS',
    preferred_display = config.screen.bottom_left,
    tags = {'#comms'}
  },
  ['Signal'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    preferred_display = config.screen.bottom_left,
    tags = {'#comms'}
  },
  ['WhatsApp'] = {
    bundleID = 'com.google.Chrome.app.hnpfjngllnobngcgfapefoaidbinmjnm',
    preferred_display = config.screen.bottom_left,
    tags = {'#comms'}
  },

  ['Keychron'] = {
    bundleID = 'com.google.Chrome.app.cbfedpnlilnlbdcikokpfoibmlbghlhg',
    preferred_display = config.screen.bottom_left,
    tags = {'#config'}
  },
  ['NuphyIO'] = {
    bundleID = 'com.google.Chrome.app.opaefnjafkemdihlmdiocmmmmdkhgjfg',
    preferred_display = config.screen.bottom_left,
    tags = {'#config'}
  }
}

return config
