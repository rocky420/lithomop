       program testacc
       implicit none
       real*8 g1,g2,g3,g4,g5,w1,w2,w3,w4
       real*8 gv1,gv2,gv3,gv4
       data gv1,gv2,gv3,gv4/7.0,35.0,59.0,8.0/
       g1=7.d0*sqrt(35.d0/59.d0)/8.d0
       g2=224.0*sqrt(336633710.0/33088740423.0)/37.0
       g3=sqrt(37043.0/35.0)/56.0
       g4=-127.0/153.0
       g5=1490761.0/2842826.0
       w1=170569.0/331200.0
       w2=276710106577408.0/1075923777052725.0
       w3=12827693806929.0/30577384040000.0
       w4=10663383340655070643544192.0/4310170528879365193704375.0
       write(6,"(1pe30.22)") g1
       write(6,"(1pe30.22)") g2
       write(6,"(1pe30.22)") g3
       write(6,"(1pe30.22)") g4
       write(6,"(1pe30.22)") g5
       write(6,"(1pe30.22)") w1
       write(6,"(1pe30.22)") w2
       write(6,"(1pe30.22)") w3
       write(6,"(1pe30.22)") w4
       stop
       end
