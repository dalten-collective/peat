::
::  control-plane for oger
::
/-  *oger, store=graph-store, *resource
/+  rudder
::
^-  (page:rudder state-1 horde)
::
|_  $:  bol=bowl:gall
        odo=order:rudder
        sat=state-1
    ==
::
++  final  (alert:rudder 'control-plane' build)
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder horde)
  'fukt'
++  build
  |=  $:  args=(list [k=@t v=@t])
          msgs=(unit [gud=? txt=@t])
      ==
  =+  notes=(malt args)
  ^-  reply:rudder
  |^  [%page main]
  ++  main
    ^-  manx
    ;html
      ;head
        ;title:"%oger - control-plane"
        ;style:"form \{ display: inline-block; }"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div(id "page")
          ;div(id "header")
            ;div(id "title")
              ;h1:"Oger Graph Backup and Restoration Utility"
            ==
          ==
        ::
          ;div(class "main")
            ;div(class "panels")
              ;div(class "sub-panel")
                ;div(class "panel-buttons")
                  ;div(class "panel-form")
                    ;form(class "panel-form-buttons")
                      ;a
                        =class  "button-tile"
                        =href   "../apps/oger/export"
                        ; Download 📥
                      ==
                      ;a
                        =class  "button-tile"
                        =href   "../apps/oger/import"
                        ; Import 📤
                      ==
                    ==
                  ==
                ::
                  ;div(class "panel-tip")
                    ;p:"Tooltip"
                  ==
                ==
              ==
            ::
              ;div(class "sub-panel")
                ;div(class "panel-buttons")
                  ;div(class "panel-form")
                    ;form(class "panel-form-buttons")
                      ;a
                        =class  "button-tile"
                        =href   "../apps/oger/search"
                        ; Search 🔍
                      ==
                      ;a
                        =class  "button-tile"
                        =href   "../apps/oger/remake"
                        ; Remake 📡
                      ==
                    ==
                  ==
                ::
                  ;div(class "panel-tip")
                    ;p:"Tooltip"
                  ==
                ==
              ==
            ::
              ;div(class "sub-panel")
                ;div(class "panel-buttons")
                  ;div(class "panel-form")
                    ;form(class "panel-form-buttons")
                      ;a
                        =class  "button-tile"
                        =href   "../apps/oger/permissions"
                        ; Allow ☑️ / Deny 🚫
                      ==
                    ==
                  ==
                ::
                  ;div(class "panel-tip")
                    ;p:"Tooltip"
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
::  re-used elements
::
  ++  re
    |%
    ++  about
      ^-  manx
      ;div(id "about")
        ;div(class "menu-guts")
          ;a(class "menu-button")
            =href    "../apps/oger/about"
            =target  "_self"
            ; About
          ==
        ==
      ==
    ::
    ++  main
      ^-  manx
      ;div(class "menu-wrap", id "about")
        ;div(class "menu-guts")
          ;a(class "menu-button")
            =href    "../apps/oger"
            =target  "_self"
            ; Main
          ==
        ==
      ==
    ::
    ++  search
      ^-  manx
      ;div(class "menu-wrap", id "ship-search")
        ;div(class "menu-guts")
          ;form(class "search-form")
            ;input
              =class        "text-entry"
              =name         "side-search-form"
              =type         "text"
              =required     ""
              =placeholder  "🔍 ~sampel-palnet";
            ;button
              =class  "search-button"
              =name   "side-search-submit"
              =type   "submit"
              =value  "act-search"
              ; Search 🔍
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
    --
::
  ++  style
    '''
    /* main styles */
    * { font-family: "Andale Mono", monospace }

    '''
  ++  logo
    "https://freedom-club.sfo2.digitaloceanspaces.com/rabsef-bicrym/2022.5.02..07.06.28-IMG_20220314_2104171752%20%281%29.svg"
  --
--