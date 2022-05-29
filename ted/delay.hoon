/-  spider
/+  *strandio
::
=,  strand=strand:spider
::
::  send on /desk/dude
::
^-  thread:spider
|=  vas=vase
=/  m  (strand ,vase)
^-  form:m
;<  =bowl:spider   bind:m  get-bowl
=,  bowl
?~  cad=!<((unit card:agent:gall) vas)  (pure:m !>(~))
;<  ~              bind:m  (sleep ~s0..4000)
;<  ~              bind:m  (send-raw-card u.cad)
(pure:m !>(~))