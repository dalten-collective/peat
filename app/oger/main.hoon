::
::  main for oger - by Quartus Corporation
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
  ~&  >>  [-:!>(notes) notes]
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
      ?.  ?=(~ -)  `horde`[%permit (sy ~[u.-])]
      'Sorry, we didn\'t recognize that ship name - please try again'
    (slaw %p (~(got by notes) 'ship'))
  ::
      %search
    ?.  (~(has by notes) 'ship')
      'Error: Missing Data in Function Call'
    =-  
      ?.  ?=(~ -)  `horde`[%permit (sy ~[u.-])]
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
      /oger
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
      %export
    [%page (expo beeps)]                                 ::  expo
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
    [%page (sear beeps ~)]                               ::  sear
  ::
      %permit
    [%page (perm beeps)]                                 ::  perm
  ::
      %remove
    [%page (perm beeps)]                                 ::  perm
  ::
      %digest
    [%page (abou beeps)]                                 ::  abou
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
        ;style:"{(trip style)}"
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
                        =value  "Remove"
                        ; Remove 🚫
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
        ;style:"{(trip style)}"
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
              ;p(class "table-label"):"Chat Graphs"      ::  export chats
            ::
              ;div(class "table-header-three")
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Host"
                ==
              ::
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Chat Graph"
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
                        ;=  ;p(class "empty-table"):"No Chat Graphs"
                        ==
                    (murn ~(tap in resources) (murn-expo-list:re %chat))
              ==
            ==
          ::
            ;div(class "link-table")
              ;p(class "table-label"):"Link Libraries"   ::  export links
            ::
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
              ;p(class "table-label"):"Notebook Graphs"  ::  export notebooks
            ::
              ;div(class "table-header-three")
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Host"
                ==
              ::
                ;div(class "table-header-title")
                  ;p(class "table-title"):"Notebook Graph"
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
                      ;=  ;p(class "empty-table"):"No Notebook Graphs"
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
        ;style:"{(trip style)}"
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
    ~&  >  peeps
    |^
    ^-  manx
    ;html
      ;head
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
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
        ;div(class "link-table")
          ;div(class "table-header-three")
            ;p(class "table-label"):"Chats"              ::  remake chats
          ::
            ;div(class "table-header-title")
              ;p(class "table-title"):"Host"
            ==
          ::
            ;div(class "table-header-title")
              ;p(class "table-title"):"Chat Graph"
            ==
          ::
            ;div(class "table-header-title")
              ;p(class "table-title"):"Export"
            ==
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
                ;p(class "table-tip"):"New Resource Name"
              ::
                ;input
                  =type         "text"
                  =name         "rest-reso"
                  =placeholder  "my-new-resource";
              ==
            ::
              ;div(class "list-line-group")
                ;+  group-select:re
              ==
            ::
              ;*  ;;  marl
                  ?.  =(our.bol sip)
                    =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty-table"):"No Chat Graphs"
                        ==
                    %-  murn  :_  (make-remake %chat)
                    ;;  (list [resource (unit ?(%chat %link %publish))])
                    %+  turn  ~(tap in (~(get ju known) sip))
                    |=([res=resource typ=?(%chat %link %publish)] [res `typ])
                  =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty-table"):"No Chat Graphs"
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
        ;div(class "link-table")
          ;div(class "table-header-three")
            ;p(class "table-label"):"Link Libraries"     ::  remake links
          ::
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
                ;p(class "table-tip"):"New Resource Name"
              ::
                ;input
                  =type         "text"
                  =name         "rest-reso"
                  =placeholder  "my-new-resource";
              ==
            ::
              ;div(class "list-line-group")
                ;+  group-select:re
              ==
            ::
              ;*  ;;  marl
                  ?.  =(our.bol sip)
                    =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty-table"):"No Link Libraries"
                        ==
                    %-  murn  :_  (make-remake %link)
                    ;;  (list [resource (unit ?(%chat %link %publish))])
                    %+  turn  ~(tap in (~(get ju known) sip))
                    |=([res=resource typ=?(%chat %link %publish)] [res `typ])
                  =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty-table"):"No Link Libraries"
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
        ;div(class "link-table")
          ;div(class "table-header-three")
            ;p(class "table-label"):"Notebooks"          ::  remake notebooks
          ::
            ;div(class "table-header-title")
              ;p(class "table-title"):"Host"
            ==
          ::
            ;div(class "table-header-title")
              ;p(class "table-title"):"Notebook Graph"
            ==
          ::
            ;div(class "table-header-title")
              ;p(class "table-title"):"Export"
            ==
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
                ;p(class "table-tip"):"New Resource Name"
              ::
                ;input
                  =type         "text"
                  =name         "rest-reso"
                  =placeholder  "my-new-resource";
              ==
            ::
              ;div(class "list-line-group")
                ;+  group-select:re
              ==
            ::
              ;*  ;;  marl
                  ?.  =(our.bol sip)
                    =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty-table"):"No Notebook Graphs"
                        ==
                    %-  murn  :_  (make-remake %publish)
                    ;;  (list [resource (unit ?(%chat %link %publish))])
                    %+  turn  ~(tap in (~(get ju known) sip))
                    |=([res=resource typ=?(%chat %link %publish)] [res `typ])
                  =-  ?.  ?=(~ -)  -
                        ;=  ;p(class "empty-table"):"No Notebook Graphs"
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
    ;=  ;p(class "no-friends"):"No Friends?"
        ;p(class "no-friends"):"We'll be your friend"
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
    ?~  ass=~(assoc scry:hc (en-path:res-lib res))  ~  :: could we find an association in metadata
    ?.  ?=(%graph -.config.metadatum.u.ass)  ~         :: this product only works on graph modules as of the present
    =*  fon  ?~(tip module.config.metadatum.u.ass u.tip)
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
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
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
    ++  remover
      ^-  manx
      =;  murl=marl
        ;div(class "friends")
          ;*  ?.  =(~ murl)  murl
              ;=  ;p(class "no-friends"):"No Friends?"
              ==
        ==
      ~&  >>>  ~(tap in permits)
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
        ;title:"Oger Graph Backup and Restoration Utility"
        ;style:"form \{ display: inline-block; }"
        ;style:"{(trip style)}"
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
              ;+  abou-explainer:re
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
        ;p(class "explainer-buon"):" - A mounted desk called 'oger'"
        ;p(class "explainer-buon"):" - A directory in the 'oger' desk's '/hav' directory with a name you know"
        ;p(class "explainer-buon"):" - A series of .jam files in the known, aforementioned directory created using the export function"
        ;p(class "explainer-buon"):" - A pre-existing group for which you are an admin"
        ;p(class "explainer-buon"):" - A name of a group"
        ;p(class "explainer-body"):"To import a resource:"
        ;p(class "explainer-buon"):" - Enter the name of that aforementioned, known directory"
        ;p(class "explainer-note"):"   (this folder should contain jam files appurtenant to the archive you're trying to import)"
        ;p(class "explainer-note"):"   (to create an archive, navigate to the Export Disk Utility, from the main menu)"
        ;p(class "explainer-buon"):" - Select a group from the list of those you manage"
        ;p(class "explainer-buon"):" - Enter a name for Oger to use while creating a new, local resource to house the imported graph"
        ;p(class "explainer-note"):"   (Use letters, numbers, and hyphens only. No spaces!)"
      ==
    ::
    ++  sear-explainer-a
      ;div(class "explainer")
        ;p(class "explainer-head"):"Search for Graphs"
        ;p(class "explainer-body"):"You do not currently have any friends. You can make some by asking them to permit you, then searching for them here."
        ;p(class "explainer-body"):"Having friends in Oger will:"
        ;p(class "explainer-buon"):" - Let you search for them and track graphs that they're aware of"
        ;p(class "explainer-buon"):" - Remotely request and locally duplicate graphs that your friends possess"
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
                ;p(class "explainer-body"):"Dad says \"Remember to never encode Zalgo text into your Sail interfaces.\""
                ;p(class "explainer-body"):"Remember to garner enthusiastic consent before Searching your friends on OgerTalk™️."
                ;p(class "explainer-body"):"Oger is brought to you by Quartus Corporation"
                ;p(class "explainer-body"):"l̸̨̢̨̛͍̤̺̝͉̱̳̭̣͍͕̬̖̈́͛̃̆͒̒̉̅̒̏̂̈̚̚ǒ̵̞̣̝̭̳̭̯̘̗̰͓̟̭̫̗͊̂̀̋͒͌̎̉̈́̽̈́͂̑̀̎͜l̸̛̜̜̘̰̥̼̥͔̪̮̫̝̝̫̦̺̓͐̔͊̓̀̾̉̈́̎̎͂̕͝͠ ̶̡̙̪͉̲̲͕͔̦̺̳͖͔̣̳͕̋͂̓͐̀̀́͛͊̌͗͘͝͝͝I̶̡̬͎͇̦̻̘̲͎͎̱̪͒̉̓̍͌͋̿̽͋̀̍̚͜͝͠ͅ ̶̡̠͍̲̝̜̠͔͙͇̩̗͉̝̀͒̆̉͗̑̅̌͛̽̈́̆̅̚͘͜ḏ̸̡̨̭͙̙̗͉̦͖̘̠͎́̏̓͊́̀̊̓̈́̀͒̎̈́́̂͜i̶̗̰͔̝̩̺̲̪̬͚͖͎̼̅̃̀̄̈́͋͗͋̂̐͗̈́̕͠ͅḑ̵̧̛̛͔̞̺̣̗͈͚̻͔̙̪̙̲͍̌͑̀̀̍̓̂̆̋̈́̍͘͠ ̸̨̧͔̩̟̹̝̺̠̩̮̝͎͖͚̔͐͒͊̽͗̈́̃̒͋͌͘̚͘͘ͅt̶̛̛͍̩̭̟̯̰̪͍̳̼͔͙͕̫̔̏̌̔͋̊̔͂͂̀̆͘͜͝ͅř̵̡̡̛̦̰͖̪̣̮͔̖͕̼͖̭̊̏͊̈͛̈́̀͐̌͒̈̕͝ͅy̴̗͔̘̮͖̜͚͔̤̖̩̰̻̺͋̈̄̃̎̈̀͐͐̈́͛̎̓̉͛͘ ̴̨̢̺̪̝̲̗͉̖̖̙͖̘̤̘͖̔̈́̆͊̇̌̓̌͐̌̊̌͒̇̈́̕ę̶͙̦͇͎̬͔̗̫̯̞̯̦̳̗̼̐́̋͛͗̐̄̐͆̌̓̑̕͝͠n̶̛̛̥̣̞̲̦̳̠̠̖̻̘͍̜̬̣̽̉̽̈̾̑̀͋̈́͋͑͌̊͜͝ç̷̲͙̺͎̟̠̬͎̬̜͓̩̝̯̝̄̀͊̇̊̌͋̏́̿̽̄͛̑̅̽ò̶̹̤̝͈̼̮̖̬̱͍͚̻͚͉̾̈͑̀̉͆̈́̆̇́̂́̇́͜d̷̨͙̙̪̦̠͇͍̥̖̦̦͖̹̎͒͋̇̐̍̓̓̐̋̄̈́͘͘͘͝i̶̡̡̡̛͍̟͓͙̯͎̮̲̟̰̮̤̩̎̃̌̊͆̎́̔̎͘͘̚͠͝n̴͈̙͔̹̝̺̘̠͚̖͕͎͍̑̀̾͋̂̋͌̑̃̾̊̃̐̓͘͜͝ͅg̸̙̘͖̙͖̭̥̪̦̗͇͙̲̯̐̈́̔̾͌̒̾͋͐̿́̀́͝ͅ ̴̢̨̫͕̲̺͉̻̭̣͓̹̯̗͇̗̀͐̍͒̎̈́́͛̑̉͛̚̕̕z̶̨̙͇̼͚͇͓͕̯͖͙̳͈̤̙̀̽͒̍̈́̌͆̇̋̊̊̐̓͠͝͝a̸̧̨̛̘͚̻̣̱̱̠͔̟̬̜̱̯͒̀͂͋̄̽̈́́̍̈͐͒̇̽ͅl̷̡̛̺̰̙̞̜̱̰̲̲͍̮̱̼̞̾̔̓͂͑̍͂͋̃̔͘̕͝͝͝ͅĝ̷̛̙̮̠̝̪̼̺̲̜̥̫̬̩̮̜͕͋̄͋̈̔͐̈͐͌͘̚͝͝ö̸̢̢̨̰͓̳̳͚̲̦̺̣̲́́́͒́̊̉̄̌̂͂̓̎͜͜͝"
                ;p(class "explainer-body"):"With OgerTalk™️, backing up Graphs on Urbit is easy and fun!"
                ;p(class "explainer-body"):"If you're enjoying using Oger, you should try Keep - Quartus Corporation's agent that backs up other agents!"
                ;p(class "explainer-body"):"Try clicking on your OgerTalk™️ friends name, on your right."
                ;p(class "explainer-body"):"We couldn't find that friend, but we did have some suggestions, on the right."
            ==
      ==
    ++  rest-explainer
      ;div(class "explainer")
        ;p(class "explainer-head"):"Recreate Graphs"
        ;p(class "explainer-body"):"To recreate a resource"
        ;p(class "explainer-buon"):" - Enter a name for Oger to use while creating a new, local resource to house the recreated graph"
        ;p(class "explainer-note"):"   (Use letters, numbers, and hyphens only. No spaces!)"
        ;p(class "explainer-buon"):" - Click Remake 📡 next to the appropriate resource to create a new resource in the specified group and copy the graph contents over."
      ==
    ++  abou-explainer
      ;div(class "explainer")
        ;p(class "explainer-head"):"Oger Graph Backup and Restoration Utility - About Us"
        ;p(class "explainer-body"):"Starting a group on Urbit is easy. You have a field of interest, find some like-minded friends, form a group and put some chats in it."
        ;p(class "explainer-body"):"Running a successful group on Urbit is slightly harder. You must:"
        ;p(class "explainer-buon"):" - Maintain engagement"
        ;p(class "explainer-buon"):" - Compete with other groups discussing the same subject matter"
        ;p(class "explainer-note"):"   (Quartus Corporation produces a product called Orca that helps link similar-subject-matter chats)"
        ;p(class "explainer-buon"):" - Manage your user base"
        ;p(class "explainer-note"):"   (Quartus Corporation produces a product called Expo that helps with group management activities)"
        ;p(class "explainer-body"):"But - by far, the most difficult part of running a group presently is backing up your data. And, in an environment where you are your own data steward, this can be a serious challenge."
        ;br;
        ;p(class "explainer-gold"):"Enter Oger"
        ;br;
        ;p(class "explainer-body"):"Oger by Quartus Corporation is an Urbit utility for locally and remotely backing up graphs. Oger is capable of:"
        ;p(class "explainer-buon"):" - Disk Utilities"
        ;p(class "explainer-buto"):"   * Exporting Graphs to Disk"
        ;p(class "explainer-buto"):"   * Importing Graphs from Disk"
        ;p(class "explainer-buon"):" - On-Line Utilities"
        ;p(class "explainer-buto"):"   * Duplicating an existing graph that your ship has access to, on your ship"
        ;p(class "explainer-buto"):"   * Copying an existing graph that a ship you're friends with has access to, on your ship"
        ;p(class "explainer-buon"):" - OgerTalk™️ Permissions"
        ;p(class "explainer-buto"):"   * OgerTalk™️ is Oger's On-Line™️ Networking Protocol"
        ;p(class "explainer-buto"):"   * OgerTalk™️ enables one-thousand new vistas for Oger users including remote backup and restoration of graphs"
        ;p(class "explainer-buto"):"   * Managing your OgerTalk™️ permissions is easy - visit the Permissions page from the main menu"
        ;br;
        ;p(class "explainer-body"):"If you have questions about Oger, head on 'oger' to ~mister-hilper-dozzod-dalten/quartus and submit a ticket. One of our friendly engineers will be with you shortly."
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