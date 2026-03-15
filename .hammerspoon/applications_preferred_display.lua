config = {}
config.screen = {}

config.screen.right = {'Smart'}
config.screen.middle = {'LG'}
config.screen.left =  {'Built', 'U32'}

config.applications = {
  ['Brave'] = {
    bundleID = 'com.brave.Browser',
    preferred_display = config.screen.left
  },
  ['Podman Desktop'] = {
    bundleID = 'io.podmandesktop.PodmanDesktop',
    preferred_display = config.screen.left
  },
  ['UTM'] = {
    bundleID = 'com.utmapp.UTM',
    preferred_display = config.screen.left
  },

  ['Slack'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    preferred_display = config.screen.right
  },
  ['Google Calendar'] = {
    bundleID = 'com.google.Chrome.app.kjbdgfilnfhdoflbpgamdcdgpehopbep',
    preferred_display = config.screen.right
  },

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

  -- ['Crunchyroll'] = {
  --   bundleID = 'com.google.Chrome.app.hjlhbeffadgkonmpnblkfmhckmocohah',
  -- },
  -- ['Discord'] = {
  --   bundleID = 'com.hnc.Discord',
  -- },
  -- ['Netflix'] = {
  --   bundleID = 'com.google.Chrome.app.eppojlglocelodeimnohnlnionkobfln',
  -- },
  -- ['Xbox'] = {
  --   bundleID = 'com.google.Chrome.app.chcecgcbjkilfgeccdhoeaillkophnhg',
  -- },

  ['Firefox'] = {
    bundleID = 'org.mozilla.firefox',
    preferred_display = config.screen.left
  },
  ['Google Meet'] = {
    bundleID = 'com.google.Chrome.app.kjgfgldnnfoeklkmfkjfagphfepbbdan',
    preferred_display = config.screen.right
  },
  ['Instagram'] = {
    bundleID = 'com.google.Chrome.app.akpamiohjfcnimfljfndmaldlcfphjmp',
    preferred_display = config.screen.left
  },
  ['Line'] = {
    bundleID = 'jp.naver.line.mac',
    preferred_display = config.screen.left
  },
  ['Messages'] = {
    bundleID = 'com.apple.MobileSMS',
    preferred_display = config.screen.left
  },
  ['Signal'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    preferred_display = config.screen.left
  },
  ['WhatsApp'] = {
    bundleID = 'com.google.Chrome.app.hnpfjngllnobngcgfapefoaidbinmjnm',
    preferred_display = config.screen.left
  },

  -- ['Keychron'] = {
  --   bundleID = 'com.google.Chrome.app.cbfedpnlilnlbdcikokpfoibmlbghlhg',
  -- },
  -- ['NuphyIO'] = {
  --   bundleID = 'com.google.Chrome.app.opaefnjafkemdihlmdiocmmmmdkhgjfg',
  -- }
}

return config
