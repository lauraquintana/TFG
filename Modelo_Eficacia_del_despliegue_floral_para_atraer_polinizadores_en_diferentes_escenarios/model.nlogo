breed [flowers flower]
breed [bees bee]

flowers-own [
  nectar
  polen
  tiempo-relleno
visitas
   visitas1
  visitas2
tickflower
]
bees-own [
  polen
  radio-deteccion
  tiempo-marchar
  lista
lista1
  lista2
]
globals [
num_flowers_total
]
patches-own [carga]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;escenario control para el tamaño;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup_random_control
  clear-all
;;;;;;;;;;;;;;caracteristicas de mi parche;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ask patches [
  set pcolor 54
  set carga 0
  ]
  ;ask patches [set pcolor one-of [ 54 35]]

  ;;;;;;;;;;;;;;caracteristicas de mis flores;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  create-flowers num_flowers
  ask flowers [
set tickflower 0
  set tiempo-relleno 0
  set polen 1
  setxy random-xcor random-ycor
  set shape "flower"
  set color 18
  set size 2
  set nectar 1
  set visitas 0
  set visitas1 0
  set visitas2 0
  set pcolor 35
  ask neighbors[
      set pcolor 35
    ]
  ]
;;;;;;;;;;;;;;;;;caracteristicas de mis abejas;;;;;;;;;;;;;;;;;;;;;;;;;
  create-bees num_bees
  ask bees [
    set lista sentence  0 lista
              set lista remove 0 lista
  set tiempo-marchar 0
  set radio-deteccion radio_deteccion
  set polen 0
  setxy random-xcor random-ycor
  set shape "bee 2"
  set color 45
  set size 2

  ]
 ;;;;;;;;;;;;;;;;;,,poner la carga en cada parcela solo haya 2 flores y si se coloca una tercera se vaya a otro parche con carga menor a 4;;;;;;;;;;;;;;;;;;;
 ask patches with [pcolor = 35][set carga 0]
 ask flowers [
      set carga 1
 if sum [count flowers-here] of flowers-here = 2 [set carga sum [carga] of flowers-here]
  if  flowers-here != nobody[
      ask flowers-here [
      if  sum [carga] of flowers-here > 2 [                                                  ; mis 2 primeras plantas siempre se colocan en el centro de la isla
          move-to one-of neighbors with [sum [carga] of flowers-here < 2 and pcolor = 35];ponemos en uno de sus vecinos para que en todas las islas haya el mismo numero de plantas maximo como maximo en cada isla me caben 18 flores
         set carga 1
        ]

                       ]
                            ]
  ]
;show sum [carga] of flowers
  reset-ticks
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup_random
  clear-all
;;;;;;;;;;;;;;caracteristicas de mi parche;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ask patches [
  set pcolor 54
  set carga 0
  ]
  ;ask patches [set pcolor one-of [ 54 35]]

  ;;;;;;;;;;;;;;caracteristicas de mis flores;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  create-flowers num_flowers
  ask flowers [
set tickflower 0
  set tiempo-relleno 0
  set polen 1
  setxy random-xcor random-ycor
  set shape "flower"
  set color 18
  set size ((random 2) + 2)
  set nectar 1
  set visitas 0
  set visitas1 0
  set visitas2 0
  set pcolor 35
  ask neighbors[
      set pcolor 35
    ]
  ]
;;;;;;;;;;;;;;;;;caracteristicas de mis abejas;;;;;;;;;;;;;;;;;;;;;;;;;
  create-bees num_bees
  ask bees [
    set lista sentence  0 lista
              set lista remove 0 lista
  set tiempo-marchar 0
  set radio-deteccion radio_deteccion
  set polen 0
  setxy random-xcor random-ycor
  set shape "bee 2"
  set color 45
  set size 2

  ]
 ;;;;;;;;;;;;;;;;;,,poner la carga en cada parcela solo haya 2 flores y si se coloca una tercera se vaya a otro parche con carga menor a 4;;;;;;;;;;;;;;;;;;;
 ask patches with [pcolor = 35][set carga 0]
 ask flowers [
      set carga 1
 if sum [count flowers-here] of flowers-here = 2 [set carga sum [carga] of flowers-here]
  if  flowers-here != nobody[
      ask flowers-here [
      if  sum [carga] of flowers-here > 2 [                                                  ; mis 2 primeras plantas siempre se colocan en el centro de la isla
          move-to one-of neighbors with [sum [carga] of flowers-here < 2 and pcolor = 35];ponemos en uno de sus vecinos para que en todas las islas haya el mismo numero de plantas maximo como maximo en cada isla me caben 18 flores
         set carga 1
        ]

                       ]
                            ]
  ]
;show sum [carga] of flowers
  reset-ticks
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;escenario control para el tamaño;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup_homogeneo_control
  clear-all
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;caracteristicas de mi parche;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask patches [
  set pcolor 54
  ]
;;;;;;;;;;;;;;caracteristicas de mis flores;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  set num_flowers_total rows * columns * 5
  create-flowers num_flowers_total;multiplico por 4 o por el nuemro que quiera depende de las flores totales que yo quiera ( en numero me indica el numero de flores que hay por isla) (y las filas y columnas me determinan el numero de islas que hay)
;;;;;para colocar las flores de manera homogenea en mi mundo;;;;;;;;;;;;;;;;;
 let i 0
  repeat num_flowers_total ;multiplico por 4 o por el nuemro que quiera depende de las flores totales que yo quiera para colocarlas
 [ ask flower i
   [
      let x-int (world-width / columns)
      let y-int (world-height / rows)
      setxy -1 * max-pxcor + x-int / 2 + (i mod columns * x-int)
           ( max-pycor + (min-pycor / rows) )- (int (i / columns) * y-int )
    ]
    set i i + 1
  ]
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ask flowers [

set tickflower 0
  set tiempo-relleno 0
  set polen 1
  set shape "flower"
  set color 18
  set size 2
  set nectar 1
  set visitas 0
  set visitas1 0
  set visitas2 0

  set pcolor 35

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ask neighbors[
      set pcolor 35
    ]
      ;ask neighbors[set pcolor 35;;;;;;; si queremos hacer las islas mas grandes ;;;;;;;;,,;;;;;;;;
        ;set carga 0          ;pintan de marron los parches vecinos de mis flores 2 veces
       ; ask neighbors[set pcolor 35
      ;set carga 0]]; pintar de marron los parches vecinos de mis flores 3 veces

  ]
  ;;;;;;;;;;;;;;;;;,,poner la carga en cada parcela solo haya 2 flores y si se coloca una tercera se vaya a otro parche con carga menor a 4;;;;;;;;;;;;;;;;;;;
  ask patches with [pcolor = 35][set carga 0]
    ask flowers [
      set carga 1
 if sum [count flowers-here] of flowers-here = 2 [set carga sum [carga] of flowers-here]
  if  flowers-here != nobody[
      ask flowers-here [
      if  sum [carga] of flowers-here > 2 [                                                  ; mis 2 primeras plantas siempre se colocan en el centro de la isla
          move-to one-of neighbors with [sum [carga] of flowers-here < 2 and pcolor = 35];ponemos en uno de sus vecinos para que en todas las islas haya el mismo numero de plantas maximo como maximo en cada isla me caben 18 flores ;puedes poner neighbors para que haya el mismo numero de flores en cada isla o patches para que el numero de flores por isla sea aleatorio
         set carga 1
        ]

                       ]
                            ]
  ]

;show sum [carga] of flowers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;caracteristicas de mis abejas;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  create-bees num_bees
  ask bees [
    set lista sentence  0 lista
              set lista remove 0 lista
;set recordar 0
  set tiempo-marchar 0
  set radio-deteccion radio_deteccion
  set polen 0
  setxy random-xcor random-ycor
  set shape "bee 2"
  set color 45
  set size 2
  ]
  reset-ticks
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to setup_homogeneo
clear-all

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;caracteristicas de mi parche;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ask patches [
  set pcolor 54
  ]
;;;;;;;;;;;;;;caracteristicas de mis flores;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  set num_flowers_total rows * columns * 5
  create-flowers num_flowers_total;multiplico por 4 o por el numero que quiera depende de las flores totales que yo quiera ( en numero me indica el numero de flores que hay por isla) (y las filas y columnas me determinan el numero de islas que hay)
;;;;;para colocar las flores de manera homogenea en mi mundo;;;;;;;;;;;;;;;;;
 let i 0
  repeat num_flowers_total ;multiplico por 4 o por el nuemro que quiera depende de las flores totales que yo quiera para colocarlas
 [ ask flower i
   [
      let x-int (world-width / columns)
      let y-int (world-height / rows)
      setxy -1 * max-pxcor + x-int / 2 + (i mod columns * x-int)
           ( max-pycor + (min-pycor / rows) )- (int (i / columns) * y-int )
    ]
    set i i + 1
  ]
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ask flowers [

set tickflower 0
  set tiempo-relleno 0
  set polen 1
  set shape "flower"
  set color 18
  set size ((random 2) + 2)
  set nectar 1
  set visitas 0
  set visitas1 0
  set visitas2 0

  set pcolor 35

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ask neighbors[
      set pcolor 35
    ]
      ;ask neighbors[set pcolor 35;;;;;;; si queremos hacer las islas mas grandes ;;;;;;;;,,;;;;;;;;
        ;set carga 0          ;pintan de marron los parches vecinos de mis flores 2 veces
       ; ask neighbors[set pcolor 35
      ;set carga 0]]; pintar de marron los parches vecinos de mis flores 3 veces

  ]
  ;;;;;;;;;;;;;;;;;,,poner la carga en cada parcela solo haya 2 flores y si se coloca una tercera se vaya a otro parche con carga menor a 4;;;;;;;;;;;;;;;;;;;
  ask patches with [pcolor = 35][set carga 0]
    ask flowers [
      set carga 1
 if sum [count flowers-here] of flowers-here = 2 [set carga sum [carga] of flowers-here]
  if  flowers-here != nobody[
      ask flowers-here [
      if  sum [carga] of flowers-here > 2 [                                                  ; mis 2 primeras plantas siempre se colocan en el centro de la isla
          move-to one-of neighbors with [sum [carga] of flowers-here < 2 and pcolor = 35];ponemos en uno de sus vecinos para que en todas las islas haya el mismo numero de plantas maximo como maximo en cada isla me caben 18 flores ;puedes poner neighbors para que haya el mismo numero de flores en cada isla o patches para que el numero de flores por isla sea aleatorio
         set carga 1
        ]

                       ]
                            ]
  ]

;show sum [carga] of flowers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;caracteristicas de mis abejas;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  create-bees num_bees
  ask bees [
    set lista sentence  0 lista
              set lista remove 0 lista
;set recordar 0
  set tiempo-marchar 0
  set radio-deteccion radio_deteccion
  set polen 0
  setxy random-xcor random-ycor
  set shape "bee 2"
  set color 45
  set size 2
  ]
  reset-ticks
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to go_homogeneo
  tick ; 1 tick diremos que equivale a 1 min
  ask bees[

    ifelse any? flowers with [tickflower = 0] with-max[size] in-radius 1.5 [
      let flor-vecina-sin-recordar   one-of flowers with-max[size] in-radius 1.5

      move-to flor-vecina-sin-recordar
      ask flor-vecina-sin-recordar  [
        if nectar = 0 [ask bees-here [
            cogerpolen
            marchar-parchelejano]]
        if nectar = 1[ask bees-here [comerNectar]]
      ]

    ]
    [move]
;show lista
     ]
  ask flowers [if nectar = 0 [
                            set tiempo-relleno (tiempo-relleno + 1)
                            rellenarNectar
                             ]
               ]

 ask flowers [if (ticks = tickflower )[
let k num_flowers_total
    repeat num_bees
    [
      ask bee k [
      let flores-olvidar [who] of flowers with [ticks = tickflower]
      ;show flores-olvidar
      repeat sum [ count flowers with [ticks = tickflower]] of patches
      [set lista remove one-of flowers with [ticks = tickflower] lista]
    set k k + 1]
    ask flowers with [ticks = tickflower] [set tickflower 0]]]  ;se borra de la lista cuando pasan 7 ticks desde que la visito, la recuerda 7 min
  ]
  ask flowers [if (ticks / (60) = 8760 )[die]];mueren al año
end

to go_random
  tick ; 1 tick diremos que equivale a 1 min
  ask bees[

    ifelse any? flowers with [tickflower = 0] with-max[size] in-radius 1.5 [
      let flor-vecina-sin-recordar   one-of flowers with-max[size] in-radius 1.5

      move-to flor-vecina-sin-recordar
      ask flor-vecina-sin-recordar  [
        if nectar = 0 [ask bees-here [
            cogerpolen
            marchar-parchelejano]]
        if nectar = 1[ask bees-here [comerNectar]]
      ]

    ]
    [move]
;show lista ver las flores que han visitado las abejas
     ]
  ask flowers [if nectar = 0 [
                            set tiempo-relleno (tiempo-relleno + 1)
                            rellenarNectar
                             ]
               ]

 ask flowers [if (ticks = tickflower )[
let k num_flowers
    repeat num_bees
    [
      ask bee k [
      let flores-olvidar [who] of flowers with [ticks = tickflower]
      ;show flores-olvidar
      repeat sum [ count flowers with [ticks = tickflower]] of patches
      [set lista remove one-of flowers with [ticks = tickflower] lista]
    set k k + 1]
    ask flowers with [ticks = tickflower] [set tickflower 0]]]  ;se borra de la lista cuando pasan 7 ticks desde que la visito, la recuerda 7 min
  ]
  ask flowers [if (ticks / (60) = 8760 )[die]];mueren al año
end




;;;;;;;;;;;;;;;;;;lo que hacen mis abejas al dar go;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to move
;ask bees [ask patches in-radius radio-deteccion[set pcolor red]];; para ver el radio de deteccion de mi abeja
 ;;;;;;;;;;;pasos de su movimiento;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ifelse (any? other flowers in-radius radio-deteccion) ;and (any? other flowers in-radius radio-deteccion with [nectar = 1]) ; radio-deteccion en metros
       [;let flor-cerca  one-of flowers in-radius radio-deteccion ; te muestra la flor que esta mas cerca
            ; si tengo 2 paches con el mismo numero de flores que se mueva a las que tengan mayor tamaño de flor

          let flor-masflores one-of flowers  in-radius radio-deteccion with-max [(sum[count flowers-here] of neighbors + [count flowers-here] of patch-here)]   ; me dice la flor que tiene mas vecinos y mas plantas en su parche
            let flor-mastamaño one-of flowers  in-radius radio-deteccion with-max[(sum[size] of flowers-here + sum[[sum [size] of flowers-here] of neighbors] of patch-here)]   ; me dice la flor que tiene mayor suma de tamaños, suma el tamaño de mis vecinos y mis flores en el mismo parche
            ;set lista sentence  0 lista
              ;set lista remove 0 lista
            ;show flor-mastamaño
            ;show flor-masflores
          set lista1 sentence flor-mastamaño  lista1
            set lista1 remove 0 lista1
            set lista2 sentence flor-masflores lista2
            set lista2 remove 0 lista2

           ; ifelse any? other flowers with [tickflower != 0] in-radius radio-deteccion with-max [(sum[count flowers-here] of neighbors + [count flowers-here] of patch-here)][fd 10][fd 10]

            ifelse any? other flowers in-radius radio-deteccion with-max [(sum[count flowers-here] of neighbors + [count flowers-here] of patch-here)] [

                                                                                                                                                      ifelse  member? item 0 lista1 lista [fd 2]

                                                                                                                                                      [;show lista1

                                                                                                                                                        move-to item 0 lista1    ; se movera a la flor que tiene mas flores vecinas y mas flores en los marches vecinos
                                                                                                                                                        ask  item 0 lista1[

                                                                                                                                                        if  nectar = 0[
                                                                                                                                                            cogerpolen
                                                                                                                                                            marchar-parchelejano
                                                                                                                                                                ]
                                                                                                                                                        if nectar = 1 [
                                                                                                                                                            comerNectar
                                                                                                                                                                      ]
                                                                                                                                                                          ]
                                                                                                                                                      set lista1 remove-item 0 lista1

              ]
                                                                                                                                                       ]


                                                                                                                                                       [
                                                                                                                                                        ifelse  member? item 0 lista2 lista [fd 2]
                                                                                                                                                        [;show lista2

                                                                                                                                                        move-to item 0 lista2 ; se mueve a la flor mas grande dentro del parche
                                                                                                                                                        ask item 0 lista2[

                                                                                                                                                        if  nectar = 0[
                                                                                                                                                            cogerpolen
                                                                                                                                                           marchar-parchelejano
                                                                                                                                                                ]
                                                                                                                                                        if nectar = 1 [
                                                                                                                                                            comerNectar
                                                                                                                                                                      ]
                                                                                                                                                                          ]
                                                                                                                                                       set lista2 remove-item 0 lista2


                                                                                                                                                         ]
            ]

          ]
          [ fd 2   ;rt random 90 lt random 90 ;rt random 90  ; en vez de aumentar el radio quiere que la abeja se mueva
          ]





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,,;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to comerNectar
 let prey one-of flowers-here  ;prey "presa = planta a la que llega la abeja"
  if prey != nobody [
   ask prey [
      set color red
      if size = 2 [set visitas1 visitas1 + 1]
      if size = 3 [set visitas2   visitas2 + 1]
      set visitas  visitas2 + visitas1
      set nectar 0              ; se come el nectar
      set polen 0 ;coge el polen
    ]

 let predator bees-here  ;predator abeja que se posa en la flor y coge el polen (coge polen)
    ask predator[

      set polen (polen + 1)
 set lista sentence  prey lista
              set lista remove 0 lista
if member? prey lista
              [ask prey [set tickflower ticks + 7]]
  ]]



end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to cogerpolen
   let prey one-of flowers-here  ;prey "presa = planta a la que llega la abeja"
  if prey != nobody [
   ask prey [

      if size = 2 [set visitas1  visitas1 + 1]
      if size = 3 [set visitas2  visitas2 + 1]
      set visitas  visitas2 + visitas1
    set polen 0               ;coge el polen



    ]

 let predator bees-here  ;predator abeja que se posa en la flor y coge el polen (coge polen)
    ask predator[
  set polen (polen + 1)
       set lista sentence  prey lista
              set lista remove 0 lista
if member? prey lista
              [ask prey [set tickflower ticks + 7]] ;el tickflower me lo ven todas las abejas no solo donde esta la lista si una abeja quiere ir por ejemplo a la 2 no puede si esta en la lista de otra abeja
  ]
  ]

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;cuando visitan 2 flores verdes que significa que no tiene nectar se marcharn avanzan 9 pasos;;;;;;;;;;;;;;;
to marchar-parchelejano

  ask bees-here[

        set tiempo-marchar tiempo-marchar + 1
       ; show "SE MARCHA"
        ;show tiempo-marchar
        if tiempo-marchar = flores-vacias-que-la-abeja-tolera-visitar [   ; si se encuentra 2 flores vacias si se encuentra las flores que tu pongas en el boton
              ; ask bees-here[
                    fd 2 ;rt random 45;se va mas lejos si encuentra 2 flores vacias
                    ;setxy 20 10;random-xcor random-ycor ; simulamos que si se encuentran 2 veces con flores sin nectar esa abeja se va y aparece otra abeja en un lugar random manteniendo asi el numero constante de polinizadores
                    set tiempo-marchar 0

      ;]
    ]
  ]


end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,;;;;;;
;;;;;;;;;;;;;;;;;;;lo que hcane mis flores al dar a go;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
to rellenarNectar

  if tiempo-relleno  = (25 * 60) [    ; cada 24 * 60 ticks  desde que se vacia se rellena el nectar de las plantas que tienen el nectar 0, como si se reyenara cada 24 horas un tick diremos que es un minuto
        set nectar 1
        set color 18
        set tiempo-relleno 0
    ]
end
;; me dice que flores estan en mis parches vecinos ask flowers[ show [[who] of flowers-here] of neighbors]
;; me dice que flor esta en mi parche ask flowers[ show [who] of flowers-here]
;;; para saber el numero de vecinos que tiene cada flor aunq el grafico me lo muestra ask flowers [show (sum[count flowers-here] of neighbors + [count flowers-here] of patch-here)]
;;;; para saber que visitas tiene cada uno poner ask flowers [show visitas] en la consola y te da el listado de todas las flores con sus visitas correspondientes y si escribes ask flowers [show size = 2] te da el listado de flores que son pequeñas.
@#$#@#$#@
GRAPHICS-WINDOW
277
12
948
684
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-25
25
-25
25
0
0
1
ticks
30.0

BUTTON
9
291
111
324
NIL
setup_random
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
2
84
174
117
num_bees
num_bees
0
105
5.0
1
1
NIL
HORIZONTAL

SLIDER
12
328
184
361
num_flowers
num_flowers
0
1000
6.0
1
1
NIL
HORIZONTAL

BUTTON
126
289
229
322
NIL
go_random
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
960
165
1373
479
nº de flores frente al nº de visitas
visitas
flowers
0.0
100.0
0.0
20.0
true
true
"" ""
PENS
"visitas" 1.0 1 -1184463 true "" "\nhistogram [visitas] of flowers"

BUTTON
11
472
130
506
NIL
setup_homogeneo
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
12
508
184
541
rows
rows
1
10
5.0
1
1
NIL
HORIZONTAL

SLIDER
10
548
182
581
columns
columns
1
10
5.0
1
1
NIL
HORIZONTAL

MONITOR
985
65
1128
110
num_Flowes grandes
count flowers with [size = 3]
17
1
11

MONITOR
983
115
1130
160
num_flowers pequeñas
count flowers with [size = 2]
17
1
11

MONITOR
1154
115
1211
160
horas
ticks / (60)
3
1
11

PLOT
959
484
1176
654
néctar de las flores frente al tiempo
tiempo
néctar
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"nectar en las flores" 1.0 0 -16777216 true "" "plot sum [nectar] of flowers"

PLOT
1181
484
1394
654
polen que tienen las abejas frente al tiempo
tiempo
polen
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"polen" 1.0 0 -408670 true "" "plot sum[polen] of bees"

PLOT
962
664
1376
839
cantidad de flores vs el nº de vecinos que tienen
cantidad de vecinos
numero de flores
0.0
8.0
0.0
8.0
true
false
";En el eje y se muestra la cantidad de flores que tinen un numero determinado de vecinos que se refleja en el eje y" ""
PENS
"vecinos" 1.0 2 -16777216 true "\n" "\nhistogram [sum[count flowers-here] of neighbors] of flowers\n"
"pen-1" 1.0 2 -2674135 true "" ";show one-of flowers with-max [sum[count flowers-here] of neighbors] "
"pen-2" 1.0 0 -7500403 true "" ";show one-of flowers with-min [sum[count flowers-here] of neighbors] "

PLOT
2065
609
2679
795
nº de vecinos por flor 
flor j
num vecinos
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -1069655 true " let j 0\n repeat num_flowers_total [\n ask flower j[\n   plot sum [count flowers-here] of neighbors\n  ]\n  set j j + 1\n  ]\n  " " "

PLOT
2062
41
2676
350
cuenta las flores que hay en mi mismo parche y en parches vecinos con respecto a cada flor 
flor j
num_flores
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 2 -16777216 true "\nlet j 0\n repeat num_flowers_total [\n ask flower j[\n   plot (sum[count flowers-here] of neighbors + [count flowers-here] of patch-here)\n  ]\n  set j j + 1\n  ]\n  " ""

MONITOR
10
587
218
632
num_flowers_total_homogeneo
count flowers with [size = 3] + count flowers with [size = 2]
17
1
11

PLOT
2063
357
2680
605
suma los tamaños de las flores en cada parche 
flower j
sum de tamaños
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"suma los tamaños de mi pache aqui" 1.0 2 -16777216 true " let j 0\n repeat num_flowers_total [\n ask flower j[\n   plot sum[size] of flowers-here\n  ;show sum[size] of flowers-here\n  ]\n  set j j + 1\n  ]\n \n" ""
"suma los tamaños de los vecinos" 1.0 2 -7500403 true " let j 0\n repeat num_flowers_total [\n ask flower j[\n   plot sum[[sum [size] of flowers-here] of neighbors] of patch-here\n ;show sum[[sum [size] of flowers-here] of neighbors] of patch-here \n \n  ]\n  set j j + 1\n  ]\n \n\n " ""
"suma de tamaños de mis vecinos + el parche aqui" 1.0 0 -2674135 true "\n let j 0\n repeat num_flowers_total [\n ask flower j[\n  plot (sum[size] of flowers-here + sum[[sum [size] of flowers-here] of neighbors] of patch-here) \n  ]\n  set j j + 1\n  ]\n \n\n " ""

SLIDER
2
120
174
153
radio_deteccion
radio_deteccion
0
15
5.0
1
1
NIL
HORIZONTAL

SLIDER
0
160
265
193
flores-vacias-que-la-abeja-tolera-visitar
flores-vacias-que-la-abeja-tolera-visitar
0
10
2.0
1
1
NIL
HORIZONTAL

MONITOR
1153
65
1390
110
num_flowers_rojas_visitadas_fecundadas
count flowers with [color = red]
17
1
11

PLOT
1408
39
2019
346
cuenta las flores que hay en mi mismo parche y en parches vecinos con respecto a cada flor random
flor j
num_flores_random
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 2 -16777216 true "let t 0\n repeat num_flowers [\n ask flower t[\n   plot (sum[count flowers-here] of neighbors + [count flowers-here] of patch-here)\n  ]\n  set t t + 1\n  ]\n  " ""

PLOT
1406
355
2023
603
suma los tamaños de las flores en cada parche random
flower j
sum de tamaño
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"suma los tamaños de mi parche aqui" 1.0 2 -16777216 true "let j 0\n repeat num_flowers [\n ask flower j[\n   plot sum[size] of flowers-here\n  ;show sum[size] of flowers-here\n  ]\n  set j j + 1\n  ]\n \n" ""
"suma los tamaños de los vecinos" 1.0 2 -7500403 true "let j 0\n repeat num_flowers [\n ask flower j[\n   plot sum[[sum [size] of flowers-here] of neighbors] of patch-here\n ;show sum[[sum [size] of flowers-here] of neighbors] of patch-here \n \n  ]\n  set j j + 1\n  ]\n \n\n " ""
"suma los tamaños de mis vecinos + el parche aqui" 1.0 0 -2674135 true "let j 0\n repeat num_flowers [\n ask flower j[\n  plot (sum[size] of flowers-here + sum[[sum [size] of flowers-here] of neighbors] of patch-here) \n  ]\n  set j j + 1\n  ]\n \n\n " ""

PLOT
1406
609
2025
796
nº de vecinos por flor random
flor j
num vecinos
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "let j 0\n repeat num_flowers [\n ask flower j[\n   plot sum [count flowers-here] of neighbors\n  ]\n  set j j + 1\n  ]\n  " ""

MONITOR
13
368
167
413
num_flower_total_random
num_flowers
17
1
11

TEXTBOX
1411
12
1877
43
Datos obtenidos en el escenario random
20
0.0
1

TEXTBOX
2066
14
2611
49
Datos obtenidos en el escenario homogéneo
20
0.0
1

BUTTON
138
472
266
505
NIL
go_homogeneo
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
3
17
289
67
Determina las características de los polinizadores
20
0.0
1

TEXTBOX
3
204
298
254
Elige el tipo de escenario
20
0.0
1

TEXTBOX
977
10
1352
60
Datos a tener en cuenta en los 2 tipos de escenarios
20
0.0
1

TEXTBOX
8
231
158
251
Escenario Random
16
32.0
1

TEXTBOX
11
417
211
444
Escenario Homogéneo
16
32.0
1

BUTTON
9
252
182
285
NIL
setup_random_control
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
11
437
209
470
NIL
setup_homogeneo_control
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
##  ¿Qué es?

Este modelo intenta simular el comportamiento de una especie de planta y su polinizador, para comprobar cómo es de eficaz el despliegue floral en plantas para atraer polinizadores en diferentes escenarios donde las flores se dispersan de forma aleatoria y homogénea por el espacio.


##  Cómo funciona
En este modelo tenemos 2 tipos de agentes, una especie vegetal que hemos llamado flower y un animal polinizador que hemos llamado bee.

Las características de las flowers: 

* Son flores anuales (365 días).

* Polinizadas únicamente por animales.
 
* Son autoincompatibles.

* Hay dos fenotipos en la población, plantas con flores más grandes y con flores más pequeñas.(Menos en los escenarios control donde solo hay un fenotipo, plantas pequeñas)

* Tienen las variables néctar y polen para atraer a los polinizadores.

* Las flores se rellenan de néctar cuando han pasado 24 horas desde que se vaciaron.

Características de las bees, se simuló el comportamiento del abejorro, polinizador por excelencia:

* Posee un radio de detección en el que observa las plantas que tiene a su alrededor.

* Cuando llega a la flor, come néctar y coge polen.

* Visita flores que no recuerda, recuerda las flores que visita durante 7 minutos, aunque si hay dos flores en el mismo lugar se puede equivocar y visitar la flor que ya había visitado.

* Solo tolera visitar un número determinado de flores sin néctar, luego seguirá con su vuelo

* Visitará la flor en primer lugar que este rodeada de más flores, sí hay 2 flores rodeadas del mismo número de flores se moverá al parche que tenga mayor número de flores con mayor tamaño acumulado. Después visitará las flores vecinas de mayor tamaño, ya que le compensará el viaje. 


## Cómo se usa
Pasos a seguir antes de iniciar el modelo:

-Elegir que tipo de escenario quieres: 

* setup_random: donde las plantas con dos fenotipos se colocan de manera aleatoria por el mundo.

* setup_homogeneo: donde las plantas con dos fenotipos se distribuyen en  parcher colocados de forma homogénea.

* setup_random_control: donde las plantas con un fenotipo se colocan de manera aleatoria por el mundo.

* setup_homogeneo_control: donde las plantas con un fenotipo se distribuyen en  parches colocados de forma homogénea.

-En el escenario homogéneo tenemos que decidir en cuantas filas y columnas dividir los parches en el mundo.

-Elegir la cantidad de polinizadores.

-Elegir la cantidad de flores que tenemos inicialmente, su tamaño se seleccionará de manera aleatoria en los escenarios no control.  

-En los monitores de la izquierda podemos obtener diferentes datos:

* num_Flowers grandes: donde se muestra el número de flores de mayor tamaño.

* num_flowers pequeñas: donde se muestra el número de flores de menor tamaño.

* horas: indica el tiempo que ha transcurrido desde que se inicio el modelo hasta que se para, cada tick representa 1 min.

* num_flowers_total: indica el número total de flores que hay en el mundo.

* num_flowers_rojas_visitadas_fecundadas: indica el número de flores que han visitado.

-En los deslizadores de mi izquierda se puede elegir una serie de datos:

* radio_deteccion: se puede elegir el radio de observación en el que el polinizador puede visualizar las plantas.

* flores-vacias-que-la-abeja-tolera-visitar: se puede seleccionar el número de flores sin néctar que la abeja tolera visitar antes de continuar con su vuelo y busque néctar en otras plantas más alejadas.

-En los gráficos de mi derecha obtengo los siguientes datos para cada tipo de escenario:

* número de flores frente al número de visitas: es un grafico donde el eje x representa las visitas por tiempo y el eje y representa el número de flores. Es un histograma donde se ve cuanta cantidad de flores han recibido una cantidad determinada de visitas en un tiempo dado. 

* néctar de las flores frente al tiempo: en el eje x se representa el tiempo, y en el eje y la cantidad de néctar total que se va consumiendo en el mundo y como se va rellenando.

* polen que tienen las abejas frente al tiempo: el eje x representa el tiempo, el eje y representa el polen que cogen las abejas según pasa el tiempo.

* cantidad de flores vs el número de vecinos que tienen: el eje x representa el número de vecinos, y el eje y representa la cantidad de flores que tienen esos vecinos.

* Cuenta las flores que hay en mi mismo parche y en parches vecinos con respecto a cada flor: es un histograma donde el eje x representa el número de flor, y el eje y muestra el número de flores que hay en un parche y en los parches vecinos.

* Suma los tamaños de las flores en cada parche: en el eje x se representa el número de flor , y el eje y representa la suma de los tamaños. Tenemos 3 representaciones en este grafico una de color negro que muestra la suma de tamaños de las flores que están en un mismo parche, el color gris muestra la suma de tamaños de las flores vecinas con respecto a una flor y el color rojo representa la suma de tamaños de las flores que hay en un mismo parche y las flores vecinas.

* número de vecinos por flor: es un histograma donde el eje x representa cada flor del mundo y el eje y representa la cantidad de vecinos que tiene esa flor.

Cuando se seleccionen todos los parámetros y se entienda lo que significa cada monitor y gráficos se dará al botón go_random o go_homogeneo para iniciar el modelo.

## Cosas a tener en cuenta

Cuando ya tienes seleccionados todos los parámetros e inicies el modelo, los únicos gráficos que cambian son el de número de flores frente al número de visitas, néctar de las flores frente al tiempo y polen que tienen las abejas frente al tiempo. Ya que varian respecto al tiempo, el resto de gráficos nos proporcionan datos para obtener los parámetros del mundo en las condiciones iniciales que vamos a suponer constantes, ya que el número de flores no variaría porque en la recogida de datos el tiempo que tomamos es pequeño como para que las plantas inicien la reproducción, generando nuevas plantas o mueran.

Otra cosa importante es que veremos que el polen no tiene límite, suponemos que la cantidad de polen en las plantas es infinita. Esta característica se podría utilizar para mejoras del modelo ya que se podría suponer que obtendrían el mayor número de descendientes, ya que las abejas siempre cogen polen y las flores siempre lo fabrican. 


## Cosas que probar

Te sugiero que selecciones las mismas variables para todos los escenarios y veas cómo cambia el número de visitas en función del tipo de escenario, si hay diferencias o si no.

Sería interesante cambiar el número de polinizadores en un mismo escenario y ver cómo varían las visitas

Te propongo que cambies la cantidad de parches en el escenario homogéneo y veas cómo afecta en las visitas, y si las visitas las realiza en menor o mayor tiempo.

Te recomiendo que juegues con el radio-deteccion y veas si a mayor radio eligen las flores más grandes o no afecta en su elección.



## Ampliar el modelo

Nuestro siguiente paso sería el de ver que fenotipo sería el que se mantiene en la población después de un tiempo, es decir que las plantas realizarán la reproducción cuando una abeja llegue a ellas con polen, dejarían el polen que trajeran en la flor a la que llegan y cogerían su polen, tendiendo en cuenta que si el polen que llega es de una flor del mismo tamaño que ella toda su descendencia tendría su mismo tamaño, si el polen que llegara a la flor fuera de otra flor de tamaño diferente, habría variedad en su descendencia dependiendo de si existiera dominancia o codominancia para ese caracter.

Siempre teniendo en cuenta que el polen que llevan las abejas sería el de las flores que más visitan, por tanto, tienen un gran papel en la selección del fenotipo.



## Modelos relacionados

	Modelos relacionados con este modelo y con su posible ampliación:

* Plant Speciation
* Plant Hybridation
* Simple Birth Rates
* Divide the Cake
* Bug Hunt Speeds
* Altruism
* Cooperation
* vision evolution
* Simple Genetic Algorithm


## Créditos y referencias

	Tutoriales que me han ayudado a entender el programa netlogo:
	
Canal de youtube del instituto de Santa Fe Complexity Explorer, en concreto los apartados de Fundamentals of Netlogo y Agent-Based Modeling

	Modelos que me han ayudado con el código:

* Sunflower Biomorphs
* Rabbits Grass Weeds
* Wolf Sheep Predation
* https://beehave-model.net/ : BEESCOUT_Model y BEEHAVE_Model
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bee 2
true
0
Polygon -1184463 true false 195 150 105 150 90 165 90 225 105 270 135 300 165 300 195 270 210 225 210 165 195 150
Rectangle -16777216 true false 90 165 212 185
Polygon -16777216 true false 90 207 90 226 210 226 210 207
Polygon -16777216 true false 103 266 198 266 203 246 96 246
Polygon -6459832 true false 120 150 105 135 105 75 120 60 180 60 195 75 195 135 180 150
Polygon -6459832 true false 150 15 120 30 120 60 180 60 180 30
Circle -16777216 true false 105 30 30
Circle -16777216 true false 165 30 30
Polygon -7500403 true true 120 90 75 105 15 90 30 75 120 75
Polygon -16777216 false false 120 75 30 75 15 90 75 105 120 90
Polygon -7500403 true true 180 75 180 90 225 105 285 90 270 75
Polygon -16777216 false false 180 75 270 75 285 90 225 105 180 90
Polygon -7500403 true true 180 75 180 90 195 105 240 195 270 210 285 210 285 150 255 105
Polygon -16777216 false false 180 75 255 105 285 150 285 210 270 210 240 195 195 105 180 90
Polygon -7500403 true true 120 75 45 105 15 150 15 210 30 210 60 195 105 105 120 90
Polygon -16777216 false false 120 75 45 105 15 150 15 210 30 210 60 195 105 105 120 90
Polygon -16777216 true false 135 300 165 300 180 285 120 285

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="2" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>sort-on [who] flowers with [size = 2]</metric>
    <enumeratedValueSet variable="radio_deteccion">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_flowers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rows">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_bees">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment2" repetitions="2" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>[visitas] of flower 0</metric>
    <metric>[visitas] of flower 1</metric>
    <metric>[visitas] of flower 2</metric>
    <metric>[visitas] of flower 3</metric>
    <metric>[visitas] of flower 4</metric>
    <metric>[visitas] of flower 5</metric>
    <metric>[visitas] of flower 6</metric>
    <metric>[visitas] of flower 7</metric>
    <metric>[visitas] of flower 8</metric>
    <metric>[visitas] of flower 9</metric>
    <enumeratedValueSet variable="radio_deteccion">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_flowers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rows">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_bees">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment3" repetitions="2" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>[flowers-here] of flowers</metric>
    <enumeratedValueSet variable="radio_deteccion">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_flowers">
      <value value="9"/>
      <value value="1"/>
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rows">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_bees">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment4" repetitions="2" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>[[[who] of flowers-here] of neighbors] of flower 1</metric>
    <enumeratedValueSet variable="radio_deteccion">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_flowers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rows">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_bees">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment5" repetitions="1" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>[size] of flowers</metric>
    <enumeratedValueSet variable="radio_deteccion">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_flowers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rows">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_bees">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment 6" repetitions="20" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>sort-on [who] flowers with [size = 2]</metric>
    <metric>[visitas] of flower 0</metric>
    <metric>[visitas] of flower 1</metric>
    <metric>[visitas] of flower 2</metric>
    <metric>[visitas] of flower 3</metric>
    <metric>[visitas] of flower 4</metric>
    <metric>[visitas] of flower 5</metric>
    <metric>[visitas] of flower 6</metric>
    <metric>[visitas] of flower 7</metric>
    <metric>[visitas] of flower 8</metric>
    <metric>[visitas] of flower 9</metric>
    <metric>[flowers-here] of flowers</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 0</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 1</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 2</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 3</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 4</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 5</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 6</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 7</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 8</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 9</metric>
    <metric>[size] of flower 0</metric>
    <metric>[size] of flower 1</metric>
    <metric>[size] of flower 2</metric>
    <metric>[size] of flower 3</metric>
    <metric>[size] of flower 4</metric>
    <metric>[size] of flower 5</metric>
    <metric>[size] of flower 6</metric>
    <metric>[size] of flower 7</metric>
    <metric>[size] of flower 8</metric>
    <metric>[size] of flower 9</metric>
    <enumeratedValueSet variable="radio_deteccion">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_flowers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rows">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_bees">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment7" repetitions="1" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>sum[size] of [flowers-here] of flower 1</metric>
    <metric>count [flowers-here] of flower 1</metric>
    <metric>[flowers-here] of flower 1</metric>
    <enumeratedValueSet variable="radio_deteccion">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_flowers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rows">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_bees">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment8" repetitions="1" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>;sum[size] of [[flowers-here] of neighbors]] of flower 1</metric>
    <metric>;count [flowers-here] of flower 1</metric>
    <metric>count[flowers-here] of [[flower-here] of neighbors] of flower 1</metric>
    <enumeratedValueSet variable="radio_deteccion">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_flowers">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="rows">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num_bees">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment hipotesis tamaño control random" repetitions="10" runMetricsEveryStep="true">
    <setup>setup_random_control</setup>
    <go>go_random</go>
    <timeLimit steps="120"/>
    <metric>[flowers-here] of flowers</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 0</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 1</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 2</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 3</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 4</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 5</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 6</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 7</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 8</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 9</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 10</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 11</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 12</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 13</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 14</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 15</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 16</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 17</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 18</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 19</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 20</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 21</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 22</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 23</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 24</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 25</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 26</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 27</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 28</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 29</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 30</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 31</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 32</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 33</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 34</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 35</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 36</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 37</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 38</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 39</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 40</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 41</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 42</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 43</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 44</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 45</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 46</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 47</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 48</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 49</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 50</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 51</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 52</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 53</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 54</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 55</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 56</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 57</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 58</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 59</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 60</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 61</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 62</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 63</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 64</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 65</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 66</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 67</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 68</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 69</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 70</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 71</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 72</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 73</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 74</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 75</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 76</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 77</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 78</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 79</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 80</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 81</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 82</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 83</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 84</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 85</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 86</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 87</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 88</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 89</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 90</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 91</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 92</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 93</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 94</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 95</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 96</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 97</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 98</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 99</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 100</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 101</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 102</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 103</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 104</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 105</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 106</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 107</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 108</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 109</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 110</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 111</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 112</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 113</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 114</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 115</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 116</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 117</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 118</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 119</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 120</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 121</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 122</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 123</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 124</metric>
    <metric>[visitas] of flower 0</metric>
    <metric>[visitas] of flower 1</metric>
    <metric>[visitas] of flower 2</metric>
    <metric>[visitas] of flower 3</metric>
    <metric>[visitas] of flower 4</metric>
    <metric>[visitas] of flower 5</metric>
    <metric>[visitas] of flower 6</metric>
    <metric>[visitas] of flower 7</metric>
    <metric>[visitas] of flower 8</metric>
    <metric>[visitas] of flower 9</metric>
    <metric>[visitas] of flower 10</metric>
    <metric>[visitas] of flower 11</metric>
    <metric>[visitas] of flower 12</metric>
    <metric>[visitas] of flower 13</metric>
    <metric>[visitas] of flower 14</metric>
    <metric>[visitas] of flower 15</metric>
    <metric>[visitas] of flower 16</metric>
    <metric>[visitas] of flower 17</metric>
    <metric>[visitas] of flower 18</metric>
    <metric>[visitas] of flower 19</metric>
    <metric>[visitas] of flower 20</metric>
    <metric>[visitas] of flower 21</metric>
    <metric>[visitas] of flower 22</metric>
    <metric>[visitas] of flower 23</metric>
    <metric>[visitas] of flower 24</metric>
    <metric>[visitas] of flower 25</metric>
    <metric>[visitas] of flower 26</metric>
    <metric>[visitas] of flower 27</metric>
    <metric>[visitas] of flower 28</metric>
    <metric>[visitas] of flower 29</metric>
    <metric>[visitas] of flower 30</metric>
    <metric>[visitas] of flower 31</metric>
    <metric>[visitas] of flower 32</metric>
    <metric>[visitas] of flower 33</metric>
    <metric>[visitas] of flower 34</metric>
    <metric>[visitas] of flower 35</metric>
    <metric>[visitas] of flower 36</metric>
    <metric>[visitas] of flower 37</metric>
    <metric>[visitas] of flower 38</metric>
    <metric>[visitas] of flower 39</metric>
    <metric>[visitas] of flower 40</metric>
    <metric>[visitas] of flower 41</metric>
    <metric>[visitas] of flower 42</metric>
    <metric>[visitas] of flower 43</metric>
    <metric>[visitas] of flower 44</metric>
    <metric>[visitas] of flower 45</metric>
    <metric>[visitas] of flower 46</metric>
    <metric>[visitas] of flower 47</metric>
    <metric>[visitas] of flower 48</metric>
    <metric>[visitas] of flower 49</metric>
    <metric>[visitas] of flower 50</metric>
    <metric>[visitas] of flower 51</metric>
    <metric>[visitas] of flower 52</metric>
    <metric>[visitas] of flower 53</metric>
    <metric>[visitas] of flower 54</metric>
    <metric>[visitas] of flower 55</metric>
    <metric>[visitas] of flower 56</metric>
    <metric>[visitas] of flower 57</metric>
    <metric>[visitas] of flower 58</metric>
    <metric>[visitas] of flower 59</metric>
    <metric>[visitas] of flower 60</metric>
    <metric>[visitas] of flower 61</metric>
    <metric>[visitas] of flower 62</metric>
    <metric>[visitas] of flower 63</metric>
    <metric>[visitas] of flower 64</metric>
    <metric>[visitas] of flower 65</metric>
    <metric>[visitas] of flower 66</metric>
    <metric>[visitas] of flower 67</metric>
    <metric>[visitas] of flower 68</metric>
    <metric>[visitas] of flower 69</metric>
    <metric>[visitas] of flower 70</metric>
    <metric>[visitas] of flower 71</metric>
    <metric>[visitas] of flower 72</metric>
    <metric>[visitas] of flower 73</metric>
    <metric>[visitas] of flower 74</metric>
    <metric>[visitas] of flower 75</metric>
    <metric>[visitas] of flower 76</metric>
    <metric>[visitas] of flower 77</metric>
    <metric>[visitas] of flower 78</metric>
    <metric>[visitas] of flower 79</metric>
    <metric>[visitas] of flower 80</metric>
    <metric>[visitas] of flower 81</metric>
    <metric>[visitas] of flower 82</metric>
    <metric>[visitas] of flower 83</metric>
    <metric>[visitas] of flower 84</metric>
    <metric>[visitas] of flower 85</metric>
    <metric>[visitas] of flower 86</metric>
    <metric>[visitas] of flower 87</metric>
    <metric>[visitas] of flower 88</metric>
    <metric>[visitas] of flower 89</metric>
    <metric>[visitas] of flower 90</metric>
    <metric>[visitas] of flower 91</metric>
    <metric>[visitas] of flower 92</metric>
    <metric>[visitas] of flower 93</metric>
    <metric>[visitas] of flower 94</metric>
    <metric>[visitas] of flower 95</metric>
    <metric>[visitas] of flower 96</metric>
    <metric>[visitas] of flower 97</metric>
    <metric>[visitas] of flower 98</metric>
    <metric>[visitas] of flower 99</metric>
    <metric>[visitas] of flower 100</metric>
    <metric>[visitas] of flower 101</metric>
    <metric>[visitas] of flower 102</metric>
    <metric>[visitas] of flower 103</metric>
    <metric>[visitas] of flower 104</metric>
    <metric>[visitas] of flower 105</metric>
    <metric>[visitas] of flower 106</metric>
    <metric>[visitas] of flower 107</metric>
    <metric>[visitas] of flower 108</metric>
    <metric>[visitas] of flower 109</metric>
    <metric>[visitas] of flower 110</metric>
    <metric>[visitas] of flower 111</metric>
    <metric>[visitas] of flower 112</metric>
    <metric>[visitas] of flower 113</metric>
    <metric>[visitas] of flower 114</metric>
    <metric>[visitas] of flower 115</metric>
    <metric>[visitas] of flower 116</metric>
    <metric>[visitas] of flower 117</metric>
    <metric>[visitas] of flower 118</metric>
    <metric>[visitas] of flower 119</metric>
    <metric>[visitas] of flower 120</metric>
    <metric>[visitas] of flower 121</metric>
    <metric>[visitas] of flower 122</metric>
    <metric>[visitas] of flower 123</metric>
    <metric>[visitas] of flower 124</metric>
    <steppedValueSet variable="radio_deteccion" first="5" step="10" last="15"/>
    <enumeratedValueSet variable="num_flowers">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="2"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_bees" first="5" step="20" last="105"/>
  </experiment>
  <experiment name="experiment hipotesis tamaño random" repetitions="4" runMetricsEveryStep="true">
    <setup>setup_random</setup>
    <go>go_random</go>
    <timeLimit steps="120"/>
    <metric>[flowers-here] of flowers</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 0</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 1</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 2</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 3</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 4</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 5</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 6</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 7</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 8</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 9</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 10</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 11</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 12</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 13</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 14</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 15</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 16</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 17</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 18</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 19</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 20</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 21</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 22</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 23</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 24</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 25</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 26</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 27</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 28</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 29</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 30</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 31</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 32</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 33</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 34</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 35</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 36</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 37</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 38</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 39</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 40</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 41</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 42</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 43</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 44</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 45</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 46</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 47</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 48</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 49</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 50</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 51</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 52</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 53</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 54</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 55</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 56</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 57</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 58</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 59</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 60</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 61</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 62</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 63</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 64</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 65</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 66</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 67</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 68</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 69</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 70</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 71</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 72</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 73</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 74</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 75</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 76</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 77</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 78</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 79</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 80</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 81</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 82</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 83</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 84</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 85</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 86</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 87</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 88</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 89</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 90</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 91</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 92</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 93</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 94</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 95</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 96</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 97</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 98</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 99</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 100</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 101</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 102</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 103</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 104</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 105</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 106</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 107</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 108</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 109</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 110</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 111</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 112</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 113</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 114</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 115</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 116</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 117</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 118</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 119</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 120</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 121</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 122</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 123</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 124</metric>
    <metric>[visitas] of flower 0</metric>
    <metric>[visitas] of flower 1</metric>
    <metric>[visitas] of flower 2</metric>
    <metric>[visitas] of flower 3</metric>
    <metric>[visitas] of flower 4</metric>
    <metric>[visitas] of flower 5</metric>
    <metric>[visitas] of flower 6</metric>
    <metric>[visitas] of flower 7</metric>
    <metric>[visitas] of flower 8</metric>
    <metric>[visitas] of flower 9</metric>
    <metric>[visitas] of flower 10</metric>
    <metric>[visitas] of flower 11</metric>
    <metric>[visitas] of flower 12</metric>
    <metric>[visitas] of flower 13</metric>
    <metric>[visitas] of flower 14</metric>
    <metric>[visitas] of flower 15</metric>
    <metric>[visitas] of flower 16</metric>
    <metric>[visitas] of flower 17</metric>
    <metric>[visitas] of flower 18</metric>
    <metric>[visitas] of flower 19</metric>
    <metric>[visitas] of flower 20</metric>
    <metric>[visitas] of flower 21</metric>
    <metric>[visitas] of flower 22</metric>
    <metric>[visitas] of flower 23</metric>
    <metric>[visitas] of flower 24</metric>
    <metric>[visitas] of flower 25</metric>
    <metric>[visitas] of flower 26</metric>
    <metric>[visitas] of flower 27</metric>
    <metric>[visitas] of flower 28</metric>
    <metric>[visitas] of flower 29</metric>
    <metric>[visitas] of flower 30</metric>
    <metric>[visitas] of flower 31</metric>
    <metric>[visitas] of flower 32</metric>
    <metric>[visitas] of flower 33</metric>
    <metric>[visitas] of flower 34</metric>
    <metric>[visitas] of flower 35</metric>
    <metric>[visitas] of flower 36</metric>
    <metric>[visitas] of flower 37</metric>
    <metric>[visitas] of flower 38</metric>
    <metric>[visitas] of flower 39</metric>
    <metric>[visitas] of flower 40</metric>
    <metric>[visitas] of flower 41</metric>
    <metric>[visitas] of flower 42</metric>
    <metric>[visitas] of flower 43</metric>
    <metric>[visitas] of flower 44</metric>
    <metric>[visitas] of flower 45</metric>
    <metric>[visitas] of flower 46</metric>
    <metric>[visitas] of flower 47</metric>
    <metric>[visitas] of flower 48</metric>
    <metric>[visitas] of flower 49</metric>
    <metric>[visitas] of flower 50</metric>
    <metric>[visitas] of flower 51</metric>
    <metric>[visitas] of flower 52</metric>
    <metric>[visitas] of flower 53</metric>
    <metric>[visitas] of flower 54</metric>
    <metric>[visitas] of flower 55</metric>
    <metric>[visitas] of flower 56</metric>
    <metric>[visitas] of flower 57</metric>
    <metric>[visitas] of flower 58</metric>
    <metric>[visitas] of flower 59</metric>
    <metric>[visitas] of flower 60</metric>
    <metric>[visitas] of flower 61</metric>
    <metric>[visitas] of flower 62</metric>
    <metric>[visitas] of flower 63</metric>
    <metric>[visitas] of flower 64</metric>
    <metric>[visitas] of flower 65</metric>
    <metric>[visitas] of flower 66</metric>
    <metric>[visitas] of flower 67</metric>
    <metric>[visitas] of flower 68</metric>
    <metric>[visitas] of flower 69</metric>
    <metric>[visitas] of flower 70</metric>
    <metric>[visitas] of flower 71</metric>
    <metric>[visitas] of flower 72</metric>
    <metric>[visitas] of flower 73</metric>
    <metric>[visitas] of flower 74</metric>
    <metric>[visitas] of flower 75</metric>
    <metric>[visitas] of flower 76</metric>
    <metric>[visitas] of flower 77</metric>
    <metric>[visitas] of flower 78</metric>
    <metric>[visitas] of flower 79</metric>
    <metric>[visitas] of flower 80</metric>
    <metric>[visitas] of flower 81</metric>
    <metric>[visitas] of flower 82</metric>
    <metric>[visitas] of flower 83</metric>
    <metric>[visitas] of flower 84</metric>
    <metric>[visitas] of flower 85</metric>
    <metric>[visitas] of flower 86</metric>
    <metric>[visitas] of flower 87</metric>
    <metric>[visitas] of flower 88</metric>
    <metric>[visitas] of flower 89</metric>
    <metric>[visitas] of flower 90</metric>
    <metric>[visitas] of flower 91</metric>
    <metric>[visitas] of flower 92</metric>
    <metric>[visitas] of flower 93</metric>
    <metric>[visitas] of flower 94</metric>
    <metric>[visitas] of flower 95</metric>
    <metric>[visitas] of flower 96</metric>
    <metric>[visitas] of flower 97</metric>
    <metric>[visitas] of flower 98</metric>
    <metric>[visitas] of flower 99</metric>
    <metric>[visitas] of flower 100</metric>
    <metric>[visitas] of flower 101</metric>
    <metric>[visitas] of flower 102</metric>
    <metric>[visitas] of flower 103</metric>
    <metric>[visitas] of flower 104</metric>
    <metric>[visitas] of flower 105</metric>
    <metric>[visitas] of flower 106</metric>
    <metric>[visitas] of flower 107</metric>
    <metric>[visitas] of flower 108</metric>
    <metric>[visitas] of flower 109</metric>
    <metric>[visitas] of flower 110</metric>
    <metric>[visitas] of flower 111</metric>
    <metric>[visitas] of flower 112</metric>
    <metric>[visitas] of flower 113</metric>
    <metric>[visitas] of flower 114</metric>
    <metric>[visitas] of flower 115</metric>
    <metric>[visitas] of flower 116</metric>
    <metric>[visitas] of flower 117</metric>
    <metric>[visitas] of flower 118</metric>
    <metric>[visitas] of flower 119</metric>
    <metric>[visitas] of flower 120</metric>
    <metric>[visitas] of flower 121</metric>
    <metric>[visitas] of flower 122</metric>
    <metric>[visitas] of flower 123</metric>
    <metric>[visitas] of flower 124</metric>
    <metric>[size] of flower 0</metric>
    <metric>[size] of flower 1</metric>
    <metric>[size] of flower 2</metric>
    <metric>[size] of flower 3</metric>
    <metric>[size] of flower 4</metric>
    <metric>[size] of flower 5</metric>
    <metric>[size] of flower 6</metric>
    <metric>[size] of flower 7</metric>
    <metric>[size] of flower 8</metric>
    <metric>[size] of flower 9</metric>
    <metric>[size] of flower 10</metric>
    <metric>[size] of flower 11</metric>
    <metric>[size] of flower 12</metric>
    <metric>[size] of flower 13</metric>
    <metric>[size] of flower 14</metric>
    <metric>[size] of flower 15</metric>
    <metric>[size] of flower 16</metric>
    <metric>[size] of flower 17</metric>
    <metric>[size] of flower 18</metric>
    <metric>[size] of flower 19</metric>
    <metric>[size] of flower 20</metric>
    <metric>[size] of flower 21</metric>
    <metric>[size] of flower 22</metric>
    <metric>[size] of flower 23</metric>
    <metric>[size] of flower 24</metric>
    <metric>[size] of flower 25</metric>
    <metric>[size] of flower 26</metric>
    <metric>[size] of flower 27</metric>
    <metric>[size] of flower 28</metric>
    <metric>[size] of flower 29</metric>
    <metric>[size] of flower 30</metric>
    <metric>[size] of flower 31</metric>
    <metric>[size] of flower 32</metric>
    <metric>[size] of flower 33</metric>
    <metric>[size] of flower 34</metric>
    <metric>[size] of flower 35</metric>
    <metric>[size] of flower 36</metric>
    <metric>[size] of flower 37</metric>
    <metric>[size] of flower 38</metric>
    <metric>[size] of flower 39</metric>
    <metric>[size] of flower 40</metric>
    <metric>[size] of flower 41</metric>
    <metric>[size] of flower 42</metric>
    <metric>[size] of flower 43</metric>
    <metric>[size] of flower 44</metric>
    <metric>[size] of flower 45</metric>
    <metric>[size] of flower 46</metric>
    <metric>[size] of flower 47</metric>
    <metric>[size] of flower 48</metric>
    <metric>[size] of flower 49</metric>
    <metric>[size] of flower 50</metric>
    <metric>[size] of flower 51</metric>
    <metric>[size] of flower 52</metric>
    <metric>[size] of flower 53</metric>
    <metric>[size] of flower 54</metric>
    <metric>[size] of flower 55</metric>
    <metric>[size] of flower 56</metric>
    <metric>[size] of flower 57</metric>
    <metric>[size] of flower 58</metric>
    <metric>[size] of flower 59</metric>
    <metric>[size] of flower 60</metric>
    <metric>[size] of flower 61</metric>
    <metric>[size] of flower 62</metric>
    <metric>[size] of flower 63</metric>
    <metric>[size] of flower 64</metric>
    <metric>[size] of flower 65</metric>
    <metric>[size] of flower 66</metric>
    <metric>[size] of flower 67</metric>
    <metric>[size] of flower 68</metric>
    <metric>[size] of flower 69</metric>
    <metric>[size] of flower 70</metric>
    <metric>[size] of flower 71</metric>
    <metric>[size] of flower 72</metric>
    <metric>[size] of flower 73</metric>
    <metric>[size] of flower 74</metric>
    <metric>[size] of flower 75</metric>
    <metric>[size] of flower 76</metric>
    <metric>[size] of flower 77</metric>
    <metric>[size] of flower 78</metric>
    <metric>[size] of flower 79</metric>
    <metric>[size] of flower 80</metric>
    <metric>[size] of flower 81</metric>
    <metric>[size] of flower 82</metric>
    <metric>[size] of flower 83</metric>
    <metric>[size] of flower 84</metric>
    <metric>[size] of flower 85</metric>
    <metric>[size] of flower 86</metric>
    <metric>[size] of flower 87</metric>
    <metric>[size] of flower 88</metric>
    <metric>[size] of flower 89</metric>
    <metric>[size] of flower 90</metric>
    <metric>[size] of flower 91</metric>
    <metric>[size] of flower 92</metric>
    <metric>[size] of flower 93</metric>
    <metric>[size] of flower 94</metric>
    <metric>[size] of flower 95</metric>
    <metric>[size] of flower 96</metric>
    <metric>[size] of flower 97</metric>
    <metric>[size] of flower 98</metric>
    <metric>[size] of flower 99</metric>
    <metric>[size] of flower 100</metric>
    <metric>[size] of flower 101</metric>
    <metric>[size] of flower 102</metric>
    <metric>[size] of flower 103</metric>
    <metric>[size] of flower 104</metric>
    <metric>[size] of flower 105</metric>
    <metric>[size] of flower 106</metric>
    <metric>[size] of flower 107</metric>
    <metric>[size] of flower 108</metric>
    <metric>[size] of flower 109</metric>
    <metric>[size] of flower 110</metric>
    <metric>[size] of flower 111</metric>
    <metric>[size] of flower 112</metric>
    <metric>[size] of flower 113</metric>
    <metric>[size] of flower 114</metric>
    <metric>[size] of flower 115</metric>
    <metric>[size] of flower 116</metric>
    <metric>[size] of flower 117</metric>
    <metric>[size] of flower 118</metric>
    <metric>[size] of flower 119</metric>
    <metric>[size] of flower 120</metric>
    <metric>[size] of flower 121</metric>
    <metric>[size] of flower 122</metric>
    <metric>[size] of flower 123</metric>
    <metric>[size] of flower 124</metric>
    <steppedValueSet variable="radio_deteccion" first="5" step="10" last="15"/>
    <enumeratedValueSet variable="num_flowers">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="2"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_bees" first="5" step="20" last="105"/>
  </experiment>
  <experiment name="experiment hipotesis tamaño control homogeneo" repetitions="4" runMetricsEveryStep="true">
    <setup>setup_homogeneo_control</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>[flowers-here] of flowers</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 0</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 1</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 2</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 3</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 4</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 5</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 6</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 7</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 8</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 9</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 10</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 11</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 12</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 13</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 14</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 15</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 16</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 17</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 18</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 19</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 20</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 21</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 22</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 23</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 24</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 25</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 26</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 27</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 28</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 29</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 30</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 31</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 32</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 33</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 34</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 35</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 36</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 37</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 38</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 39</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 40</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 41</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 42</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 43</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 44</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 45</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 46</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 47</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 48</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 49</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 50</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 51</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 52</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 53</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 54</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 55</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 56</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 57</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 58</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 59</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 60</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 61</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 62</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 63</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 64</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 65</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 66</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 67</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 68</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 69</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 70</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 71</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 72</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 73</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 74</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 75</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 76</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 77</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 78</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 79</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 80</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 81</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 82</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 83</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 84</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 85</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 86</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 87</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 88</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 89</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 90</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 91</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 92</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 93</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 94</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 95</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 96</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 97</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 98</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 99</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 100</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 101</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 102</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 103</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 104</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 105</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 106</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 107</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 108</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 109</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 110</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 111</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 112</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 113</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 114</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 115</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 116</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 117</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 118</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 119</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 120</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 121</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 122</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 123</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 124</metric>
    <metric>[visitas] of flower 0</metric>
    <metric>[visitas] of flower 1</metric>
    <metric>[visitas] of flower 2</metric>
    <metric>[visitas] of flower 3</metric>
    <metric>[visitas] of flower 4</metric>
    <metric>[visitas] of flower 5</metric>
    <metric>[visitas] of flower 6</metric>
    <metric>[visitas] of flower 7</metric>
    <metric>[visitas] of flower 8</metric>
    <metric>[visitas] of flower 9</metric>
    <metric>[visitas] of flower 10</metric>
    <metric>[visitas] of flower 11</metric>
    <metric>[visitas] of flower 12</metric>
    <metric>[visitas] of flower 13</metric>
    <metric>[visitas] of flower 14</metric>
    <metric>[visitas] of flower 15</metric>
    <metric>[visitas] of flower 16</metric>
    <metric>[visitas] of flower 17</metric>
    <metric>[visitas] of flower 18</metric>
    <metric>[visitas] of flower 19</metric>
    <metric>[visitas] of flower 20</metric>
    <metric>[visitas] of flower 21</metric>
    <metric>[visitas] of flower 22</metric>
    <metric>[visitas] of flower 23</metric>
    <metric>[visitas] of flower 24</metric>
    <metric>[visitas] of flower 25</metric>
    <metric>[visitas] of flower 26</metric>
    <metric>[visitas] of flower 27</metric>
    <metric>[visitas] of flower 28</metric>
    <metric>[visitas] of flower 29</metric>
    <metric>[visitas] of flower 30</metric>
    <metric>[visitas] of flower 31</metric>
    <metric>[visitas] of flower 32</metric>
    <metric>[visitas] of flower 33</metric>
    <metric>[visitas] of flower 34</metric>
    <metric>[visitas] of flower 35</metric>
    <metric>[visitas] of flower 36</metric>
    <metric>[visitas] of flower 37</metric>
    <metric>[visitas] of flower 38</metric>
    <metric>[visitas] of flower 39</metric>
    <metric>[visitas] of flower 40</metric>
    <metric>[visitas] of flower 41</metric>
    <metric>[visitas] of flower 42</metric>
    <metric>[visitas] of flower 43</metric>
    <metric>[visitas] of flower 44</metric>
    <metric>[visitas] of flower 45</metric>
    <metric>[visitas] of flower 46</metric>
    <metric>[visitas] of flower 47</metric>
    <metric>[visitas] of flower 48</metric>
    <metric>[visitas] of flower 49</metric>
    <metric>[visitas] of flower 50</metric>
    <metric>[visitas] of flower 51</metric>
    <metric>[visitas] of flower 52</metric>
    <metric>[visitas] of flower 53</metric>
    <metric>[visitas] of flower 54</metric>
    <metric>[visitas] of flower 55</metric>
    <metric>[visitas] of flower 56</metric>
    <metric>[visitas] of flower 57</metric>
    <metric>[visitas] of flower 58</metric>
    <metric>[visitas] of flower 59</metric>
    <metric>[visitas] of flower 60</metric>
    <metric>[visitas] of flower 61</metric>
    <metric>[visitas] of flower 62</metric>
    <metric>[visitas] of flower 63</metric>
    <metric>[visitas] of flower 64</metric>
    <metric>[visitas] of flower 65</metric>
    <metric>[visitas] of flower 66</metric>
    <metric>[visitas] of flower 67</metric>
    <metric>[visitas] of flower 68</metric>
    <metric>[visitas] of flower 69</metric>
    <metric>[visitas] of flower 70</metric>
    <metric>[visitas] of flower 71</metric>
    <metric>[visitas] of flower 72</metric>
    <metric>[visitas] of flower 73</metric>
    <metric>[visitas] of flower 74</metric>
    <metric>[visitas] of flower 75</metric>
    <metric>[visitas] of flower 76</metric>
    <metric>[visitas] of flower 77</metric>
    <metric>[visitas] of flower 78</metric>
    <metric>[visitas] of flower 79</metric>
    <metric>[visitas] of flower 80</metric>
    <metric>[visitas] of flower 81</metric>
    <metric>[visitas] of flower 82</metric>
    <metric>[visitas] of flower 83</metric>
    <metric>[visitas] of flower 84</metric>
    <metric>[visitas] of flower 85</metric>
    <metric>[visitas] of flower 86</metric>
    <metric>[visitas] of flower 87</metric>
    <metric>[visitas] of flower 88</metric>
    <metric>[visitas] of flower 89</metric>
    <metric>[visitas] of flower 90</metric>
    <metric>[visitas] of flower 91</metric>
    <metric>[visitas] of flower 92</metric>
    <metric>[visitas] of flower 93</metric>
    <metric>[visitas] of flower 94</metric>
    <metric>[visitas] of flower 95</metric>
    <metric>[visitas] of flower 96</metric>
    <metric>[visitas] of flower 97</metric>
    <metric>[visitas] of flower 98</metric>
    <metric>[visitas] of flower 99</metric>
    <metric>[visitas] of flower 100</metric>
    <metric>[visitas] of flower 101</metric>
    <metric>[visitas] of flower 102</metric>
    <metric>[visitas] of flower 103</metric>
    <metric>[visitas] of flower 104</metric>
    <metric>[visitas] of flower 105</metric>
    <metric>[visitas] of flower 106</metric>
    <metric>[visitas] of flower 107</metric>
    <metric>[visitas] of flower 108</metric>
    <metric>[visitas] of flower 109</metric>
    <metric>[visitas] of flower 110</metric>
    <metric>[visitas] of flower 111</metric>
    <metric>[visitas] of flower 112</metric>
    <metric>[visitas] of flower 113</metric>
    <metric>[visitas] of flower 114</metric>
    <metric>[visitas] of flower 115</metric>
    <metric>[visitas] of flower 116</metric>
    <metric>[visitas] of flower 117</metric>
    <metric>[visitas] of flower 118</metric>
    <metric>[visitas] of flower 119</metric>
    <metric>[visitas] of flower 120</metric>
    <metric>[visitas] of flower 121</metric>
    <metric>[visitas] of flower 122</metric>
    <metric>[visitas] of flower 123</metric>
    <metric>[visitas] of flower 124</metric>
    <enumeratedValueSet variable="rows">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="5"/>
    </enumeratedValueSet>
    <steppedValueSet variable="radio_deteccion" first="5" step="10" last="15"/>
    <enumeratedValueSet variable="num_flowers">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="2"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_bees" first="5" step="20" last="105"/>
  </experiment>
  <experiment name="experiment hipotesis tamaño homogeneo" repetitions="4" runMetricsEveryStep="true">
    <setup>setup_homogeneo</setup>
    <go>go_homogeneo</go>
    <timeLimit steps="120"/>
    <metric>[flowers-here] of flowers</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 0</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 1</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 2</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 3</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 4</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 5</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 6</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 7</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 8</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 9</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 10</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 11</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 12</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 13</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 14</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 15</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 16</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 17</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 18</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 19</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 20</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 21</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 22</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 23</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 24</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 25</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 26</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 27</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 28</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 29</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 30</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 31</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 32</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 33</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 34</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 35</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 36</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 37</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 38</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 39</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 40</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 41</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 42</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 43</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 44</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 45</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 46</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 47</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 48</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 49</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 50</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 51</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 52</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 53</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 54</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 55</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 56</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 57</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 58</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 59</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 60</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 61</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 62</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 63</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 64</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 65</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 66</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 67</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 68</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 69</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 70</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 71</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 72</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 73</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 74</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 75</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 76</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 77</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 78</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 79</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 80</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 81</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 82</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 83</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 84</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 85</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 86</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 87</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 88</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 89</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 90</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 91</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 92</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 93</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 94</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 95</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 96</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 97</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 98</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 99</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 100</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 101</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 102</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 103</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 104</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 105</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 106</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 107</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 108</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 109</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 110</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 111</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 112</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 113</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 114</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 115</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 116</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 117</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 118</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 119</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 120</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 121</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 122</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 123</metric>
    <metric>[[[who] of flowers-here] of neighbors] of flower 124</metric>
    <metric>[visitas] of flower 0</metric>
    <metric>[visitas] of flower 1</metric>
    <metric>[visitas] of flower 2</metric>
    <metric>[visitas] of flower 3</metric>
    <metric>[visitas] of flower 4</metric>
    <metric>[visitas] of flower 5</metric>
    <metric>[visitas] of flower 6</metric>
    <metric>[visitas] of flower 7</metric>
    <metric>[visitas] of flower 8</metric>
    <metric>[visitas] of flower 9</metric>
    <metric>[visitas] of flower 10</metric>
    <metric>[visitas] of flower 11</metric>
    <metric>[visitas] of flower 12</metric>
    <metric>[visitas] of flower 13</metric>
    <metric>[visitas] of flower 14</metric>
    <metric>[visitas] of flower 15</metric>
    <metric>[visitas] of flower 16</metric>
    <metric>[visitas] of flower 17</metric>
    <metric>[visitas] of flower 18</metric>
    <metric>[visitas] of flower 19</metric>
    <metric>[visitas] of flower 20</metric>
    <metric>[visitas] of flower 21</metric>
    <metric>[visitas] of flower 22</metric>
    <metric>[visitas] of flower 23</metric>
    <metric>[visitas] of flower 24</metric>
    <metric>[visitas] of flower 25</metric>
    <metric>[visitas] of flower 26</metric>
    <metric>[visitas] of flower 27</metric>
    <metric>[visitas] of flower 28</metric>
    <metric>[visitas] of flower 29</metric>
    <metric>[visitas] of flower 30</metric>
    <metric>[visitas] of flower 31</metric>
    <metric>[visitas] of flower 32</metric>
    <metric>[visitas] of flower 33</metric>
    <metric>[visitas] of flower 34</metric>
    <metric>[visitas] of flower 35</metric>
    <metric>[visitas] of flower 36</metric>
    <metric>[visitas] of flower 37</metric>
    <metric>[visitas] of flower 38</metric>
    <metric>[visitas] of flower 39</metric>
    <metric>[visitas] of flower 40</metric>
    <metric>[visitas] of flower 41</metric>
    <metric>[visitas] of flower 42</metric>
    <metric>[visitas] of flower 43</metric>
    <metric>[visitas] of flower 44</metric>
    <metric>[visitas] of flower 45</metric>
    <metric>[visitas] of flower 46</metric>
    <metric>[visitas] of flower 47</metric>
    <metric>[visitas] of flower 48</metric>
    <metric>[visitas] of flower 49</metric>
    <metric>[visitas] of flower 50</metric>
    <metric>[visitas] of flower 51</metric>
    <metric>[visitas] of flower 52</metric>
    <metric>[visitas] of flower 53</metric>
    <metric>[visitas] of flower 54</metric>
    <metric>[visitas] of flower 55</metric>
    <metric>[visitas] of flower 56</metric>
    <metric>[visitas] of flower 57</metric>
    <metric>[visitas] of flower 58</metric>
    <metric>[visitas] of flower 59</metric>
    <metric>[visitas] of flower 60</metric>
    <metric>[visitas] of flower 61</metric>
    <metric>[visitas] of flower 62</metric>
    <metric>[visitas] of flower 63</metric>
    <metric>[visitas] of flower 64</metric>
    <metric>[visitas] of flower 65</metric>
    <metric>[visitas] of flower 66</metric>
    <metric>[visitas] of flower 67</metric>
    <metric>[visitas] of flower 68</metric>
    <metric>[visitas] of flower 69</metric>
    <metric>[visitas] of flower 70</metric>
    <metric>[visitas] of flower 71</metric>
    <metric>[visitas] of flower 72</metric>
    <metric>[visitas] of flower 73</metric>
    <metric>[visitas] of flower 74</metric>
    <metric>[visitas] of flower 75</metric>
    <metric>[visitas] of flower 76</metric>
    <metric>[visitas] of flower 77</metric>
    <metric>[visitas] of flower 78</metric>
    <metric>[visitas] of flower 79</metric>
    <metric>[visitas] of flower 80</metric>
    <metric>[visitas] of flower 81</metric>
    <metric>[visitas] of flower 82</metric>
    <metric>[visitas] of flower 83</metric>
    <metric>[visitas] of flower 84</metric>
    <metric>[visitas] of flower 85</metric>
    <metric>[visitas] of flower 86</metric>
    <metric>[visitas] of flower 87</metric>
    <metric>[visitas] of flower 88</metric>
    <metric>[visitas] of flower 89</metric>
    <metric>[visitas] of flower 90</metric>
    <metric>[visitas] of flower 91</metric>
    <metric>[visitas] of flower 92</metric>
    <metric>[visitas] of flower 93</metric>
    <metric>[visitas] of flower 94</metric>
    <metric>[visitas] of flower 95</metric>
    <metric>[visitas] of flower 96</metric>
    <metric>[visitas] of flower 97</metric>
    <metric>[visitas] of flower 98</metric>
    <metric>[visitas] of flower 99</metric>
    <metric>[visitas] of flower 100</metric>
    <metric>[visitas] of flower 101</metric>
    <metric>[visitas] of flower 102</metric>
    <metric>[visitas] of flower 103</metric>
    <metric>[visitas] of flower 104</metric>
    <metric>[visitas] of flower 105</metric>
    <metric>[visitas] of flower 106</metric>
    <metric>[visitas] of flower 107</metric>
    <metric>[visitas] of flower 108</metric>
    <metric>[visitas] of flower 109</metric>
    <metric>[visitas] of flower 110</metric>
    <metric>[visitas] of flower 111</metric>
    <metric>[visitas] of flower 112</metric>
    <metric>[visitas] of flower 113</metric>
    <metric>[visitas] of flower 114</metric>
    <metric>[visitas] of flower 115</metric>
    <metric>[visitas] of flower 116</metric>
    <metric>[visitas] of flower 117</metric>
    <metric>[visitas] of flower 118</metric>
    <metric>[visitas] of flower 119</metric>
    <metric>[visitas] of flower 120</metric>
    <metric>[visitas] of flower 121</metric>
    <metric>[visitas] of flower 122</metric>
    <metric>[visitas] of flower 123</metric>
    <metric>[visitas] of flower 124</metric>
    <metric>[size] of flower 0</metric>
    <metric>[size] of flower 1</metric>
    <metric>[size] of flower 2</metric>
    <metric>[size] of flower 3</metric>
    <metric>[size] of flower 4</metric>
    <metric>[size] of flower 5</metric>
    <metric>[size] of flower 6</metric>
    <metric>[size] of flower 7</metric>
    <metric>[size] of flower 8</metric>
    <metric>[size] of flower 9</metric>
    <metric>[size] of flower 10</metric>
    <metric>[size] of flower 11</metric>
    <metric>[size] of flower 12</metric>
    <metric>[size] of flower 13</metric>
    <metric>[size] of flower 14</metric>
    <metric>[size] of flower 15</metric>
    <metric>[size] of flower 16</metric>
    <metric>[size] of flower 17</metric>
    <metric>[size] of flower 18</metric>
    <metric>[size] of flower 19</metric>
    <metric>[size] of flower 20</metric>
    <metric>[size] of flower 21</metric>
    <metric>[size] of flower 22</metric>
    <metric>[size] of flower 23</metric>
    <metric>[size] of flower 24</metric>
    <metric>[size] of flower 25</metric>
    <metric>[size] of flower 26</metric>
    <metric>[size] of flower 27</metric>
    <metric>[size] of flower 28</metric>
    <metric>[size] of flower 29</metric>
    <metric>[size] of flower 30</metric>
    <metric>[size] of flower 31</metric>
    <metric>[size] of flower 32</metric>
    <metric>[size] of flower 33</metric>
    <metric>[size] of flower 34</metric>
    <metric>[size] of flower 35</metric>
    <metric>[size] of flower 36</metric>
    <metric>[size] of flower 37</metric>
    <metric>[size] of flower 38</metric>
    <metric>[size] of flower 39</metric>
    <metric>[size] of flower 40</metric>
    <metric>[size] of flower 41</metric>
    <metric>[size] of flower 42</metric>
    <metric>[size] of flower 43</metric>
    <metric>[size] of flower 44</metric>
    <metric>[size] of flower 45</metric>
    <metric>[size] of flower 46</metric>
    <metric>[size] of flower 47</metric>
    <metric>[size] of flower 48</metric>
    <metric>[size] of flower 49</metric>
    <metric>[size] of flower 50</metric>
    <metric>[size] of flower 51</metric>
    <metric>[size] of flower 52</metric>
    <metric>[size] of flower 53</metric>
    <metric>[size] of flower 54</metric>
    <metric>[size] of flower 55</metric>
    <metric>[size] of flower 56</metric>
    <metric>[size] of flower 57</metric>
    <metric>[size] of flower 58</metric>
    <metric>[size] of flower 59</metric>
    <metric>[size] of flower 60</metric>
    <metric>[size] of flower 61</metric>
    <metric>[size] of flower 62</metric>
    <metric>[size] of flower 63</metric>
    <metric>[size] of flower 64</metric>
    <metric>[size] of flower 65</metric>
    <metric>[size] of flower 66</metric>
    <metric>[size] of flower 67</metric>
    <metric>[size] of flower 68</metric>
    <metric>[size] of flower 69</metric>
    <metric>[size] of flower 70</metric>
    <metric>[size] of flower 71</metric>
    <metric>[size] of flower 72</metric>
    <metric>[size] of flower 73</metric>
    <metric>[size] of flower 74</metric>
    <metric>[size] of flower 75</metric>
    <metric>[size] of flower 76</metric>
    <metric>[size] of flower 77</metric>
    <metric>[size] of flower 78</metric>
    <metric>[size] of flower 79</metric>
    <metric>[size] of flower 80</metric>
    <metric>[size] of flower 81</metric>
    <metric>[size] of flower 82</metric>
    <metric>[size] of flower 83</metric>
    <metric>[size] of flower 84</metric>
    <metric>[size] of flower 85</metric>
    <metric>[size] of flower 86</metric>
    <metric>[size] of flower 87</metric>
    <metric>[size] of flower 88</metric>
    <metric>[size] of flower 89</metric>
    <metric>[size] of flower 90</metric>
    <metric>[size] of flower 91</metric>
    <metric>[size] of flower 92</metric>
    <metric>[size] of flower 93</metric>
    <metric>[size] of flower 94</metric>
    <metric>[size] of flower 95</metric>
    <metric>[size] of flower 96</metric>
    <metric>[size] of flower 97</metric>
    <metric>[size] of flower 98</metric>
    <metric>[size] of flower 99</metric>
    <metric>[size] of flower 100</metric>
    <metric>[size] of flower 101</metric>
    <metric>[size] of flower 102</metric>
    <metric>[size] of flower 103</metric>
    <metric>[size] of flower 104</metric>
    <metric>[size] of flower 105</metric>
    <metric>[size] of flower 106</metric>
    <metric>[size] of flower 107</metric>
    <metric>[size] of flower 108</metric>
    <metric>[size] of flower 109</metric>
    <metric>[size] of flower 110</metric>
    <metric>[size] of flower 111</metric>
    <metric>[size] of flower 112</metric>
    <metric>[size] of flower 113</metric>
    <metric>[size] of flower 114</metric>
    <metric>[size] of flower 115</metric>
    <metric>[size] of flower 116</metric>
    <metric>[size] of flower 117</metric>
    <metric>[size] of flower 118</metric>
    <metric>[size] of flower 119</metric>
    <metric>[size] of flower 120</metric>
    <metric>[size] of flower 121</metric>
    <metric>[size] of flower 122</metric>
    <metric>[size] of flower 123</metric>
    <metric>[size] of flower 124</metric>
    <enumeratedValueSet variable="rows">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="columns">
      <value value="5"/>
    </enumeratedValueSet>
    <steppedValueSet variable="radio_deteccion" first="5" step="10" last="15"/>
    <enumeratedValueSet variable="num_flowers">
      <value value="125"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="flores-vacias-que-la-abeja-tolera-visitar">
      <value value="2"/>
    </enumeratedValueSet>
    <steppedValueSet variable="num_bees" first="5" step="20" last="105"/>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
