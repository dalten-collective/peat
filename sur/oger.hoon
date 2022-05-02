::
::  oger sur file
::
/-  store=graph-store, metas=metadata-store
::
^?
|%
::
++  resource   resource:store
++  md-config  md-config:metas
::
::  state
::
+$  state-1
  $:  resources=(set resource)
      permits=(set ship)
      known=(jug ship [res=resource typ=?(%chat %link %publish)])
  ==
::
::  oger's actions
::
+$  horde
  $%  ::[%printf res=resource]                             ::  printf graph depricated
      [%export res=resource]                             ::  export files
      [%permit per=(set ship)]                           ::  permit subscribers
      [%remove per=(set ship)]                           ::  remove subscribers
      [%search ser=(set ship)]                           ::  request information from ships about their resources
    ::
      $:  %import                                        ::  import files
          fol=path                                       ::  - clay path to import folder
          gro=resource                                   ::  - group in which to place new resource
          wer=term                                       ::  - new resource name - we'll make it for you
      ==
      $:  %remake                                        ::  remakes a remote or local resource
          wat=(each resource [ship resource])            ::  - which resource to remake, local or remote
          gro=resource                                   ::  - group in which to place the new resource
          wer=term                                       ::  - new resource name - we'll make it for you
      ==
  ==
::
::  oger's facts
::
+$  fritter
  $%  [%hav rez=(set [resource ?(%chat %link %publish)])]
      [%kil res=resource]
  ==
--