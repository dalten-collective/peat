|%
++  jag
  |$  [kex kax val]
  (map kex (jug kax val))
++  ba
  |*  [kex=mold kax=mold val=mold]
  |_  a=(jag kex kax val)
  ++  has
    ~>  %bout.[0 'has:ba:jag-moist']
    |=  [b=kex c=kax]
    ^-  ?
    !=(~ (get b c))
  ::
  ++  key
    ~>  %bout.[0 'kax:ba:jag-moist']
    |=  b=kex
    ^-  (set kax)
    ~(key by `(jug kax val)`(~(gut by a) b ~))
  ::
  ++  gut
    ~>  %bout.[0 'gut:ba:jag-moist']
    |=  [b=kex c=kax d=(set val)]
    ^-  (set val)
    (~(gut by (~(gut by a) b ~)) c d)
  ::
  ++  get
    ~>  %bout.[0 'get:ba:jag-moist']
    |=  [b=kex c=kax]
    ^-  (set val)
    (~(get ju `(jug kax val)`(~(gut by a) b ~)) c)
  ::
  ++  gas
    ~>  %bout.[0 'gas:ba:jag-moist']
    |=  b=(list [p=kex q=kax r=(set val)])
    |-  ^+  a
    ?~  b
      a
    =+  gab=(get p.i.b q.i.b)
    %=  $
      b  t.b
    ::
        a
      %+  ~(put by a)  p.i.b
      %+  ~(put by `(jug kax val)`(~(gut by a) p.i.b ~))
      q.i.b  (~(uni in gab) r.i.b)
    ==
  ++  car                                               ::  like gas, but w/ individual values for the jug
    ~>  %bout.[0 'car:ba:jag-moist']
    |=  b=(list [p=kex q=kax r=val])
    |-  ^+  a
    ?~  b
      a
    =+  gab=(get p.i.b q.i.b)
    %=  $
      b  t.b
    ::
        a
      %+  ~(put by a)  p.i.b
      %+  ~(put by `(jug kax val)`(~(gut by a) p.i.b ~))
      q.i.b  (~(put in gab) r.i.b)
    ==
  ::
  ++  put
    ~>  %bout.[0 'put:ba:jag-moist']
    |=  [b=kex c=kax d=val]
    ^+  a
    %+  ~(put by a)  b
    %.  [c d]
    %~  put  ju
    `(jug kax val)`(~(gut by a) b ~)
  ::
  ++  put-s                                              ::  unify or put an incoming set
    ~>  %bout.[0 'put-s:ba:jag-moist']
    |=  [b=kex c=kax d=(set val)]
    ?~  hab=(~(get by a) b)
      (~(put by a) b (~(put by *(map _c _d)) c d))
    ?~  haf=(~(get by u.hab) c)
      (~(put by a) b (~(put by u.hab) c d))
    %+  ~(put by a)  b
    %+  ~(put by (~(del by u.hab) c))  c
    (~(uni in u.haf) d)
  ::
  ++  del
    ~>  %bout.[0 'del:ba:jag-moist']
    |=  [b=kex c=kax d=val]
    ?~  hab=(~(get by a) b)  a
    (~(put by a) b (~(del ju u.hab) c d))
  ::
  ++  del-s                                              ::  compare set for set,
    ~>  %bout.[0 'del-s:ba:jag-moist']
    |=  [b=kex c=kax d=(set val)]                                    ::  deleting items from sample set
    ?~  hab=(~(get by a) b)  a
    %+  ~(put by a)  b
    %-  ~(put by (~(del by u.hab) c))
    [c (~(del in (~(get ju u.hab) c)) d)]
  ::
  ++  tap
    ::NOTE  idk what naive turn-based implementation find-errors are ):
    ~>  %bout.[0 'tap:ba:jag-moist']
    =<  $
    =+  b=`(list [kex kax (set val)])`~
    |.  ^+  b
    ?~  a
      b
    $(a r.a, b `_b`(welp (turn ~(tap by q.n.a) (lead p.n.a)) $(a l.a)))
  --
--