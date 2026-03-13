config = {}
config.screen = {}

config.screen.top_left = {'Smart'}
config.screen.top_right = {'LG'}
config.screen.bottom_left =  {'6167F4D1-86CB-42BC-97D9-37FCE9CE14EE', 'FC8F6340-8DC7-433F-A8F3-AC5059C36720', 'Built', 'U32'}
config.screen.bottom_right = {'FBFE6312-2360-4367-B44C-D7C3F83E0737', '0B235254-0EE7-42B5-B687-D733E26C1AA9',          'U32'}

config.applications = {
  ['Brave'] = {
    bundleID = 'com.brave.Browser',
    preferred_display = config.screen.top_left
  },
  ['Podman Desktop'] = {
    bundleID = 'io.podmandesktop.PodmanDesktop',
    preferred_display = config.screen.top_left
  },
  ['UTM'] = {
    bundleID = 'com.utmapp.UTM',
    preferred_display = config.screen.top_left
  },

  ['Slack'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    preferred_display = config.screen.bottom_left
  },
  ['Google Calendar'] = {
    bundleID = 'com.google.Chrome.app.kjbdgfilnfhdoflbpgamdcdgpehopbep',
    preferred_display = config.screen.bottom_left
  },
  ['Google Chrome'] = {
    bundleID = 'com.google.Chrome',
    preferred_display = config.screen.bottom_left
  },

  ['Terminal'] = {
    bundleID = 'com.apple.Terminal',
    preferred_display = config.screen.bottom_right
  },

  ['Hammerspoon'] = {
    bundleID = 'org.hammerspoon.Hammerspoon',
  },
  ['Cursor'] = {
    bundleID = 'com.todesktop.230313mzl4w4u92',
  },
  ['Visual Studio Code'] = {
    bundleID = 'com.microsoft.VSCode',
  },

  ['Crunchyroll'] = {
    bundleID = 'com.google.Chrome.app.hjlhbeffadgkonmpnblkfmhckmocohah',
  },
  ['Discord'] = {
    bundleID = 'com.hnc.Discord',
  },
  ['Netflix'] = {
    bundleID = 'com.google.Chrome.app.eppojlglocelodeimnohnlnionkobfln',
  },
  ['Xbox'] = {
    bundleID = 'com.google.Chrome.app.chcecgcbjkilfgeccdhoeaillkophnhg',
  },

  ['Firefox'] = {
    bundleID = 'org.mozilla.firefox',
    preferred_display = config.screen.top_right
  },
  ['Google Meet'] = {
    bundleID = 'com.google.Chrome.app.kjgfgldnnfoeklkmfkjfagphfepbbdan',
    preferred_display = config.screen.bottom_left
  },
  ['Instagram'] = {
    bundleID = 'com.google.Chrome.app.akpamiohjfcnimfljfndmaldlcfphjmp',
    preferred_display = config.screen.top_right
  },
  ['Line'] = {
    bundleID = 'jp.naver.line.mac',
    preferred_display = config.screen.top_right
  },
  ['Messages'] = {
    bundleID = 'com.apple.MobileSMS',
    preferred_display = config.screen.top_right
  },
  ['Signal'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    preferred_display = config.screen.top_right
  },
  ['WhatsApp'] = {
    bundleID = 'com.google.Chrome.app.hnpfjngllnobngcgfapefoaidbinmjnm',
    preferred_display = config.screen.top_right
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
