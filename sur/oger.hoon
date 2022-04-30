::
::  oger sur file
::
/-  store=graph-store
::
|%
::
++  resource  resource:store
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
          wer=term                                       ::  - where to make it (just the name you want locally)
      ==
  ==
::
--