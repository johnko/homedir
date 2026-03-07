config = {}
config.screen = {}

config.screen.top = {'LG', 'Smart'}
config.screen.bottom_left =  {'6167F4D1-86CB-42BC-97D9-37FCE9CE14EE', 'Built', '(1)', 'U32'}
config.screen.bottom_right = {'FBFE6312-2360-4367-B44C-D7C3F83E0737',          '(2)', 'U32'}

config.applications = {
  ['Brave'] = {
    bundleID = 'com.brave.Browser',
    preferred_display = config.screen.top
  },
  ['Google Calendar'] = {
    bundleID = 'com.google.Chrome.app.kjbdgfilnfhdoflbpgamdcdgpehopbep',
    preferred_display = config.screen.top
  },
  ['Podman Desktop'] = {
    bundleID = 'io.podmandesktop.PodmanDesktop',
    preferred_display = config.screen.top
  },
  ['Slack'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    preferred_display = config.screen.top
  },
  ['UTM'] = {
    bundleID = 'com.utmapp.UTM',
    preferred_display = config.screen.top
  },

  ['Cursor'] = {
    bundleID = 'com.todesktop.230313mzl4w4u92',
  },
  ['Google Chrome'] = {
    bundleID = 'com.google.Chrome'
  },
  ['Hammerspoon'] = {
    bundleID = 'org.hammerspoon.Hammerspoon',
  },
  ['Terminal'] = {
    bundleID = 'com.apple.Terminal',
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
    preferred_display = config.screen.bottom_left
  },
  ['Google Meet'] = {
    bundleID = 'com.google.Chrome.app.kjgfgldnnfoeklkmfkjfagphfepbbdan',
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
