config = {}
config.screen = {}

config.screen.top = {'U32'}
config.screen.middle = {'Smart'}
config.screen.builtin =  {'Built', 'LG'}
config.screen.left =  {'LG'}

config.applications = {
  ['Podman Desktop'] = {
    bundleID = 'io.podmandesktop.PodmanDesktop',
    preferred_display = config.screen.top
  },
  ['UTM'] = {
    bundleID = 'com.utmapp.UTM',
    preferred_display = config.screen.top
  },

  ['Slack'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    preferred_display = config.screen.left
  },
  ['Google Calendar'] = {
    bundleID = 'com.google.Chrome.app.kjbdgfilnfhdoflbpgamdcdgpehopbep',
    preferred_display = config.screen.left
  },

  -- ['Brave'] = {
  --   bundleID = 'com.brave.Browser',
  -- },
  -- ['Google Chrome'] = {
  --   bundleID = 'com.google.Chrome',
  -- },
  -- ['Terminal'] = {
  --   bundleID = 'com.apple.Terminal',
  -- },
  -- ['Hammerspoon'] = {
  --   bundleID = 'org.hammerspoon.Hammerspoon',
  -- },
  -- ['Cursor'] = {
  --   bundleID = 'com.todesktop.230313mzl4w4u92',
  -- },
  -- ['Visual Studio Code'] = {
  --   bundleID = 'com.microsoft.VSCode',
  -- },

  ['Crunchyroll'] = {
    bundleID = 'com.google.Chrome.app.hjlhbeffadgkonmpnblkfmhckmocohah',
    preferred_display = config.screen.middle
  },
  ['Netflix'] = {
    bundleID = 'com.google.Chrome.app.eppojlglocelodeimnohnlnionkobfln',
    preferred_display = config.screen.middle
  },
  ['Xbox'] = {
    bundleID = 'com.google.Chrome.app.chcecgcbjkilfgeccdhoeaillkophnhg',
    preferred_display = config.screen.middle
  },

  -- ['Discord'] = {
  --   bundleID = 'com.hnc.Discord',
  -- },

  ['Firefox'] = {
    bundleID = 'org.mozilla.firefox',
    preferred_display = config.screen.top
  },
  -- ['Google Meet'] = {
  --   bundleID = 'com.google.Chrome.app.kjgfgldnnfoeklkmfkjfagphfepbbdan',
  -- },
  -- ['Instagram'] = {
  --   bundleID = 'com.google.Chrome.app.akpamiohjfcnimfljfndmaldlcfphjmp',
  -- },
  ['Line'] = {
    bundleID = 'jp.naver.line.mac',
    preferred_display = config.screen.top
  },
  ['Messages'] = {
    bundleID = 'com.apple.MobileSMS',
    preferred_display = config.screen.top
  },
  ['Signal'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    preferred_display = config.screen.top
  },
  ['WhatsApp'] = {
    bundleID = 'com.google.Chrome.app.hnpfjngllnobngcgfapefoaidbinmjnm',
    preferred_display = config.screen.top
  },

  -- ['Keychron'] = {
  --   bundleID = 'com.google.Chrome.app.cbfedpnlilnlbdcikokpfoibmlbghlhg',
  -- },
  -- ['NuphyIO'] = {
  --   bundleID = 'com.google.Chrome.app.opaefnjafkemdihlmdiocmmmmdkhgjfg',
  -- }
}

return config
