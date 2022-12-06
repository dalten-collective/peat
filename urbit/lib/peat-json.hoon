/-  p=peat
|%
+$  flag  (pair ship term)
++  enjs
  =,  enjs:format
  |%
  ++  ships  `$-(@p json)`|=(p=@p ((lead %s) (scot %p p)))
  ::
  ++  flap
    ^-  $-(flag json)
    |=  f=flag
    ^-  json
    s/(rap 3 (scot %p p.f) '/' q.f ~)
  ++  repete
    |%
    ++  re-graph
      |=  re=re-graph:p
      ?-    -.re
          %export
        ?~  fuse.re
          (frond start-export+(flap flag.re))
        %-  pairs
        :~  start-export+(flap flag.re)
            add+(frond saved+(frond graphs+(flap flag.re)))
        ==
      ::
          %cancel
        (frond rem+(frond saved+(frond graphs+(flap flag.re))))
      ::
          %import
        ?>  ?=(^ path.re)
        =-  (frond start-import+-)
        %-  pairs
        :~  path-head+s/i.path.re
            host+?:(-.host.re (flap p.host.re) s/p.host.re)
            name+s/name.re
        ==
      ==
  ++  groups
    |%
    ++  change
      |=  chg=change:groups:p
      %+  frond  act.chg
      %+  frond  sap
      ?:  -.wat.chg
        (frond group+(flap p.wat.chg))
      %-  pairs
      :~  group+(flap p.p.wat.chg)
          resource+(flap q.p.wat.chg)
      ==
    --
  ++  known
    |%
    ++  graphs
      |=  $:  chats=(jug (unit flag) flag)
              notes=(jug (unit flag) flag)
              halls=(jug (unit flag) flag)
              dm=flag
          ==
      |^
      %+  frond  %put
      %-  pairs
      :~  chats+chats-json
          notes+notes-json
          halls+hall-json
          dms+(flap dm)
      ==
      ++  chat-json
        %+  turn  ~(tap by chats)
        |=  [p=(unit flag) q=(set flag)]
        %-  pairs
        :~  group+?~(p ~ (flap p))
            chats+a/(turn ~(tap in q) |=(r=flag (flap r)))
        ==
      ++  note-json
        %+  turn  ~(tap by notes)
        |=  [p=(unit flag) q=(set flag)]
        %-  pairs
        :~  group+?~(p ~ (flap p))
            notes+a/(turn ~(tap in q) |=(r=flag (flap r)))
        ==
      ++  hall-json
        %+  turn  ~(tap by halls)
        |=  [p=(unit flag) q=(set flag)]
        %-  pairs
        :~  group+?~(p ~ (flap p))
            halls+a/(turn ~(tap in q) |=(r=flag (flap r)))
        ==
      --
    --
  --
--