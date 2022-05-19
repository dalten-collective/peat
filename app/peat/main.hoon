::
::  /app/peat/main - a UI - by Quartus Corporation
::
::
::    developer notes:
::
::  - Navigation
::  This file is rather long, no?
::  It's actually serving 6 "separate" pages that reuse
::  some elements. All this routing happens off of query
::  string parameters @ the end of the URL, and that,
::  in turn, is handled in +build.
::
::  In short:
::    - A ?act=<action> query parameter will yield
::        CASE         PAGE
::      %export        +expo
::      %import        +impo
::      %search        +sear
::      %remake        +sear
::      %permit        +perm
::      %remove        +perm
::      %digest        +abou
::      %return        +main
::
::  - Helper Core
::  It also contains a helper core (hc) which has the
::  following scry functions, all of which are inside
::  a +scry door that takes a path (many unused):
::   Function     Expected Path     Result
::  - curve         clay path       arch
::  - exist         clay path       is path directory w/ files?
::  - notes         clay path       (list [p=path q=*]) of files in directory
::  - group       (empty path)      (set resource) of groups on ship
::  - groups      (empty path)      (list resource) where we are amdin  
::  - graph       (en-path res)     `update:store` of a graph
::  - assoc       (en-path res)     Metadata about a graph
::  - shape         clay path       Validator "shape" from .jam file
::
::  - Good to Know
::  Lastly, it employs a core, +re, for re-used sail elements
::  but that's not very complicated. +re mostly returns 
::  manx or marls but sometimes has gates that are intended
::  to be 'murn'ed (std-lib function maybe-turn) to 
::  maybe-produce a list of manx (a marl).
::  One such function in particular requires being called
::  by an instruction first:
::    e.g. (murn ~(list) (murn-expo-list %chat))
::
/-  *peat, 
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
  |=  [success=? =brief:rudder]
  ^-  reply:rudder
  ::=+  bod=body.request.inbound-request.odo
  ::
  ?.  success  (build ~ `[| `@t`brief])
  =+  notes=?~(bod=body.request.odo ~ (frisk:rudder q.u.bod))
  ?.  (~(has by notes) 'post')  [%next '/apps/peat' brief]
  =;  buckslip=brief:rudder
    [%next '/apps/peat' buckslip]
  ?+  (~(got by notes) 'post')  brief
    %export  (cat 3 brief '&act=export')
    %import  (cat 3 brief '&act=import')
    %permit  (cat 3 brief '&act=permit')
    %remove  (cat 3 brief '&act=permit')
  ::  
      %search
    ?~  who=(~(get by notes) 'rest-sour')  
      (cat 3 brief '&act=search')
    (rap 3 ~[brief '&ship=' u.who '&act=search'])
  ::
      %remake
    ?~  who=(~(get by notes) 'rest-sour')  
      (cat 3 brief '&act=search')
    (rap 3 ~[brief '&ship=' u.who '&act=search'])
  ==
::
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder horde)
  =+  notes=?~(body ~ (frisk:rudder q.u.body))
  ::
  ::  check-arguments
  ::
  ::  - 'post' argument
  ::    Always included. Specifies which Horde.
  ::    additional data specified w/ strange names, as
  ::    below:
  ::
  ::  - Post Expectations
  ::    * %export - needs 'expo-ship', 'expo-name'
  ::    * %import - needs 'impo-folder', 'group-select', 'impo-name'
  ::    * %permit - needs 'ship'
  ::    * %remove - needs 'ship'
  ::    * %search - needs 'ship'
  ::    * %remake - needs 'rest-reso', 'rest-ship', 'rest-name', 'rest-sour', 'group-select'
  ::  
  ?.  (~(has by notes) 'post')         'Error: Unrecognized Function Call'
  ?+    pact=(~(got by notes) 'post')  'Error: Unrecognized Function Call'
      %permit
    ?.  (~(has by notes) 'ship')
      'Error: Missing Data in Function Call'
    =-  
      ?.  ?=(~ -)  `horde`[%permit (sy ~[u.-])]
      'Sorry, we didn\'t recognize that ship name - please try again'
    (slaw %p (~(got by notes) 'ship'))

  ::
      %remove
    ?.  (~(has by notes) 'ship')
      'Error: Missing Data in Function Call'
    =-  
      ?.  ?=(~ -)  `horde`[%remove (sy ~[u.-])]
      'Sorry, we didn\'t recognize that ship name - please try again'
    (slaw %p (~(got by notes) 'ship'))
  ::
      %search
    ?.  (~(has by notes) 'ship')
      'Error: Missing Data in Function Call'
    =-  
      ?.  ?=(~ -)  `horde`[%search (sy ~[u.-])]
      'Sorry, we didn\'t recognize that ship name - please try again'
    (slaw %p (~(got by notes) 'ship'))
  ::
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
      /peat
      /(scot %da now.bol)
      /hav
      /(scot %tas fol)
    ==
  ::
      %remake
    ?.  ?&  (~(has by notes) 'rest-reso')
            (~(has by notes) 'rest-sour')
            (~(has by notes) 'rest-ship')
            (~(has by notes) 'rest-name')
            (~(has by notes) 'group-select')
        ==
      'Error: Missing Data in Function Call'
    ?~  new=(slaw %tas (~(got by notes) 'rest-reso'))
      'Error: Specify New-Resource Name'
    ?:  (~(has in resources) [our.bol u.new])
      'Error: Invalid New-Resource Name - Already In Use'
    =/  maybe-dime-tape=(unit [dime tape])
      %+  rush  (~(got by notes) 'group-select')
      ;~(pfix sig ;~((glue bar) crub:so (star next)))
    ?~  dt=maybe-dime-tape  'Error: Invalid Group Selection'
    ?.  ?=(%p -<.u.dt)      'Error: Something Went Wrong - Sorry!'
    ?~  sip=(slaw %p (~(got by notes) 'rest-ship'))
      'Error: Invalid Resource Selection'
    ?~  nam=(slaw %tas (~(got by notes) 'rest-name'))
      'Error: Invalid Resource Selection'
    ?~  who=(slaw %p (~(got by notes) 'rest-sour'))
      'Error: Invalid Resource Selection'
    ?.  ?:  =(our.bol u.who)  (~(has in resources) [u.sip u.nam])
        %.  [u.sip u.nam]  %~  has  in  %~  key  by
        (malt ~(tap in (~(get ju known) u.who)))
      %^  cat  3  'Error: Invalid Resource Selection - '
      'Maybe you asked for something that no-longer is available?'
    =-  `horde`[%remake - [->.u.dt (crip +.u.dt)] u.new]
    ;;  (each resource [ship resource])
    ?:(=(our.bol u.who) [%.y [u.sip u.nam]] [%.n [u.who [u.sip u.nam]]])
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
  ?+    get=(~(got by notes) 'act')
    [%code 404 'Error: Unrecognized Function Call']
  ::
    %export  [%page (expo beeps)]                        ::  expo
    %import  [%page (impo beeps)]                        ::  impo
    %permit  [%page (perm beeps)]                        ::  perm
    %remove  [%page (perm beeps)]                        ::  perm
    %digest  [%page (abou beeps)]                        ::  abou
    %return  [%page (main beeps)]                        ::  main
  ::
      %search
    =-  [%page (sear beeps -)]                           ::  sear
    ^-  (unit @p)
    ?~(sil=(~(get by notes) 'ship') ~ (slaw %p u.sil))
  ::
      %remake
    =-  [%page (sear beeps -)]                           ::  sear
    ^-  (unit @p)
    ?~(sil=(~(get by notes) 'ship') ~ (slaw %p u.sil))
  ==
  ++  main
    |=  beeps=(unit [gud=? txt=@t])
    ^-  manx
    ;html
      ;head
        ;title:"Peat Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;header
          ;div(class "title")
            ;h1:"Peat Graph Backup and Restoration Utility"
          ==
          ;div(class "status-message")
            ;+  ?~  beeps  :/"" 
                (status:re u.beeps)
          ==
        ==
      ::
        ;main
          ;h2:"Disk Utilities"
        ::
          ;form(class "main-menu", method "GET")
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
        ::
          ;h2:"On-Line Utilities"
        ::
          ;form(class "main-menu", method "GET")
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
        ::
          ;h2:"OgerTalk™️ Permissions"
        ::
          ;form(class "main-menu")
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
              =value  "remove"
              ; Remove 🚫
            ==
          ==
        ==
      ::
        ;nav
          ;+  what:re
          ;+  home:re
          ;+  find:re
        ==
      ::
        ;footer
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
        ;title:"Peat Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
    ::
      ;body
        ;header
          ;div(class "title")
            ;h1:"Peat Graph Backup and Restoration Utility"
          ==
        ::
          ;div(class "status-message")
            ;+  ?~  beeps  :/"" 
                (status:re u.beeps)
          ==
        ==
      ::
        ;main
          ;div(class "expo-wrap")
            ;h2:"Chat Graphs"                            ::  export chats
          ::
            ;div(class "table-header-three")
              ;h3:"Host"
            ::
              ;h3:"Chat Graph"
            ::
              ;h3:"Export"
            ==
          ::
            ;div(class "table-body-three")
              ;*  ;;  marl
                  =-  ?.  ?=(~ -)  -
                      ;=  ;p(class "empty"):"No Chat Graphs"
                      ==
                  %+  murn  ~(tap in resources)
                  (murn-expo-list:re %chat)
            ==
          ==
        ::
          ;div(class "expo-wrap")
            ;h2:"Link Libraries"                         ::  export links
          ::
            ;div(class "table-header-three")
              ;h3:"Host"
            ::
              ;h3:"Link Library"
            ::
              ;h3:"Export"
            ==
          ::
            ;div(class "table-body-three")
              ;*  ;;  marl
                  =-  ?.  ?=(~ -)  -
                      ;=  ;p(class "empty"):"No Link Libraries"
                      ==
                  %+  murn  ~(tap in resources)
                  (murn-expo-list:re %link)
            ==
          ==
        ::
          ;div(class "expo-wrap")
            ;h2:"Notebook Graphs"                        ::  export notebooks
          ::
            ;div(class "table-header-three")
              ;h3:"Host"
            ::
              ;h3:"Notebook Graph"
            ::
              ;h3:"Export"
            ==
          ::
            ;div(class "table-body-three")
              ;*  ;;  marl
                  =-
                    ?.  ?=(~ -)  -
                    ;=  ;p(class "empty"):"No Notebook Graphs"
                    ==
                  %+  murn  ~(tap in resources)
                  (murn-expo-list:re %publish)
            ==
          ==
        ==
      ::
        ;nav
          ;+  what:re
          ;+  home:re
          ;+  find:re
        ==
      ::
        ;footer
          ;+  quartus-footer:re
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
        ;title:"Peat Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
    ::
      ;body
        ;header
          ;div(class "title")
            ;h1:"Peat Graph Backup and Restoration Utility"
          ==
        ::
          ;div(class "status-message")
            ;+  ?~  beeps  :/"" 
                (status:re u.beeps)
          ==
        ==
      ::
        ;main
          ;div(class "explain-contain")
            ;+  impo-explainer:re
          ==
        ::
          ;div(class "impo-wrapper")
            ;form(class "impo-form", method "POST")
              ;h3
                {(trip (spat /(scot %p our.bol)/peat/(scot %da now.bol)/hav))}
              ==
            ::
              ;select
                =name      "impo-folder"
                =required  ""
                ;*  =-  ?~  haz=~(tap in dir:-)
                          ;=  ;option(value "", hidden ""):"No Archives Detected"
                          ==
                        %-  %-  lead
                          ;option(value "", hidden ""):"Select An Archive"
                        %+  turn  haz
                        |=([@ta ~] ;option(value "{(trip -.+<)}"):"/{(trip -.+<)}")
                    .^  arch  %cy
                      /(scot %p our.bol)/peat/(scot %da now.bol)/hav
                    ==
              ==
            ::
              ;+  group-select:re
            ::
              ;input
                =class        "text-name"
                =name         "impo-name"
                =type         "text"
                =required     ""
                =placeholder  "my-new-chat";
            ::
              ;button
                =class  "button-tile"
                =name   "post"
                =value  "import"
                ; Import 📤
              ==
            ==
          ==
        ==
      ::
        ;nav
          ;+  what:re
          ;+  home:re
          ;+  find:re
        ==
      ::
        ;footer
          ;+  quartus-footer:re
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
        ;title:"Peat Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;header
          ;div(class "title")
            ;h1:"Peat Graph Backup and Restoration Utility"
          ==
        ::
          ;div(class "status-message")
            ;+  ?~  beeps  :/"" 
                (status:re u.beeps)
          ==
        ==
      ::
        ;main
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
          ::
            ;div(class "friend-list-tile")
              ;form(class "friend-list", method "GET")
                ;input
                  =name  "ship"
                  =type  "text"
                  =style  "display: none"
                  =value  "{(scow %p our.bol)}";
              ::
                ;button
                  =class  "friend-name"
                  =type   "submit"
                  =name   "act"
                  =value  "search"
                  {(scow %p our.bol)}
                ==
              ==
            ==
          ==
        ==
      ::
        ;nav
          ;+  what:re
          ;+  home:re
          ;+  find:re
        ==
      ::
        ;footer
          ;+  quartus-footer:re
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
    ;div(class "sear-search-wrap")
      ;div(class "explain-contain")
        ;+  rest-explainer:re
      ==
    ::
      ;div(class "rest-search-form-wrap")
        ;div(class "expo-wrap")
          ;h2:"Chats"                                    ::  remake chats
        ::
          ;div(class "table-head-three")
          ::
            ;h3:"Host"
          ::
            ;h3:"Chat Graph"
          ::
            ;h3:"Export"
          ==
        ::
          ;div(class "table-body")
            ;form(class "line-form-button", method "POST")
            ::
              ;div(class "list-line-new")
                ;label(for "new-chat"):"New Resource Name"
              ::
                ;input
                  =id           "new-chat"
                  =type         "text"
                  =name         "rest-reso"
                  =placeholder  "my-new-resource";
              ==
            ::
              ;div(class "list-line-group")
                ;+  group-select:re
              ==
            ::  hidden input to specify what ship
              ;input
                =style  "display: none"
                =name  "rest-sour"
                =type  "text"
                =value  "{(scow %p sip)}";
            ::
              ;*  ;;  marl
                  ?.  =(our.bol sip)
                    =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty"):"No Chat Graphs"
                        ==
                    %-  murn  :_  (make-remake %chat)
                    ;;  (list [resource (unit ?(%chat %link %publish))])
                    %+  turn  ~(tap in (~(get ju known) sip))
                    |=([res=resource typ=?(%chat %link %publish)] [res `typ])
                  =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty"):"No Chat Graphs"
                        ==
                  %-  murn  :_  (make-remake %chat)
                  %+  turn  ~(tap in resources)
                  |=  res=resource
                  ;;  $:  resource
                          (unit ?(%chat %link %publish))
                      ==
                  [res ~]
            ==
          ==
        ==
      ::
        ;div(class "expo-wrap")
          ;h2:"Link Libraries"                           ::  remake links
        ::
          ;div(class "table-head-three")
          ::
            ;h3:"Host"
          ::
            ;h3:"Link Library"
          ::
            ;h3:"Export"
          ==
        ::
          ;div(class "table-body")
            ;form(class "line-form-button", method "POST")
            ::  hidden input to specify what ship
              ;input
                =name  "rest-sour"
                =type  "text"
                =style  "display: none"
                =value  "{(scow %p sip)}";
            ::
              ;div(class "list-line-new")
                ;label(for "new-link"):"New Resource Name"
              ::
                ;input
                  =id           "new-link"
                  =type         "text"
                  =name         "rest-reso"
                  =placeholder  "my-new-resource";
              ==
            ::
              ;div(class "list-line-group")
                ;+  group-select:re
              ==
            ::  hidden input to specify what ship
              ;input
                =style  "display: none"
                =name  "rest-sour"
                =type  "text"
                =value  "{(scow %p sip)}";
            ::
              ;*  ;;  marl
                  ?.  =(our.bol sip)
                    =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty"):"No Link Libraries"
                        ==
                    %-  murn  :_  (make-remake %link)
                    ;;  (list [resource (unit ?(%chat %link %publish))])
                    %+  turn  ~(tap in (~(get ju known) sip))
                    |=([res=resource typ=?(%chat %link %publish)] [res `typ])
                  =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty"):"No Link Libraries"
                        ==
                  %-  murn  :_  (make-remake %link)
                  %+  turn  ~(tap in resources)
                  |=  res=resource
                  ;;  $:  resource
                          (unit ?(%chat %link %publish))
                      ==
                  [res ~]
            ==
          ==
        ==
      ::
        ;div(class "expo-wrap")
          ;h2:"Notebooks"                                ::  remake notebooks
        ::
          ;div(class "table-head-three")
          ::
            ;h3:"Host"
          ::
            ;h3:"Notebook Graph"
          ::
            ;h3:"Export"
          ==
        ::
          ;div(class "table-body")
            ;form(class "line-form-button", method "POST")
            ::  hidden input to specify what ship
              ;input
                =name  "rest-sour"
                =type  "text"
                =style  "display: none"
                =value  "{(scow %p sip)}";
            ::
              ;div(class "list-line-new")
                ;label(for "new-note"):"New Resource Name"
              ::
                ;input
                  =id           "new-note"
                  =type         "text"
                  =name         "rest-reso"
                  =placeholder  "my-new-resource";
              ==
            ::
              ;div(class "list-line-group")
                ;+  group-select:re
              ==
            ::  hidden input to specify what ship
              ;input
                =style  "display: none"
                =name  "rest-sour"
                =type  "text"
                =value  "{(scow %p sip)}";
            ::
              ;*  ;;  marl
                  ?.  =(our.bol sip)
                    =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty"):"No Notebook Graphs"
                        ==
                    %-  murn  :_  (make-remake %publish)
                    ;;  (list [resource (unit ?(%chat %link %publish))])
                    %+  turn  ~(tap in (~(get ju known) sip))
                    |=([res=resource typ=?(%chat %link %publish)] [res `typ])
                  =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty"):"No Notebook Graphs"
                        ==
                  %-  murn  :_  (make-remake %publish)
                  %+  turn  ~(tap in resources)
                  |=  res=resource
                  ;;  $:  resource
                          (unit ?(%chat %link %publish))
                      ==
                  [res ~]
            ==
          ==
        ==
      ==
    ==
  ++  search-form
    ^-  manx
    ;div(class "sear-search-form-wrap")
      ;form(class "sear-search-form", method "POST")
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
          =name   "post"
          =value  "search"
          ; Search 🔍
      ::
        ==
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
  ++  no-friends
    ;=  ;dl
          ;dt:"No Friends?"
          ;dd:" - You always have yourself!"
        ==
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
  ::
  ++  make-remake
    |=  typ=?(%chat %link %publish)
    |=  [res=resource tip=(unit ?(%chat %link %publish))]
    ^-  (unit manx)
    =/  foam=(unit ?(%chat %link %publish))
      ?~  ass=~(assoc scry:hc (en-path:res-lib res))  tip
      ?.  ?=(%graph -.config.metadatum.u.ass)  ~
      `;;(?(%chat %link %publish) module.config.metadatum.u.ass)
    ?~  foam  ~
    ?.  =(typ u.foam)  ~
    :-  ~
    ;div(class "list-line")
      ;p(class "ship-name"):"{(scow %p entity.res)}"
    ::
      ;p(class "resource-name"):"{(scow %tas name.res)}"
    ::
      ;div(class "list-line-remake")
        ;input
          =style  "display: none"
          =type   "text"
          =name   "rest-ship"
          =value  (scow %p entity.res);
      ::
        ;input
          =style  "display: none"
          =type   "text"
          =name   "rest-name"
          =value  (scow %tas name.res);
      ::
        ;button
          =class  "table-button"
          =type   "submit"
          =name   "post"
          =value  "remake"
          ; Remake 📡
        ==
      ==
    ==
  --
::
::  perm page
::
  ++  perm
    |=  beeps=(unit [gud=? txt=@t])
    |^
    ^-  manx
    ;html
      ;head
        ;title:"Peat Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(class "page")
          ;header
            ;div(class "title")
              ;h1:"Peat Graph Backup and Restoration Utility"
            ==
          ::
            ;div(class "status-message")
              ;+  ?~  beeps  :/"" 
                  (status:re u.beeps)
            ==
          ==
        ::
          ;main
            ;div(class "explain-contain")
              ;+  ?.  =([~ 'remove'] (~(get by notes) 'act'))
                  perm-explainer-a:re  perm-explainer-b:re
            ==
          ::
            ;div(class "perm-add")
              ;div(class "perm-wrap", id "ship-search")
                ;div(class "perm-guts")
                  ;div(class "perm-search")
                    ;form(class "search-form", method "POST")
                      ;input
                        =class        "text-planet"
                        =name         "ship"
                        =type         "text"
                        =required     ""
                        =placeholder  "~sampel-palnet";
                    ::
                      ;button
                        =class  "search-button"
                        =type   "submit"
                        =name   "post"
                        =value  "permit"
                        ; Permit ☑️
                      ==
                    ==
                  ==
                ==
              ==
            ==
          ::
            ;div(class "perm-del")
              ;+  remover
            ==
          ==
        ::
          ;nav
            ;+  what:re
            ;+  home:re
            ;+  find:re
          ==
        ::
          ;footer
            ;+  quartus-footer:re
          ==
        ==
      ==
    ==
    ::
    ++  remover
      ^-  manx
      =;  murl=marl
        ;div(class "friends")
          ;*  ?.  =(~ murl)  murl
              ;=  ;p(class "no-friends"):"No Friends?"
              ==
        ==
      %+  murn  ~(tap in permits)
      |=  sip=ship
      :-  ~
      ;div(class "permit-line-form-button")
        ;form(class "permit-form-button", method "POST")
          ;input
            =style  "display: none"
            =type   "text"
            =name   "ship"
            =value  (scow %p sip);
        ::
          ;button
            =class  "table-button"
            =type   "submit"
            =name   "post"
            =value  "remove"
            {(scow %p sip)} 🚫
          ==
        ==
      ==
    --
::
::  abou page
::
  ++  abou
    |=  beeps=(unit [gud=? txt=@t])
    ^-  manx
    ;html
      ;head
        ;title:"Peat Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(class "page")
          ;header
            ;div(class "title")
              ;h1:"Peat Graph Backup and Restoration Utility"
            ==
          ::
            ;div(class "status-message")
              ;+  ?~  beeps  :/"" 
                  (status:re u.beeps)
            ==
          ==
        ::
          ;main
            ;div(class "explain-contain")
              ;+  abou-explainer:re
            ==
          ==
        ::
          ;nav
            ;+  what:re
            ;+  home:re
            ;+  find:re
          ==
        ::
          ;footer
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
        ;h2:"Disk Utilities: Import"
      ::
        ;dl
          ;dt:"The Import From Disk Utility assumes you have:"
        ::
          ;dd:" - A mounted desk called 'peat'"
          ;dd:" - A directory in the 'peat' desk's '/hav' directory with a name you know"
          ;dd:" - A series of .jam files in the known, aforementioned directory created using the export function"
          ;dd:" - A pre-existing group for which you are an admin"
          ;dd:" - A name of a group"
        ==
      ::
        ;dl
          ;dt:"Importing a Resource"
        ::
          ;dd
            ; - Enter the name of that aforementioned, known directory
            ;ul
              ;li:"(this folder should contain jam files appurtenant to the archive you're trying to import)"
              ;li:"(to create an archive, navigate to the Export Disk Utility, from the main menu)"
            ==
          ==
          ;dd:" - Select a group from the list of those you manage"
          ;dd
            ; - Enter a name for Peat to use while creating a new, local resource to house the imported graph
            ;ul
              ;li:"(Use letters, numbers, and hyphens only. No spaces!)"
            ==
          ==
        ==
      ==
    ::
    ++  perm-explainer-a
      ;div(class "explainer")
        ;h2:"OgerTalk™️: Permit"
      ::
        ;dl(class "explainer-list")
          ;dt:"Adding Friends on OgerTalk™️"
          ;dd:" - Enter the Friend's @p in the field, below"
          ;dd:" - Click Permit ☑️"
        ::
          ;dt:"Removing Friends from OgerTalk™️"
          ;dd:" - Click the button with @p of the Friend you want to remove, on the right"
        ==
      ==
    ++  perm-explainer-b
      ;div(class "explainer")
        ;h2:"OgerTalk™️: Remove"
      ::
        ;dl(class "explainer-list")
          ;dt:"Removing Friends from OgerTalk™️"
          ;dd:" - Click the button with @p of the Friend you want to remove, on the right"
        ::
          ;dt:"Adding Friends on OgerTalk™️"
          ;dd:" - Enter the Friend's @p in the field, below"
          ;dd:" - Click Permit ☑️"
        ==
      ==
    ++  sear-explainer-a
      ;div(class "explainer")
        ;h2:"OgerTalk™️: Search"
      ::
        ;dl(class "explainer-list")
          ;dt:"Frisking your Friends"
          ;dd:" - Peat's OgerTalk™️ Search requires enthusiastic consent from your friends."
          ;dd:" - If one of your friends has Peat installed, they'll need to navigate to the OgerTalk™️ Permissions page and add you before you can use this feature in relation to their ship."
        ::
          ;dt:"Having friends in Peat will:"
          ;dd:" - Let you search for them and track graphs that they're aware of"
          ;dd:" - Remotely request and locally duplicate graphs that your friends possess"
        ::
          ;dt:"No Friends?"
          ;dd:" - You wont be able to search for anyone's graphs until they've authorized you, and we can't tell from here if that's happened."
          ;dd:" - If you know that you should have access to someone's graphs, enter their @p below and click Search."
        ==
      ==
    ++  sear-explainer-b
      ;div(class "explainer")
        ;h2:"Search for Graphs"
      ::
        ;+  ;;  manx
            %+  snag  (~(rad og eny.bol) 9)
            ^-  (list manx)
            :~  ;h3:"We didn't quite catch that - want to search again?"
                ;h3:"You must be new here - Welcome!"
                ;h3:"Dad says \"Remember to never encode Zalgo text into your Sail interfaces.\""
                ;h3:"Remember to garner enthusiastic consent before Searching your friends on OgerTalk™️."
                ;h3:"Peat is brought to you by Quartus Corporation"
                ;h3:"l̸̨̢̨̛͍̤̺̝͉̱̳̭̣͍͕̬̖̈́͛̃̆͒̒̉̅̒̏̂̈̚̚ǒ̵̞̣̝̭̳̭̯̘̗̰͓̟̭̫̗͊̂̀̋͒͌̎̉̈́̽̈́͂̑̀̎͜l̸̛̜̜̘̰̥̼̥͔̪̮̫̝̝̫̦̺̓͐̔͊̓̀̾̉̈́̎̎͂̕͝͠ ̶̡̙̪͉̲̲͕͔̦̺̳͖͔̣̳͕̋͂̓͐̀̀́͛͊̌͗͘͝͝͝I̶̡̬͎͇̦̻̘̲͎͎̱̪͒̉̓̍͌͋̿̽͋̀̍̚͜͝͠ͅ ̶̡̠͍̲̝̜̠͔͙͇̩̗͉̝̀͒̆̉͗̑̅̌͛̽̈́̆̅̚͘͜ḏ̸̡̨̭͙̙̗͉̦͖̘̠͎́̏̓͊́̀̊̓̈́̀͒̎̈́́̂͜i̶̗̰͔̝̩̺̲̪̬͚͖͎̼̅̃̀̄̈́͋͗͋̂̐͗̈́̕͠ͅḑ̵̧̛̛͔̞̺̣̗͈͚̻͔̙̪̙̲͍̌͑̀̀̍̓̂̆̋̈́̍͘͠ ̸̨̧͔̩̟̹̝̺̠̩̮̝͎͖͚̔͐͒͊̽͗̈́̃̒͋͌͘̚͘͘ͅt̶̛̛͍̩̭̟̯̰̪͍̳̼͔͙͕̫̔̏̌̔͋̊̔͂͂̀̆͘͜͝ͅř̵̡̡̛̦̰͖̪̣̮͔̖͕̼͖̭̊̏͊̈͛̈́̀͐̌͒̈̕͝ͅy̴̗͔̘̮͖̜͚͔̤̖̩̰̻̺͋̈̄̃̎̈̀͐͐̈́͛̎̓̉͛͘ ̴̨̢̺̪̝̲̗͉̖̖̙͖̘̤̘͖̔̈́̆͊̇̌̓̌͐̌̊̌͒̇̈́̕ę̶͙̦͇͎̬͔̗̫̯̞̯̦̳̗̼̐́̋͛͗̐̄̐͆̌̓̑̕͝͠n̶̛̛̥̣̞̲̦̳̠̠̖̻̘͍̜̬̣̽̉̽̈̾̑̀͋̈́͋͑͌̊͜͝ç̷̲͙̺͎̟̠̬͎̬̜͓̩̝̯̝̄̀͊̇̊̌͋̏́̿̽̄͛̑̅̽ò̶̹̤̝͈̼̮̖̬̱͍͚̻͚͉̾̈͑̀̉͆̈́̆̇́̂́̇́͜d̷̨͙̙̪̦̠͇͍̥̖̦̦͖̹̎͒͋̇̐̍̓̓̐̋̄̈́͘͘͘͝i̶̡̡̡̛͍̟͓͙̯͎̮̲̟̰̮̤̩̎̃̌̊͆̎́̔̎͘͘̚͠͝n̴͈̙͔̹̝̺̘̠͚̖͕͎͍̑̀̾͋̂̋͌̑̃̾̊̃̐̓͘͜͝ͅg̸̙̘͖̙͖̭̥̪̦̗͇͙̲̯̐̈́̔̾͌̒̾͋͐̿́̀́͝ͅ ̴̢̨̫͕̲̺͉̻̭̣͓̹̯̗͇̗̀͐̍͒̎̈́́͛̑̉͛̚̕̕z̶̨̙͇̼͚͇͓͕̯͖͙̳͈̤̙̀̽͒̍̈́̌͆̇̋̊̊̐̓͠͝͝a̸̧̨̛̘͚̻̣̱̱̠͔̟̬̜̱̯͒̀͂͋̄̽̈́́̍̈͐͒̇̽ͅl̷̡̛̺̰̙̞̜̱̰̲̲͍̮̱̼̞̾̔̓͂͑̍͂͋̃̔͘̕͝͝͝ͅĝ̷̛̙̮̠̝̪̼̺̲̜̥̫̬̩̮̜͕͋̄͋̈̔͐̈͐͌͘̚͝͝ö̸̢̢̨̰͓̳̳͚̲̦̺̣̲́́́͒́̊̉̄̌̂͂̓̎͜͜͝"
                ;h3:"With OgerTalk™️, backing up Graphs on Urbit is easy and fun!"
                ;h3:"If you're enjoying using Peat, you should try Keep - Quartus Corporation's agent that backs up other agents!"
                ;h3:"Try clicking on your OgerTalk™️ friends name, on your right."
                ;h3:"We couldn't find that friend, but we did have some suggestions, on the right."
            ==
      ==
    ++  rest-explainer
      ;div(class "explainer")
        ;h2:"OgerTalk™️: Remake"
      ::
        ;dl
          ;dt:"To recreate a resource"
          ;dd
            ; - Enter a name for Peat to use while creating a new, local resource to house the recreated graph
            ;ul
              ;li:"   (Use letters, numbers, and hyphens only. No spaces!)"
            ==
          ==
        ::
          ;dd:" - Click Remake 📡 next to the appropriate resource to create a new resource in the specified group and copy the graph contents over."
        ==
      ==
    ++  abou-explainer
      ;div(class "explainer")
        ;h2:"Peat Graph Backup and Restoration Utility - About Us"
        ;p(class "explainer-body"):"Starting a group on Urbit is easy. You have a field of interest, find some like-minded friends, form a group and put some chats in it."
        ;p(class "explainer-body"):"Running a successful group on Urbit is slightly harder. You must:"
        ;p(class "explainer-buon"):" - Maintain engagement"
        ;p(class "explainer-buon"):" - Compete with other groups discussing the same subject matter"
        ;p(class "explainer-note"):"   (Quartus Corporation produces a product called Orca that helps link similar-subject-matter chats)"
        ;p(class "explainer-buon"):" - Manage your user base"
        ;p(class "explainer-note"):"   (Quartus Corporation produces a product called Expo that helps with group management activities)"
        ;p(class "explainer-body"):"But - by far, the most difficult part of running a group presently is backing up your data. And, in an environment where you are your own data steward, this can be a serious challenge."
        ;br;
        ;p(class "explainer-gold"):"Enter Peat"
        ;br;
        ;p(class "explainer-body"):"Peat by Quartus Corporation is an Urbit utility for locally and remotely backing up graphs. Peat is capable of:"
        ;p(class "explainer-buon"):" - Disk Utilities"
        ;p(class "explainer-buto"):"   * Exporting Graphs to Disk"
        ;p(class "explainer-buto"):"   * Importing Graphs from Disk"
        ;p(class "explainer-buon"):" - On-Line Utilities"
        ;p(class "explainer-buto"):"   * Duplicating an existing graph that your ship has access to, on your ship"
        ;p(class "explainer-buto"):"   * Copying an existing graph that a ship you're friends with has access to, on your ship"
        ;p(class "explainer-buon"):" - OgerTalk™️ Permissions"
        ;p(class "explainer-buto"):"   * OgerTalk™️ is Peat's On-Line™️ Networking Protocol"
        ;p(class "explainer-buto"):"   * OgerTalk™️ enables one-thousand new vistas for Peat users including remote backup and restoration of graphs"
        ;p(class "explainer-buto"):"   * Managing your OgerTalk™️ permissions is easy - visit the Permissions page from the main menu"
        ;br;
        ;p(class "explainer-body"):"If you have questions about Peat, head on 'peat' to ~mister-hilper-dozzod-dalten/quartus and submit a ticket. One of our friendly engineers will be with you shortly."
      ==
    ::
    ++  what
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
    ++  home
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
    ++  find
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
                ; Search Friends 🔍
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