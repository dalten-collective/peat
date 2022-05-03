::
::  control-plane for oger
::
/-  *oger, 
    resource,
    grope=group,
    store=graph-store,
    metas=metadata-store
/+  rudder, res-lib=resource
::
^-  (page:rudder state-1 horde)
::
=<
|_  $:  bol=bowl:gall
        odo=order:rudder
        sat=state-1
    ==
  +*  hc         ~(. +> bol)
      resources  resources:sat
      resource   resource:store
      permits    permits:sat
      known      known:sat
::
++  final
  (alert:rudder '/apps/oger' build)
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder horde)
  =+  notes=?~(body ~ (frisk:rudder q.u.body))
  ::
  ::  check-arguments
  ::
  ?.  (~(has by notes) 'post')         'Error: Unrecognized Function Call'
  ?+    pact=(~(got by notes) 'post')  'Error: Unrecognized Function Call'
      %export
    ?.  ?&  (~(has by notes) 'expo-ship')
            (~(has by notes) 'expo-name')
        ==
      'Error: Missing Data in Function Call'
    =/  res=resource
      :-  (slav %p (~(got by notes) 'expo-ship'))
      (slav %tas (~(got by notes) 'expo-name'))
    ?.  (~(has in resources) res)
      'Error: Missing Resource in State'
    `horde`[%export res]
  ::
      %import
    ?.  ?&  (~(has by notes) 'impo-folder')
            (~(has by notes) 'impo-name')
            (~(has by notes) 'group-select')
        ==
      'Error: Missing Stat in Function Call'
    =/  maybe-dime-tape=(unit [dime tape])
      %+  rush  (~(got by notes) 'group-select')
      ;~(pfix sig ;~((glue bar) crub:so (star next)))
    ?~  dt=maybe-dime-tape  'Error: Invalid Group Selection'
    ?.  ?=(%p -<.u.dt)      'Error: Something Went Wrong - Sorry!'
    =+  nam=(~(got by notes) 'impo-name')
    =+  fol=(~(got by notes) 'impo-folder')
    ^-  horde
    =-  :+  %import  - 
        [[`@p`->.u.dt (slav %tas (crip +.u.dt))] nam]
    ^-  path
    ;:  welp
      /(scot %p our.bol)
      /oger
      /(scot %da now.bol)
      /hav
      /(scot %tas fol)
    ==
  ==
      
++  build
  |=  $:  args=(list [k=@t v=@t])
          msgs=(unit [gud=? txt=@t])
      ==
  ^-  reply:rudder
  =*  notes  (malt args)
  =*  beeps  msgs
  |^
  ?.  (~(has by notes) 'act')  [%page (main beeps)]
  ::
  ::  mono-page affordances
  ::
  ?+    get=(~(got by notes) 'act')  [%code 404 'Error: Unrecognized Function Call']
      %export
    [%page (expo beeps)]    ::  expo
  ::
      %import
    [%page (impo beeps)]                                 ::  impo
  ::
      %search
    =-  [%page (sear beeps -)]                           ::  sear
    ^-  (unit @p)
    ?~(sil=(~(get by notes) 'ship') ~ (slaw %p u.sil))
  ::
      %remake
    [%page (sear beeps `our.bol)]                        ::  sear
  ::
      %permit
    [%page (main beeps)]                                 ::  perm
  ::
      %reject
    [%page (main beeps)]                                 ::  perm
  ::
      %digest
    [%page (main beeps)]                                 ::  abou
  ::
      %return
    [%page (main beeps)]                                 ::  main
  ::
  ==
  ++  main
    |=  beeps=(unit [gud=? txt=@t])
    ^-  manx
    ;html
      ;head
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(class "page")
          ;div(class "header")
            ;div(class "title")
              ;h1:"Oger Graph Backup and Restoration Utility"
            ==
            ;div(class "status-message")
              ;+  ?~  beeps  :/"" 
                  (status:re u.beeps)
            ==
          ==
        ::
          ;div(class "main")
            ;div(class "panels")
              ;div(class "sub-panel")
                ;div(class "panel-buttons")
                  ;div(class "panel-form")
                    ;form(class "panel-form-buttons", method "GET")
                      ;button
                        =class  "button-tile"
                        =type   "submit"
                        =name   "act"
                        =value  "export"
                        ; Export 📥
                      ==
                    ::
                      ;button
                        =class  "button-tile"
                        =type   "submit"
                        =name   "act"
                        =value  "import"
                        ; Import 📤
                      ==
                    ==
                  ==
                ::
                  ;div(class "panel-tip")
                    ;h2:"Disk Utilities"
                  ==
                ==
              ==
            ::
              ;div(class "sub-panel")
                ;div(class "panel-buttons")
                  ;div(class "panel-form")
                    ;form(class "panel-form-buttons", method "GET")
                      ;button
                        =class  "button-tile"
                        =type   "submit"
                        =name   "act"
                        =value  "search"
                        ; Search 🔍
                      ==
                    ::
                      ;button
                        =class  "button-tile"
                        =type   "submit"
                        =name   "act"
                        =value  "remake"
                        ; Remake 📡
                      ==
                    ==
                  ==
                ::
                  ;div(class "panel-tip")
                    ;h2:"On-Line Utilities"
                  ==
                ==
              ==
            ::
              ;div(class "sub-panel")
                ;div(class "panel-buttons")
                  ;div(class "panel-form")
                    ;form(class "panel-form-buttons")
                      ;button
                        =class  "button-tile"
                        =type   "submit"
                        =name   "act"
                        =value  "permit"
                        ; Permit ☑️
                      ==
                    ::
                      ;button
                        =class  "button-tile"
                        =type   "submit"
                        =name   "act"
                        =value  "reject"
                        ; Reject 🚫
                      ==
                    ==
                  ==
                ::
                  ;div(class "panel-tip")
                    ;h2:"OgerTalk Permissions"
                  ==
                ==
              ==
            ==
            ;div(class "menu")
              ;+  about:re
              ;+  main:re
              ;+  search:re
            ==
          ==
        ==
      ::
        ;div(class "footer")
          ;+  quartus-footer:re
        ==
      ==
    ==
::
::  expo page
::
  ++  expo
    |=  beeps=(unit [gud=? txt=@t])
    ^-  manx
    ;html
      ;head
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(class "page")
          ;div(class "header")
            ;div(class "title")
              ;h1:"Oger Graph Backup and Restoration Utility"
            ==
          ::
            ;div(class "status-message")
              ;+  ?~  beeps  :/"" 
                  (status:re u.beeps)
            ==
          ==
        ::
          ;div(class "main")
            ;div(class "chat-table")
              ;div(class "table-header-three")
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Host"
                ==
              ::
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Chat"
                ==
              ::
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Export"
                ==
              ::
              ==
            ::
              ;div(class "table-body")
                ;*  ;;  marl
                    =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty-table"):"No Chats"
                        ==
                    (murn ~(tap in resources) (murn-expo-list:re %chat))
              ==
            ==
          ::
            ;div(class "link-table")
              ;div(class "table-header-three")
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Host"
                ==
              ::
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Link Library"
                ==
              ::
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Export"
                ==
              ::
              ==
            ::
              ;div(class "table-body")
                ;*  ;;  marl
                    =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty-table"):"No Link Libraries"
                        ==
                    (murn ~(tap in resources) (murn-expo-list:re %link))
              ==
            ==
          ::
            ;div(class "publish-table")
              ;div(class "table-header-three")
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Host"
                ==
              ::
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Notebook"
                ==
              ::
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Export"
                ==
              ::
              ==
            ::
              ;div(class "table-body")
                ;*  ;;  marl
                    =-
                      ?.  ?=(~ -)  -
                      ;=  ;p(class "empty-table"):"No Notebooks"
                      ==
                    %+  murn  ~(tap in resources)
                    (murn-expo-list:re %publish)
              ==
            ==
          ==
        ::
          ;div(class "menu")
            ;+  about:re
            ;+  main:re
            ;+  search:re
          ==
        ::
          ;div(class "footer")
            ;+  quartus-footer:re
          ==
        ==
      ==
    ==
::
::  impo page
::
  ++  impo
    |=  beeps=(unit [gud=? txt=@t])
    ^-  manx
    ;html
      ;head
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(class "page")
          ;div(class "header")
            ;div(class "title")
              ;h1:"Oger Graph Backup and Restoration Utility"
            ==
          ::
            ;div(class "status-message")
              ;+  ?~  beeps  :/"" 
                  (status:re u.beeps)
            ==
          ==
        ::
          ;div(class "main")
            ;div(class "explain-contain")
              ;+  impo-explainer:re
            ==
          ::
            ;div(class "impo-wrapper")
              ;div(class "impo-form-wrap")
                ;form(class "impo-form", method "POST")
                  ;div(class "impo-prefix-wrap")
                    ;p(class "prefix"):"{(trip (spat /(scot %p our.bol)/oger/(scot %da now.bol)/hav))}/"
                  ::
                    ;input
                      =class        "text-folder"
                      =name         "impo-folder"
                      =type         "text"
                      =required     ""
                      =placeholder  "my-chat-123";
                  ==
                ::
                  ;div(class "impo-group-wrap")
                    ;+  group-select:re
                  ==
                ::
                  ;div(class "impo-name-wrap")
                    ;input
                      =class        "text-name"
                      =name         "impo-name"
                      =type         "text"
                      =required     ""
                      =placeholder  "my-new-chat";
                  ==
                ::
                  ;div(class "impo-button-wrap")
                    ;button
                      =class  "button-tile"
                      =name   "post"
                      =value  "import"
                      ; Import 📤
                    ==
                  ==
                ==
              ==
            ==
          ==
        ::
          ;div(class "menu")
            ;+  about:re
            ;+  main:re
            ;+  search:re
          ==
        ::
          ;div(class "footer")
            ;+  quartus-footer:re
          ==
        ==
      ==
    ==
::
::  sear page
::
  ++  sear
    |=  [beeps=(unit [gud=? txt=@t]) peeps=(unit @p)]
    |^
    ^-  manx
    ;html
      ;head
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(class "page")
          ;div(class "header")
            ;div(class "title")
              ;h1:"Oger Graph Backup and Restoration Utility"
            ==
          ::
            ;div(class "status-message")
              ;+  ?~  beeps  :/"" 
                  (status:re u.beeps)
            ==
          ==
        ::
          ;div(class "main")
            ;div(class "sear-left")
              ;+  ;;  manx
                  ?~  peeps
                    ?~  sil=~(tap in ~(key by known))
                    no-maidens  (some-maiden ~zod)
                  =-  ?.  -  (some-maiden u.peeps)
                      (that-maiden u.peeps)
                  ?|  =(our.bol u.peeps)
                      (~(has in ~(key by known)) u.peeps)
                  ==
            ==
          ::
            ;div(class "sear-right")
              ;*  ;;  marl
                  ?~  sil=~(tap in ~(key by known))
                  no-friends  (murn sil friend-list)
            ==
          ==
        ::
          ;div(class "menu")
            ;+  about:re
            ;+  main:re
            ;+  search:re
          ==
        ::
          ;div(class "footer")
            ;+  quartus-footer:re
          ==
        ==
      ==
    ==
  ::
  ++  no-maidens
    ^-  manx
    ;div(class "sear-search-wrap")
      ;div(class "explain-contain")
        ;+  sear-explainer-a:re
      ==
    ::
      ;div(class "sear-search-form-wrap")
        ;+  search-form
      ==
    ==
  ++  some-maiden
    |=  sip=@p
    ^-  manx
    ;div(class "sear-search-wrap")
      ;div(class "explain-contain")
        ;+  sear-explainer-b:re
      ==
    ::
      ;div(class "sear-search-form-wrap")
        ;+  search-form
      ==
    ==
  ++  that-maiden
    |=  sip=@p
    ^-  manx
    ;div(class "rest-search-wrap")
      ;div(class "explain-contain")
        ;+  rest-explainer:re
      ==
    ::
      ;div(class "rest-search-form-wrap")
        ;p:"form"
      ==
    ==
  ++  search-form
    ^-  manx
    ;div(class "sear-search-form-wrap")
      ;form(class "sear-search-form", method "GET")
        ;input
          =class        "text-planet"
          =name         "ship"
          =type         "text"
          =required     ""
          =placeholder  "🔍 ~sampel-palnet";
      ::
        ;button
          =class  "sear-search-button"
          =type   "submit"
          =name   "act"
          =value  "search"
          ; Search 🔍
        ==
      ==
    ==
  ::
  ++  no-friends
    ;=  ;p(class "no-friends"):"No Friends!"
    ==
  ++  friend-list
    |=  sip=ship
    ^-  (unit manx)
    :-  ~
    ;div(class "friend-list-tile")
      ;form(class "friend-list", method "GET")
        ;input
          =name  "ship"
          =type  "text"
          =style  "display: none"
          =value  "{(scow %p sip)}";
      ::
        ;button
          =class  "friend-name"
          =type   "submit"
          =name   "act"
          =value  "search"
          {(scow %p sip)}
        ==
      ==
    ==
  --
::
::  perm page
::
  ++  perm
    |=  beeps=(unit [gud=? txt=@t])
    ^-  manx
    ;html
      ;head
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(class "page")
          ;div(class "header")
            ;div(class "title")
              ;h1:"Oger Graph Backup and Restoration Utility"
            ==
          ::
            ;div(class "status-message")
              ;+  ?~  beeps  :/"" 
                  (status:re u.beeps)
            ==
          ==
        ::
          ;div(class "main")
            ;p:"expo"
          ==
        ::
          ;div(class "menu")
            ;+  about:re
            ;+  main:re
            ;+  search:re
          ==
        ::
          ;div(class "footer")
            ;+  quartus-footer:re
          ==
        ==
      ==
    ==
::
::  abou page
::
  ++  abou
    |=  beeps=(unit [gud=? txt=@t])
    ^-  manx
    ;html
      ;head
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(class "page")
          ;div(class "header")
            ;div(class "title")
              ;h1:"Oger Graph Backup and Restoration Utility"
            ==
          ::
            ;div(class "status-message")
              ;+  ?~  beeps  :/"" 
                  (status:re u.beeps)
            ==
          ==
        ::
          ;div(class "main")
            ;p:"expo"
          ==
        ::
          ;div(class "menu")
            ;+  about:re
            ;+  main:re
            ;+  search:re
          ==
        ::
          ;div(class "footer")
            ;+  quartus-footer:re
          ==
        ==
      ==
    ==
::
::  re-used elements
::
  ++  re
    |%
    ++  status
      |=  msg=[gud=? txt=@t]
      ^-  manx
      ?:  gud.msg
        ;div#status.green:"{(trip txt.msg)}"
      ;div#status.red:"{(trip txt.msg)}"
    ++  group-select
      |^
      ^-  manx
      ;div(class "group-select")
        ;select
          =name      "group-select"
          =required  ""
          ;option(value "", hidden ""):"Select A Group"
          ;*  ;;  marl
              =-  ?.  ?=(~ -)  -
                  ;=  ;option(value "", hidden ""):"No Appropriate Groups"
                  ==
              (murn ~(groups scry:hc [%$ ~]) make-option)
        ==
      ==
      ::
      ++  make-option
        |=  res=resource
        ^-  (unit manx)
        =;  [rat=tape fancy-rat=tape]
          :-  ~
          ;option(value rat):"{fancy-rat}"
        :-  "{(scow %p -.res)}|{(scow %tas +.res)}"
        "[{(scow %p -.res)} %{(scow %tas +.res)}]"
          
      --
    ::
    ++  impo-explainer
      ;div(class "explainer")
        ;p(class "explainer-head"):"Import From Disk"
        ;p(class "explainer-body"):"The Import From Disk Utility assumes you have:"
        ;p(class "explainer-body"):" - A mounted desk called 'oger'"
        ;p(class "explainer-body"):" - A directory in the 'oger' desk's '/hav' directory with a name you know"
        ;p(class "explainer-body"):" - A series of .jam files in the known, aforementioned directory created using the export function"
        ;p(class "explainer-body"):" - A pre-existing group for which you are an admin"
        ;p(class "explainer-body"):" - A name of a group"
        ;p(class "explainer-body"):"To import a resource:"
        ;p(class "explainer-body"):" - Enter the name of that aforementioned, known directory"
        ;p(class "explainer-note"):"   (this folder should contain jam files appurtenant to the archive you're trying to import)"
        ;p(class "explainer-note"):"   (to create an archive, navigate to the Export Disk Utility, from the main menu)"
        ;p(class "explainer-body"):" - Select a group from the list of those you manage"
        ;p(class "explainer-body"):" - Enter a name for Oger to use while creating a new, local resource to house the imported graph"
        ;p(class "explainer-note"):"   (Use letters, numbers, and hyphens only. No spaces!)"
      ==
    ::
    ++  sear-explainer-a
      ;div(class "explainer")
        ;p(class "explainer-head"):"Search for Graphs"
        ;p(class "explainer-body"):"You do not currently have any friends. You can make some by asking them to permit you, then searching for them here."
        ;p(class "explainer-body"):"Having friends in Oger will:"
        ;p(class "explainer-body"):" - Let you search for them and track graphs that they're aware of"
        ;p(class "explainer-body"):" - Remotely request and locally duplicate graphs that your friends possess"
        ;p(class "explainer-body"):"You wont be able to search for anyone's graphs until they've authorized you, and we can't tell from here if that's happen. Go talk to someone in EScape for a while until they offer you access to their secrets!"
        ;p(class "explainer-body"):"If you know that you should have access to someone's graphs, enter their @p below and click Search."
      ==
    ++  sear-explainer-b
      ;div(class "explainer")
        ;p(class "explainer-head"):"Search for Graphs"
      ::
        ;+  ;;  manx
            %+  snag  (~(rad og eny.bol) 9)
            ^-  (list manx)
            :~  ;p(class "explainer-body"):"We didn't quite catch that - want to search again?"
                ;p(class "explainer-body"):"You must be new here - Welcome!"
                ;p(class "explainer-body"):"Aren't you glad I didn't explode your ship by trying to encode Zalgo text here?"
                ;p(class "explainer-body"):"Remember to garner enthusiastic consent before Searching your friends."
                ;p(class "explainer-body"):"Oger is brought to you by Quartus Corporation"
                ;p(class "explainer-body"):"l̸̨̢̨̛͍̤̺̝͉̱̳̭̣͍͕̬̖̈́͛̃̆͒̒̉̅̒̏̂̈̚̚ǒ̵̞̣̝̭̳̭̯̘̗̰͓̟̭̫̗͊̂̀̋͒͌̎̉̈́̽̈́͂̑̀̎͜l̸̛̜̜̘̰̥̼̥͔̪̮̫̝̝̫̦̺̓͐̔͊̓̀̾̉̈́̎̎͂̕͝͠ ̶̡̙̪͉̲̲͕͔̦̺̳͖͔̣̳͕̋͂̓͐̀̀́͛͊̌͗͘͝͝͝I̶̡̬͎͇̦̻̘̲͎͎̱̪͒̉̓̍͌͋̿̽͋̀̍̚͜͝͠ͅ ̶̡̠͍̲̝̜̠͔͙͇̩̗͉̝̀͒̆̉͗̑̅̌͛̽̈́̆̅̚͘͜ḏ̸̡̨̭͙̙̗͉̦͖̘̠͎́̏̓͊́̀̊̓̈́̀͒̎̈́́̂͜i̶̗̰͔̝̩̺̲̪̬͚͖͎̼̅̃̀̄̈́͋͗͋̂̐͗̈́̕͠ͅḑ̵̧̛̛͔̞̺̣̗͈͚̻͔̙̪̙̲͍̌͑̀̀̍̓̂̆̋̈́̍͘͠ ̸̨̧͔̩̟̹̝̺̠̩̮̝͎͖͚̔͐͒͊̽͗̈́̃̒͋͌͘̚͘͘ͅt̶̛̛͍̩̭̟̯̰̪͍̳̼͔͙͕̫̔̏̌̔͋̊̔͂͂̀̆͘͜͝ͅř̵̡̡̛̦̰͖̪̣̮͔̖͕̼͖̭̊̏͊̈͛̈́̀͐̌͒̈̕͝ͅy̴̗͔̘̮͖̜͚͔̤̖̩̰̻̺͋̈̄̃̎̈̀͐͐̈́͛̎̓̉͛͘ ̴̨̢̺̪̝̲̗͉̖̖̙͖̘̤̘͖̔̈́̆͊̇̌̓̌͐̌̊̌͒̇̈́̕ę̶͙̦͇͎̬͔̗̫̯̞̯̦̳̗̼̐́̋͛͗̐̄̐͆̌̓̑̕͝͠n̶̛̛̥̣̞̲̦̳̠̠̖̻̘͍̜̬̣̽̉̽̈̾̑̀͋̈́͋͑͌̊͜͝ç̷̲͙̺͎̟̠̬͎̬̜͓̩̝̯̝̄̀͊̇̊̌͋̏́̿̽̄͛̑̅̽ò̶̹̤̝͈̼̮̖̬̱͍͚̻͚͉̾̈͑̀̉͆̈́̆̇́̂́̇́͜d̷̨͙̙̪̦̠͇͍̥̖̦̦͖̹̎͒͋̇̐̍̓̓̐̋̄̈́͘͘͘͝i̶̡̡̡̛͍̟͓͙̯͎̮̲̟̰̮̤̩̎̃̌̊͆̎́̔̎͘͘̚͠͝n̴͈̙͔̹̝̺̘̠͚̖͕͎͍̑̀̾͋̂̋͌̑̃̾̊̃̐̓͘͜͝ͅg̸̙̘͖̙͖̭̥̪̦̗͇͙̲̯̐̈́̔̾͌̒̾͋͐̿́̀́͝ͅ ̴̢̨̫͕̲̺͉̻̭̣͓̹̯̗͇̗̀͐̍͒̎̈́́͛̑̉͛̚̕̕z̶̨̙͇̼͚͇͓͕̯͖͙̳͈̤̙̀̽͒̍̈́̌͆̇̋̊̊̐̓͠͝͝a̸̧̨̛̘͚̻̣̱̱̠͔̟̬̜̱̯͒̀͂͋̄̽̈́́̍̈͐͒̇̽ͅl̷̡̛̺̰̙̞̜̱̰̲̲͍̮̱̼̞̾̔̓͂͑̍͂͋̃̔͘̕͝͝͝ͅĝ̷̛̙̮̠̝̪̼̺̲̜̥̫̬̩̮̜͕͋̄͋̈̔͐̈͐͌͘̚͝͝ö̸̢̢̨̰͓̳̳͚̲̦̺̣̲́́́͒́̊̉̄̌̂͂̓̎͜͜͝"
                ;p(class "explainer-body"):"Backing up graphs is now easy, and fun!"
                ;p(class "explainer-body"):"If you're enjoying using Oger, you should try Keep - our agent that backs up other agents!"
                ;p(class "explainer-body"):"Try clicking on your friends name, on your right."
                ;p(class "explainer-body"):"We couldn't find that friend, but we did have some suggestions, on the right."
            ==
      ==
    ++  rest-explainer
      ;div(class "explainer")
        ;p(class "explainer-head"):"Recreate Graphs"
        ;p(class "explainer-body"):"To recreate a resource"
        ;p(class "explainer-body"):" - Select a group from the list of those you manage"
        ;p(class "explainer-body"):" - Enter a name for Oger to use while creating a new, local resource to house the recreated graph"
        ;p(class "explainer-note"):"   (Use letters, numbers, and hyphens only. No spaces!)"
        ;p(class "explainer-body"):" - Select a resource from one of the lists below to recreate"
      ==
    ::
    ++  about
      ^-  manx
      ;div(id "about")
        ;div(class "menu-guts")
          ;div(class "menu-form")
            ;form(class "menu-form-button", method "GET")
              ;button
                =class  "menu-button-tile"
                =type   "submit"
                =name   "act"
                =value  "digest"
                ; About 🏷️
              ==
            ==
          ==
        ==
      ==
    ::
    ++  main
      ^-  manx
      ;div(class "menu-wrap", id "about")
        ;div(class "menu-guts")
          ;div(class "menu-form")
            ;form(class "menu-form-button", method "GET")
              ;button
                =class  "menu-button-tile"
                =type   "submit"
                =name   "act"
                =value  "return"
                ; Functions 🛠️
              ==
            ==
          ==
        ==
      ==
    ::
    ++  search
      ^-  manx
      ;div(class "menu-wrap", id "ship-search")
        ;div(class "menu-guts")
          ;div(class "menu-search")
            ;form(class "search-form", method "GET")
              ;input
                =class        "text-planet"
                =name         "ship"
                =type         "text"
                =required     ""
                =placeholder  "🔍 ~sampel-palnet";
            ::
              ;button
                =class  "search-button"
                =type   "submit"
                =name   "act"
                =value  "search"
                ; Search 🔍
              ==
            ==
          ==
        ==
      ==
    ++  quartus-footer
      ^-  manx
      ;div(class "footer-wrap", id "quartus-footer")
        ;div(class "footer-guts")
          ;div(class "footer-text")
            ;h1:"A Quartus Corporation Product"
          ==
          ;div(class "footer-logo")
            ;img
              =class  "logo-img"
              =name   "Quartopus"
              =alt    "a vector image of an octopus, originally drawn by ~tocrex-holpen"
              =src    "{logo}";
          ==
        ==
      ==
    ++  murn-expo-list
      |=  typ=?(%chat %link %publish)
      |=  res=resource
      ^-  (unit manx)
      ?~  ass=~(assoc scry:hc (en-path:res-lib res))  ~  :: could we find an association in metadata
      ?.  ?=(%graph -.config.metadatum.u.ass)  ~         :: this product only works on graph modules as of the present
      =*  fon  module.config.metadatum.u.ass
      ?.  =(typ fon)  ~
      :-  ~
      ;div(class "list-line")
        ;div(class "list-line-host")
          ;p(class "ship-name"):"{(scow %p entity.res)}"
        ==
      ::
        ;div(class "list-line-name")
          ;p(class "resource-name"):"{(scow %tas name.res)}"
        ==
      ::
        ;div(class "list-line-expo")
          ;div(class "list-line-form-button")
            ;form(class "line-form-button", method "POST")
              ;input
                =style  "display: none"
                =type   "text"
                =name   "expo-ship"
                =value  (scow %p entity.res);
            ::
              ;input
                =style  "display: none"
                =type   "text"
                =name   "expo-name"
                =value  (scow %tas name.res);
            ::
              ;button
                =class  "table-button"
                =type   "submit"
                =name   "post"
                =value  "export"
                ; Export 📥
              ==
            ==
          ==
        ==
      ==

    --
::
  ++  style
    '''
    /* - main styles - */
    * { font-family: "Andale Mono", monospace }
    .red { font-weight: bold; color: #dd2222; }
    .green { font-weight: bold; color: #229922; }
    '''
  ++  logo
    "https://freedom-club.sfo2.digitaloceanspaces.com/rabsef-bicrym/2022.5.02..07.06.28-IMG_20220314_2104171752%20%281%29.svg"
  --
--
::
::  helper core - should be reduced to needed items only
::
|_  bol=bowl:gall
+*  resource  resource:store
++  scry
  |_  pat=path
  ++  curve
    ~+
    ^-  arch
    .^(arch %cy pat)
  ++  exist
    ^-  ?
    =+  curve
    !?=(~ dir.-)
  ++  notes
    ^-  (list p=path q=*)
    =+  curve
    ~(tap in dir.-)
  ++  group
    ^-  (set resource)
    .^  (set resource)  %gy
      /(scot %p our.bol)/group-store/(scot %da now.bol)/groups
    ==
  ++  groups
    ^-  (list resource)
    ?~  gros=~(tap in group)  *(list resource)
    %+  murn  gros
    |=  r=resource
    ^-  (unit resource)
    =;  gru=(unit group:grope)
      ?~  gru  ~
      ?.((~(has in (~(get ju tags.u.gru) %admin)) our.bol) ~ `r)
    .^  (unit group:grope)  %gx
      ;:  welp
        /(scot %p our.bol)/group-store/(scot %da now.bol)/groups
        (en-path:res-lib r)
        /noun
      ==
    ==
  ::
  ++  graph
    ^-  update:store
    =-  .^(update:store %gx -)
    ;:  weld
      /(scot %p our.bol)/graph-store/(scot %da now.bol)
      /graph
      pat
      /noun
    ==
  ::
  ++  assoc
    ^-  (unit association:metas)
    =-  .^((unit association:metas) %gx -)
    ;:  weld
      /(scot %p our.bol)/metadata-store/(scot %da now.bol)
      /metadata/graph
      pat
      /noun
    ==
  ::
  ++  shape
    ^-  (unit ?(%chat %link %publish))
    =+  curve
    ?~  dis=dir.-  ~
    ?~  nos=(rush p:(head dis) ;~((glue bar) sym sym sym dem))  ~
    =+  typ=+>-.u.nos
    ?+  typ  ~
      %chat     `;;(?(%chat %link %publish) typ)
      %link     `;;(?(%chat %link %publish) typ)
      %publish  `;;(?(%chat %link %publish) typ)
    ==
  --
--