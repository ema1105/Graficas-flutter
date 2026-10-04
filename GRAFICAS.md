# Catalogo completo de graficas (252)

Listado de todas las clases de grafica definidas en el proyecto, por libreria y grupo, con su "para que sirve" (campo `paraQue` del codigo).


## Resumen

| Libreria | Basicas | Avanzadas | Total |
|----------|:-------:|:---------:|:-----:|
| community_charts | 31 | 32 | 63 |
| fl_chart | 31 | 32 | 63 |
| Syncfusion | 31 | 32 | 63 |
| graphic | 31 | 32 | 63 |
| **Total** | **124** | **128** | **252** |


---


## community_charts

_Fork de Google Charts, nativo en Dart_


### Basicas (31)

| # | Grafica | Para que sirve |
|---|---------|----------------|
| 1 | Barras | Compara cantidades entre categorias con la altura de cada barra. Usa el estilo Material de Google, limpio y animado. |
| 2 | Barras con etiquetas | Barras que muestran su valor numerico impreso dentro o encima, uniendo la comparacion visual con la cifra exacta. |
| 3 | Lineas con puntos | Una linea de tendencia con un punto marcado en cada dato, uniendo la vista continua con la ubicacion exacta de cada medicion. |
| 4 | Linea con area | Una linea con el espacio inferior relleno, para enfatizar el volumen bajo la curva ademas de la tendencia. |
| 5 | Serie de tiempo | Un grafico especializado en fechas reales en el eje X, que rotula los dias y meses de forma inteligente. |
| 6 | Dispersion | Ubica puntos segun dos variables numericas, revelando la relacion o agrupamiento entre ellas. |
| 7 | Barras agrupadas | Varias barras juntas por categoria, para comparar varias series dentro de cada periodo. |
| 8 | Pastel | Divide un total en porciones para mostrar la proporcion de cada categoria sobre el conjunto. |
| 9 | Dona | Un pastel con hueco central y el porcentaje de cada porcion rotulado sobre el anillo. |
| 10 | Step line | Una linea que avanza en escalones en vez de diagonales, mostrando que el valor se mantiene constante hasta el siguiente cambio. |
| 11 | Linea + puntos + area | Combina tres capas en una sola serie: la linea (tendencia), los puntos (dato exacto) y el area (volumen), todo a la vez. |
| 12 | Apiladas + total | Barras apiladas que ademas muestran el total de cada columna rotulado arriba, uniendo composicion y suma. |
| 13 | Tiempo + banda | Una serie temporal con area rellena y puntos marcados, combinando el manejo inteligente de fechas con la lectura de volumen. |
| 14 | Dispersion 4D | Cada punto codifica cuatro datos: posicion X, posicion Y, tamano de la burbuja y color del grupo al que pertenece. |
| 15 | Piramide tornado | Dos grupos de barras horizontales que crecen en direcciones opuestas desde un eje central, para compararlos categoria a categoria. |
| 16 | Barras divergentes | Barras que crecen hacia arriba o hacia abajo de cero segun el signo, con color distinto para positivos y negativos. |
| 17 | Dona concentrica | Dos anillos: el exterior detalla cada categoria y el interior las agrupa, mostrando el total y su desglose en dos niveles. |
| 18 | Barras + promedio movil | Barras con el valor de cada periodo y una linea de promedio movil calculada encima, que suaviza el ruido y revela la tendencia. |
| 19 | Burbujas en grilla | Burbujas ubicadas en una cuadricula de dos dimensiones categoricas, donde el tamano codifica la intensidad del cruce. |
| 20 | Area apilada temporal | Varias areas apiladas a lo largo del tiempo, mostrando el total acumulado y como cada serie contribuye en cada momento. |
| 21 | Barras por umbral | Barras que se pintan de verde si alcanzan el umbral y de naranja si no, con su valor impreso y una linea que marca el umbral. |
| 22 | Barras horizontales agrupadas | Varias barras tumbadas por categoria, una por serie, con leyenda que identifica cada color. |
| 23 | Apiladas al 100 % | Barras apiladas donde todas las columnas miden lo mismo (100 %) y cada segmento muestra su proporcion, sin importar el total. |
| 24 | Agrupadas + apiladas | Cada periodo tiene dos columnas: una apila los productos A y B y la otra muestra el C, combinando agrupacion y apilado. |
| 25 | Pastel con etiquetas externas | Un pastel que rotula cada porcion fuera del circulo, con una linea guia hasta ella, para que el texto nunca se amontone. |
| 26 | Sparklines | Mini-graficas de linea sin ejes que resumen la tendencia de un tramo en muy poco espacio, junto a su valor final y variacion. |
| 27 | Dispersion con formas | Una nube de puntos donde cada grupo se distingue por su forma (circulo, cuadrado, circulo hueco) y por su color. |
| 28 | Areas superpuestas | Varias areas translucidas que arrancan todas desde el eje, de modo que se ve cual es mayor y donde se cruzan. |
| 29 | Solido + punteado | Una misma linea que cambia de trazo: continuo en el primer tramo y discontinuo en el segundo, unidos sin corte visible. |
| 30 | Barras redondeadas | Columnas de extremos muy redondeados, con ancho maximo fijo y su valor impreso, para un acabado suave en lugar de bloques rigidos. |
| 31 | Histograma | Muestra como se distribuyen los valores: el rango total se divide en intervalos iguales y cada barra cuenta cuantos datos caen en el. |

### Avanzadas (32)

| # | Grafica | Para que sirve |
|---|---------|----------------|
| 1 | Barras con seleccion | Al tocar una barra, la grafica la selecciona y resalta su categoria, atenuando el resto para centrar la atencion. |
| 2 | Combo linea + barra | Dibuja una serie como barras y otra como linea en el mismo eje, para comparar dos medidas relacionadas con lecturas distintas. |
| 3 | Combo dispersion + linea | Una nube de puntos con una linea de tendencia superpuesta, para ver los datos crudos y su comportamiento esperado juntos. |
| 4 | Lineas con leyenda | Varias lineas acompanadas de una leyenda que identifica cada serie por nombre y color. |
| 5 | Barras con resaltado | Al tocar, dibuja lineas guia horizontal y vertical hacia el punto mas cercano, ayudando a leer su valor contra los ejes. |
| 6 | Serie con banda | Una serie temporal con un periodo sombreado de fondo, que destaca un intervalo de fechas concreto dentro de la serie. |
| 7 | Zoom y paneo | Permite acercar con dos dedos y desplazar la grafica, para explorar series largas en detalle. |
| 8 | Gauge de arco | Un semicirculo que se llena segun un valor sobre su maximo, imitando un medidor. |
| 9 | Barras horizontales | Barras tumbadas que dejan espacio para etiquetas largas en el eje de categorias. |
| 10 | Linea con anotacion | Una linea sobre una franja horizontal sombreada que marca un rango de valores aceptables. |
| 11 | Combo barras + area | Barras con el valor de cada periodo sobre un area de fondo que representa otra magnitud de contexto. |
| 12 | Tiempo + promedio + banda | La serie, su promedio como linea discontinua y una franja de normalidad alrededor del promedio, en una sola vista. |
| 13 | Agrupadas + seleccion + leyenda | Barras agrupadas con leyenda para identificar cada serie y seleccion al tocar para resaltar el periodo que se revisa. |
| 14 | Dispersion + zoom | Una nube de puntos que se puede acercar y desplazar con los dedos, y donde tocar un punto lo selecciona. |
| 15 | Apiladas + linea total | Barras apiladas por componente con una linea que recorre el total de cada periodo, para ver composicion y evolucion del total. |
| 16 | Lineas + promedio + leyenda | Varias series con puntos, una linea discontinua con el promedio de todas y leyenda, para ver quien esta sobre o bajo la media. |
| 17 | Gauge doble | Dos medidores semicirculares concentricos, cada uno con su indicador, para comparar dos niveles en un mismo espacio. |
| 18 | Area + referencia | Un area de volumen con una linea horizontal de referencia rotulada, para ver cuanto del volumen supera el umbral. |
| 19 | Dispersion por zonas | Una nube de puntos dividida en tres zonas sombreadas, cada una con su color de grupo y leyenda que las identifica. |
| 20 | Combo de tres renderers | Tres series en la misma grafica, cada una con una forma distinta: barras, linea y puntos, para separarlas visualmente por su rol. |
| 21 | Cascada | Barras flotantes encadenadas: cada una empieza donde termino la anterior, mostrando como sumas (verde) y restas (naranja) llevan de un inicio a un total. |
| 22 | Barras + marcador | Cada barra lleva encima una marca horizontal con un valor de referencia (aqui, el promedio de los tres productos): se ve de un vistazo quien queda por encima o por debajo. |
| 23 | Velas | Cada vela resume un periodo: el cuerpo ancho va de apertura a cierre (verde si sube, naranja si baja) y la mecha fina llega hasta el maximo y el minimo. |
| 24 | Banda de desviacion | La serie sobre una franja que cubre el promedio movil de 5 dias mas/menos una desviacion estandar: se ensancha cuando los datos son erraticos y se estrecha cuando son estables. |
| 25 | Maximo y minimo | Marca con una linea vertical y una etiqueta el dia del valor mas alto (verde) y del mas bajo (naranja) de la serie, calculados a partir de los propios datos. |
| 26 | Leyenda con valores | Al tocar o arrastrar sobre la grafica, la leyenda cambia y muestra el valor exacto de cada serie en ese punto. |
| 27 | Barras con detalle | Al tocar una barra, un panel fuera de la grafica muestra su valor y que porcentaje del total representa; la barra elegida cambia de color. |
| 28 | Slider | Una linea vertical con asa que se arrastra a lo largo de la grafica; al soltarla en cualquier punto se lee el valor de la serie en ese dia. |
| 29 | Dona con total al centro | Una dona que muestra el total en su centro; al tocar una porcion, el centro pasa a mostrar la categoria y su valor. |
| 30 | Doble eje | Dos series de unidades distintas en una misma grafica: las barras se leen en el eje izquierdo y la linea en un segundo eje a la derecha, con su propia escala. |
| 31 | Gantt | Cada barra horizontal va del inicio al fin de una tarea, mostrando su duracion y como se solapan; una linea vertical marca la semana actual. |
| 32 | Mancuernas | Dos puntos por periodo unidos por un segmento: el largo del segmento es la diferencia entre las dos series y su posicion muestra cual va por encima. |

---


## fl_chart

_Nativa en Dart, muy personalizable_


### Basicas (31)

| # | Grafica | Para que sirve |
|---|---------|----------------|
| 1 | Barras | Compara cantidades entre categorias distintas mediante la altura de cada barra. Es el grafico mas directo para ver quien tiene mas. |
| 2 | Lineas | Muestra como cambia un valor a lo largo de una secuencia, uniendo los puntos para que la tendencia se vea de un trazo. |
| 3 | Area | Como una linea, pero rellena el espacio debajo para enfatizar el volumen o la magnitud acumulada, no solo la tendencia. |
| 4 | Pastel | Divide un total en porciones, mostrando que parte del todo ocupa cada categoria. |
| 5 | Dona | Igual que el pastel pero con un hueco central, que aligera la figura y deja espacio para un dato o titulo en el centro. |
| 6 | Barras horizontales | Barras tumbadas de izquierda a derecha. La orientacion horizontal da espacio para etiquetas de categoria largas. |
| 7 | Lineas multiples | Traza varias lineas en el mismo plano para comparar la evolucion de varias series a la vez. |
| 8 | Barras apiladas | Apila varias series en una sola barra, mostrando el total de cada periodo y como se compone internamente. |
| 9 | Dispersion | Ubica cada dato como un punto segun dos variables, revelando si existe relacion o correlacion entre ellas. |
| 10 | Area con gradiente | Un area cuyo relleno se desvanece de arriba hacia abajo, dando profundidad visual a la tendencia. |
| 11 | Barras + tendencia | Las barras dan el valor exacto de cada periodo y la linea superpuesta revela la direccion general que las barras no muestran. |
| 12 | Linea con banda | La linea marca el valor central y la banda sombreada muestra su margen de variacion o incertidumbre alrededor de ese valor. |
| 13 | Pastel anidado | Dos anillos concentricos: el interior muestra grandes grupos y el exterior su desglose, ligando el total con sus partes. |
| 14 | Dispersion + promedios | A la nube de puntos le anade una linea de promedio en cada eje, partiendo el plano en cuatro cuadrantes para clasificar los puntos. |
| 15 | Area + hitos | El area muestra la evolucion continua y las barras verticales marcan momentos puntuales relevantes sobre esa evolucion. |
| 16 | Apiladas + lineas | Las barras apiladas muestran la composicion total de cada periodo y las lineas encima siguen el recorrido individual de cada serie. |
| 17 | Doble eje | Muestra dos series de unidades muy distintas en el mismo grafico, cada una referida a su propio eje (izquierdo y derecho). |
| 18 | Embudo de conversion | Barras centradas que se angostan en cada etapa, mostrando cuanta cantidad se pierde al avanzar por un proceso de varios pasos. |
| 19 | Pareto | Barras ordenadas de mayor a menor con una linea de porcentaje acumulado, para ver que pocas categorias concentran casi todo. |
| 20 | Mapa de calor | Una cuadricula donde el color de cada celda codifica la intensidad de un valor en el cruce de dos dimensiones categoricas. |
| 21 | Linea punteada | Una linea cuyo trazo es discontinuo, lo que la distingue de una serie solida y comunica que el dato es una estimacion o un plan. |
| 22 | Barras pill | Columnas con extremos totalmente redondeados, en forma de capsula, que dan un aspecto suave y moderno al mismo comparativo de barras. |
| 23 | Pastel con seccion separada | Un pastel en el que una porcion se desplaza hacia afuera del centro para llamar la atencion sobre ella. |
| 24 | Lineas con relleno entre series | Dos lineas curvas con el espacio entre ellas coloreado, de modo que la brecha entre una serie y otra se lea como una mancha. |
| 25 | Barras positivas y negativas | Barras que salen hacia arriba o hacia abajo de una linea base en cero, con un color distinto segun el valor sea positivo o negativo. |
| 26 | Dispersion con tamano por valor | Puntos cuyo radio y opacidad crecen con su valor, de modo que los datos mas altos pesan mas a la vista que los bajos. |
| 27 | Area escalonada | Una area cuyo borde avanza en escalones: el valor se mantiene constante hasta que cambia de golpe, sin rampas entre puntos. |
| 28 | Barras con linea de meta | Columnas con una linea horizontal de objetivo; las barras que alcanzan la meta se pintan fuertes y las que no, atenuadas. |
| 29 | Dona con anillos finos | Varios anillos delgados concentricos, cada uno con su propio avance, que se leen como indicadores de progreso comparables. |
| 30 | Linea con puntos por umbral | Una linea cuyos puntos cambian de color segun superen o no un umbral, marcado con una linea de referencia. |
| 31 | Barras horizontales apiladas | Barras tumbadas donde cada una se compone de segmentos apilados: muestra el total de cada categoria y su desglose por serie. |

### Avanzadas (32)

| # | Grafica | Para que sirve |
|---|---------|----------------|
| 1 | Radar | Compara dos entidades en varias dimensiones a la vez, superponiendo sus poligonos para ver en que criterios gana cada una. |
| 2 | Linea curva con sombra | Suaviza la linea con curvas y le anade una sombra, dando una lectura de tendencia mas fluida y con relieve visual. |
| 3 | Barras con fondo | Dibuja detras de cada barra una barra fantasma que representa el maximo posible, para leer cada valor como proporcion de ese tope. |
| 4 | Pastel interactivo | Un pastel que resalta y agranda la porcion que el usuario toca, invitando a explorar los datos con el dedo. |
| 5 | Burbuja | Como una dispersion, pero el tamano de cada punto codifica una tercera variable, mostrando tres datos por punto. |
| 6 | Linea con tooltip | Al tocar la linea, muestra en un globo el valor exacto del punto, uniendo la vista general con la consulta puntual. |
| 7 | Barras agrupadas | Coloca varias barras juntas por cada categoria, para comparar varias series dentro de cada periodo lado a lado. |
| 8 | Area apilada | Apila el area de varias series una sobre otra, mostrando el total acumulado y el aporte de cada serie a ese total. |
| 9 | Lineas de referencia | Traza la serie y superpone una linea horizontal de referencia (el promedio), para ver que puntos estan por encima o por debajo. |
| 10 | Banda min-max | Muestra una linea central con una banda sombreada entre un minimo y un maximo, delimitando el rango esperado. |
| 11 | Burbujas + cuadrantes | Burbujas de tamano variable (tres datos por punto) sobre un plano dividido en cuatro cuadrantes por los promedios de cada eje. |
| 12 | Cascada | Barras flotantes que se encadenan: cada una empieza donde termino la anterior, mostrando el efecto acumulado de sumas y restas. |
| 13 | Barras + zona meta | Las barras muestran el valor de cada periodo sobre una franja de fondo que marca el rango objetivo, para ver quien cae dentro. |
| 14 | Radar + barras | El radar da la forma global del perfil y las barras de abajo el valor numerico exacto de cada dimension. |
| 15 | Termometro de progreso | Una barra que se llena segun el avance actual con una marca que senala la meta, comparando lo logrado con lo esperado. |
| 16 | Dispersion + regresion | A la nube de puntos le anade la recta que mejor los resume (minimos cuadrados), haciendo visible la tendencia subyacente. |
| 17 | Velas | Cada vela resume cuatro datos de un periodo: maximo y minimo (la mecha fina) y apertura y cierre (el cuerpo grueso). |
| 18 | Area de diferencia | Dos lineas con la zona entre ellas rellena, para que el tamano de la diferencia entre ambas series sea visible de inmediato. |
| 19 | Agrupadas + objetivo | Barras agrupadas por periodo con una linea horizontal de meta, para ver de un vistazo que series superan el objetivo. |
| 20 | Gantt | Cada barra horizontal va del inicio al fin de una tarea en una linea de tiempo, mostrando duracion y como se solapan las fases. |
| 21 | Velas + volumen | Las velas muestran apertura, cierre, maximo y minimo de cada periodo y, justo debajo, una linea con el volumen negociado, alineada vela por vela. |
| 22 | Radar de tres perfiles | Superpone tres poligonos en los mismos ejes: dos entidades y un perfil de referencia (el promedio), para ver quien queda por encima o por debajo de la media en cada criterio. |
| 23 | Dispersion + elipse | Muestra la nube de puntos y una elipse que encierra la zona donde se concentra la mayoria (aprox. 95 %), con su inclinacion indicando la correlacion entre las dos variables. |
| 24 | Barras + banda de desviacion | Columnas sobre una franja que cubre el promedio mas/menos una desviacion estandar: las barras fuera de la franja se pintan distinto porque se alejan de lo habitual. |
| 25 | Area sobre/bajo umbral | Una linea cuyo relleno cambia de color en el nivel del umbral: una tonalidad por encima y otra por debajo, con la linea de referencia marcada. |
| 26 | Pareto doble | Compara dos metricas con el analisis 80/20: barras ordenadas de mayor a menor para cada una y dos lineas de porcentaje acumulado contra la referencia del 80 %. |
| 27 | Gantt con progreso | Cada tarea es una barra de inicio a fin; dentro lleva una barra solida mas delgada que llega hasta donde va el avance real. |
| 28 | Mapa de calor con leyenda | Cuadricula donde el color de cada celda codifica su intensidad, acompanada de una barra de degradado que traduce cada color a un valor numerico. |
| 29 | Embudo con tasas | Barras centradas que se angostan por etapa y, entre cada par, el porcentaje de la etapa anterior que logro avanzar. |
| 30 | Burbujas + cuadrantes con nombre | Burbujas de tamano variable sobre un plano dividido por los promedios en cuatro zonas con nombre; el color de cada burbuja indica la zona en que cae. |
| 31 | Linea multi-eje | Tres lineas en el mismo grafico con dos escalas: las ventas y su promedio movil usan el eje izquierdo y la variacion porcentual usa el derecho. |
| 32 | Cascada con conectores | Barras flotantes encadenadas, unidas por lineas punteadas que llevan el nivel acumulado de una barra a la siguiente, hasta el total. |

---


## Syncfusion

_Comercial, +30 tipos, empresarial_


### Basicas (31)

| # | Grafica | Para que sirve |
|---|---------|----------------|
| 1 | Columnas | Compara cantidades entre categorias con columnas verticales. El tipo mas directo de la libreria, con tooltip incluido. |
| 2 | Spline | Una linea suavizada por curvas (spline) que conecta los puntos de forma fluida, en vez de con segmentos rectos. |
| 3 | Step area | Un area que avanza en escalones: el valor se mantiene constante hasta el siguiente punto, donde salta. |
| 4 | Apiladas 100% | Cada columna llega al 100% y se divide segun el peso relativo de cada serie, mostrando la composicion porcentual. |
| 5 | Range column | Cada columna va de un valor minimo a uno maximo, mostrando el rango de variacion en lugar de un unico valor. |
| 6 | Spline area | Un area con el borde superior suavizado por curvas, uniendo el volumen de un area con la suavidad de un spline. |
| 7 | Fast line | Una linea optimizada para dibujar muchisimos puntos sin perder rendimiento, sacrificando algunos adornos. |
| 8 | Barras horizontales | Barras tumbadas de izquierda a derecha. Syncfusion las ofrece como un tipo propio (BarSeries), distinto de las columnas verticales. |
| 9 | Area con marcadores | Un area rellena con un punto marcado sobre cada dato, uniendo la lectura de volumen con la ubicacion exacta de cada valor. |
| 10 | Linea con etiquetas | Una linea con el valor numerico impreso sobre cada punto, uniendo la tendencia con la cifra exacta. |
| 11 | Columna + linea | Una serie como columnas y otra como linea en el mismo eje, la combinacion mas comun de los reportes empresariales. |
| 12 | Columnas apiladas | Apila las series una sobre otra, mostrando el total de cada periodo y el aporte absoluto de cada parte. |
| 13 | Area apilada | Apila el area de varias series una sobre otra, mostrando el volumen total y el aporte de cada serie a ese total. |
| 14 | Columna + spline | Columnas con una curva spline suave superpuesta, para ver el valor exacto y una tendencia redondeada a la vez. |
| 15 | Dos lineas | Dos lineas en el mismo plano para comparar directamente la evolucion de dos series y la brecha entre ellas. |
| 16 | Columnas agrupadas | Varias columnas juntas por categoria, para comparar varias series dentro de cada periodo lado a lado. |
| 17 | Linea con banda | Una banda de rango (minimo-maximo) sombreada con la linea del valor central encima, delimitando el rango esperado. |
| 18 | Columnas + referencia | Columnas sobre una banda de trazado (PlotBand) que marca una linea de referencia en el eje, para ver quien la supera. |
| 19 | Dispersion | Ubica cada dato como un punto segun dos variables numericas, para ver la relacion entre ellas. Es el ScatterSeries. |
| 20 | Burbuja | Como una dispersion, pero el tamano de cada punto codifica una tercera variable mediante sizeValueMapper. |
| 21 | Step line | Lineas que avanzan en escalones rectos: el valor se mantiene constante hasta que cambia de golpe. Aqui, dos series, una de ellas punteada. |
| 22 | Lineas apiladas | Lineas acumuladas una sobre otra: la altura de cada una es la suma de ella y de las anteriores, y la ultima recorre el total. |
| 23 | Barras horizontales apiladas | Barras tumbadas donde cada una se compone de segmentos apilados: muestra el total por categoria y su desglose por serie. |
| 24 | Area al 100 % | Areas apiladas que siempre ocupan el 100 % del alto: lo que se ve es como cambia el peso relativo de cada serie en el tiempo. |
| 25 | Histograma | Muestra como se distribuyen los valores: se agrupan en intervalos iguales (binInterval) y cada columna cuenta cuantos datos caen en el. La curva roja es la normal equivalente. |
| 26 | Pastel con porcion separada | Un pastel donde una porcion se separa del centro para llamar la atencion: la mayor arranca separada y al tocar otra, esa se separa tambien. |
| 27 | Dona con total al centro | Una dona con una anotacion en su hueco central que muestra el total, aprovechando el espacio libre como indicador. |
| 28 | Columnas con pista | Columnas que se dibujan sobre una pista de fondo que llega al maximo del eje, para leer cada valor como porcentaje de ese tope, con su cifra impresa. |
| 29 | Columnas con degradado | Columnas rellenas con un degradado vertical entre dos colores y esquinas redondeadas, para un acabado mas cuidado. |
| 30 | Dispersion por grupos | Una nube de puntos dividida en dos grupos que se distinguen por su forma (rombo y cuadrado) y por su color. |
| 31 | Sparklines | Mini-graficas sin ejes que resumen la tendencia de un tramo en muy poco espacio, con el maximo en verde y el minimo en rojo, junto a su valor final y variacion. |

### Avanzadas (32)

| # | Grafica | Para que sirve |
|---|---------|----------------|
| 1 | Velas | Cada vela resume cuatro datos de un periodo: maximo, minimo, apertura y cierre, con color segun subio o bajo. |
| 2 | OHLC (hilo) | Variante de las velas que representa los cuatro valores con lineas finas en vez de cuerpos rellenos. |
| 3 | Piramide | Divide un total en niveles apilados de ancho decreciente, mostrando una jerarquia de magnitudes. |
| 4 | Embudo | Muestra como se reduce una cantidad al pasar por etapas sucesivas, con cada nivel mas angosto que el anterior. |
| 5 | Cascada | Barras encadenadas donde cada una parte donde termino la anterior, mostrando el efecto acumulado de sumas y restas. |
| 6 | Medidor | Un medidor radial con zonas de color y una aguja que senala el valor sobre una escala, como un velocimetro. |
| 7 | Spark | Una micro-grafica de tendencia sin ejes ni adornos, que resume una serie en muy poco espacio. |
| 8 | Range area | Un area que ocupa el espacio entre un valor minimo y uno maximo por categoria, mostrando una banda de variacion. |
| 9 | Box and whisker | Resume la distribucion de cada grupo con su mediana, cuartiles y valores atipicos en una caja con bigotes. |
| 10 | Radial de barras | Barras dispuestas en forma de anillos concentricos, cada una con su longitud segun el valor. Es el RadialBarSeries. |
| 11 | Velas + media movil | Velas japonesas con una linea de media movil del cierre encima, que suaviza el ruido y marca la tendencia de fondo. |
| 12 | Embudo piramidal | Un embudo que termina en punta (sin cuello), enfatizando la reduccion progresiva hasta un unico resultado final. |
| 13 | Medidor lineal | Una barra graduada con zonas de color y un marcador en el valor actual, como un termometro horizontal. |
| 14 | Hilo (alto-bajo) | Lineas verticales que van del minimo al maximo de cada periodo, sin apertura ni cierre. Es el HiloSeries. |
| 15 | Dona semicircular | Una dona dibujada solo en media vuelta (startAngle/endAngle), que ocupa menos alto y centra la atencion. |
| 16 | Columnas con error | Columnas con el valor central y una banda de rango superpuesta que representa el margen de error de cada medicion. |
| 17 | Multi-eje | Dos series con escalas muy distintas, cada una referida a su propio eje Y (izquierdo y derecho), en un mismo grafico. |
| 18 | Columnas con seleccion | Columnas donde al tocar una se resalta y las demas se atenuan, mediante el comportamiento de seleccion de la libreria. |
| 19 | Spline con zonas | Una curva spline sobre varias bandas de color de fondo que dividen el eje en zonas (bajo, medio, alto). |
| 20 | Apiladas + total | Columnas apiladas por componente con una linea que recorre el total de cada periodo, uniendo composicion y evolucion del total. |
| 21 | Tendencias | Sobre la nube de puntos se dibujan dos ajustes calculados por la libreria: uno lineal (continuo) y otro polinomico de grado 2 (punteado), sin calcular nada a mano. |
| 22 | Velas + Bollinger | Velas japonesas con dos indicadores tecnicos calculados por la libreria: las bandas de Bollinger (media de 5 periodos mas/menos 2 desviaciones) y una media movil exponencial. |
| 23 | Zoom y paneo | Se puede acercar con dos dedos o con doble toque y desplazar la grafica arrastrando; los botones hacen lo mismo por codigo y devuelven la vista original. |
| 24 | Trackball | Al tocar o arrastrar aparece una linea guia vertical y un globo que agrupa el valor de cada serie en ese punto, sin llenar la grafica de etiquetas. |
| 25 | Anotaciones | Sobre la serie se senalan el maximo y el minimo con un anillo y una etiqueta, y una banda vertical marca un periodo destacado (dias 9 a 17). Todo calculado desde los propios datos. |
| 26 | Eje logaritmico | La misma serie con escala lineal (arriba) y logaritmica base 10 (abajo): cada marca del eje logaritmico multiplica por 10, de modo que valores de magnitud muy distinta se leen a la vez. |
| 27 | Barras de error | Columnas con una barra de error sobre cada una: una linea vertical con tapas que marca el margen de incertidumbre (+/- 12 % del valor). |
| 28 | Progreso circular | Un anillo completo que se va llenando hasta el valor actual (RangePointer) sobre una pista de fondo, con el porcentaje escrito en el centro. |
| 29 | Medidores lineales | Barras de progreso con extremos redondeados (LinearBarPointer) sobre una pista, una por producto, para comparar cuanto del maximo ha alcanzado cada uno. |
| 30 | Sparks de barras y win/loss | Dos micro-graficas distintas: barras con el maximo en verde y el minimo en rojo, y una de ganar/perder donde solo importa el signo de cada valor. |
| 31 | Datos faltantes | La misma serie con tres lecturas ausentes, tratada de tres maneras: dejar un corte (gap), interpolar con el promedio de los vecinos (average) o tomarlas como cero (zero). |
| 32 | Etiquetas multinivel | El eje de categorias muestra una segunda fila de etiquetas que agrupa varias categorias bajo un mismo nombre: aqui, los meses agrupados en trimestres. |

---


## graphic

_Gramatica de graficos, declarativa_


### Basicas (31)

| # | Grafica | Para que sirve |
|---|---------|----------------|
| 1 | Barras | Compara cantidades entre categorias. En graphic una barra es un IntervalMark: un intervalo del eje base al valor. |
| 2 | Puntos | Ubica cada dato como un punto segun dos variables, para ver la relacion entre ellas. Es el PointMark de la gramatica. |
| 3 | Lineas | Une los datos con una linea para mostrar la tendencia. Es el LineMark, que recorre y conecta todos los puntos. |
| 4 | Area | Rellena el espacio bajo la linea para enfatizar el volumen. Es el AreaMark de la gramatica. |
| 5 | Pastel | Un pastel es una barra apilada en coordenadas polares: la gramatica lo compone con Proportion + StackModifier + PolarCoord. |
| 6 | Dona | El mismo pastel pero con un radio interior (startRadius), dejando el centro hueco. |
| 7 | Barras agrupadas | Varias series por categoria, separadas lado a lado con el DodgeModifier, que desplaza las barras para que no se solapen. |
| 8 | Lineas por grupo | Una linea por serie, distinguidas por color mediante un ColorEncode sobre la variable de grupo. |
| 9 | Dispersion coloreada | Puntos coloreados por el grupo al que pertenecen, para ver si los grupos ocupan zonas distintas del plano. |
| 10 | Barras horizontales | Las mismas barras pero con la coordenada transpuesta (RectCoord transposed), que intercambia los ejes. |
| 11 | Puntos por forma | Codifica la categoria de cada punto con su forma (circulo o cuadrado) ademas del color, usando ShapeEncode. |
| 12 | Area + borde | Un area rellena con una linea nitida encima que resalta su contorno, combinando volumen y definicion del limite superior. |
| 13 | Histograma | Barras sin separacion que muestran cuantos datos caen en cada intervalo, revelando la forma de la distribucion. |
| 14 | Burbujas | Puntos que codifican cuatro datos: posicion X, Y, tamano (SizeEncode) y color de grupo (ColorEncode), todo a la vez. |
| 15 | Barras con gradiente | Barras cuyo color va de claro a oscuro segun su valor, usando un ColorEncode continuo sobre la magnitud en vez de por categoria. |
| 16 | Radar | Una linea cerrada en coordenadas polares que forma el poligono del perfil de una entidad en varias dimensiones. |
| 17 | Barras + promedio | Barras con una regla horizontal de promedio superpuesta (anotacion), para ver que categorias estan por encima o debajo. |
| 18 | Treemap | Rectangulos cuya area es proporcional al valor de cada categoria, mostrando la jerarquia de tamanos de un vistazo. |
| 19 | Mapa de calor | Una grilla donde el color de cada celda codifica la intensidad en el cruce de dos dimensiones. Es el uso nativo del PolygonMark. |
| 20 | Linea escalonada | Una linea que avanza en escalones rectos en vez de diagonales, mostrando que el valor se mantiene constante hasta el siguiente cambio. |
| 21 | Step real | Una linea que avanza en escalones rectos: el valor se mantiene constante hasta que cambia de golpe. Se logra con BasicLineShape(stepped: true). |
| 22 | Barras al 100 % | Barras apiladas donde todas miden lo mismo (100 %) y cada segmento muestra su proporcion. La transformacion Proportion, anidada por categoria, calcula la fraccion de cada serie. |
| 23 | Ranking horizontal | Barras tumbadas y ordenadas de mayor a menor (transformacion Sort), de modo que la primera es la lider, con su valor impreso. |
| 24 | Lollipop | Cada valor es un palo delgado que termina en un punto: dice lo mismo que una barra pero con mucha menos tinta. |
| 25 | Area con degradado | Un area cuyo relleno se desvanece de arriba hacia abajo (GradientEncode), con una linea suave encima que marca el contorno. |
| 26 | Dispersion + regresion | A la nube de puntos le suma la recta que mejor la resume (minimos cuadrados), haciendo visible la tendencia y su pendiente. |
| 27 | Barras horizontales apiladas | Barras tumbadas donde cada una se compone de segmentos apilados: muestra el total por categoria y su desglose por serie. |
| 28 | Barras redondeadas | Columnas con las esquinas superiores redondeadas y un ancho fijo, para un acabado suave en lugar de bloques rigidos. |
| 29 | Strip plot | Cada dato es un punto sobre su periodo; el JitterModifier los separa al azar en horizontal para que ninguno quede tapado. |
| 30 | Barras de rango | Barras flotantes que no parten de cero: van del minimo al maximo de cada periodo, mostrando cuanto oscilo el valor. |
| 31 | Mapa de calor con valores | Una grilla coloreada por intensidad que ademas imprime el valor de cada celda, para combinar la vista global con la cifra exacta. |

### Avanzadas (32)

| # | Grafica | Para que sirve |
|---|---------|----------------|
| 1 | Rosa de Nightingale | Barras en coordenadas polares: el radio codifica el valor y cada sector es una categoria. Une la lectura angular del pastel con la magnitud de las barras. |
| 2 | Barras polares apiladas | Barras apiladas llevadas a coordenadas polares: en cada angulo las series se acumulan una sobre otra a lo largo del radio. |
| 3 | Area apilada | Areas de varias series sumadas una sobre otra con StackModifier: la silueta superior es el total y cada franja el aporte de una serie. |
| 4 | Barras apiladas | Barras de varias series acumuladas por categoria con StackModifier, mostrando el total y el peso de cada serie dentro de la barra. |
| 5 | Anillo | Barras radiales (polar transpuesto) que parten de un radio interior; cada categoria es un arco cuya longitud codifica el valor. |
| 6 | Linea suavizada | Una linea con curvatura (BasicLineShape smooth) que redondea las variaciones bruscas de la serie. |
| 7 | Linea + puntos | Dos marcas sobre los mismos datos: una linea de fondo para la tendencia y puntos encima que marcan cada valor medido. |
| 8 | Burbuja | Dispersion donde el tamano del punto (SizeEncode) añade una tercera variable al plano X-Y. |
| 9 | Barras con etiquetas | Barras con el valor escrito encima mediante LabelEncode, que dibuja un texto por cada elemento. |
| 10 | Anillos por serie | Barras polares con Stack + Dodge que forman anillos concentricos, un anillo por serie alrededor del centro. |
| 11 | Barras + tendencia | Dos marcas sobre la misma posicion cat*val: las barras dan la magnitud por categoria y la linea encima resalta la tendencia. |
| 12 | Pastel con % | El pastel clasico (Proportion + Stack + polar) al que se le suma un LabelEncode que escribe el porcentaje calculado sobre cada sector. |
| 13 | Area + puntos | El area transmite el volumen bajo la curva y los puntos encima marcan el valor exacto de cada categoria. |
| 14 | Lineas + puntos por serie | Una linea por serie distinguida por color, con los puntos de cada serie encima para resaltar los valores medidos. |
| 15 | Dispersion tamano + forma | Cada punto codifica cuatro datos: X, Y, tamano (SizeEncode) y una cuarta variable por la FORMA (ShapeEncode), no por color. |
| 16 | Agrupadas + apiladas | Doble modificador en coordenada rectangular: el nest por region separa los grupos (DodgeModifier) y el color por producto apila las capas dentro de cada grupo (StackModifier). |
| 17 | Pastel anidado | Jerarquia en coordenadas polares: un disco interior con las categorias padre y un anillo exterior con su desglose, cada uno un IntervalMark polar superpuesto. |
| 18 | Banda min-max | El AreaMark usa el operador blend (low + high) para pintar una banda entre el minimo y el maximo, y el LineMark traza el valor central. |
| 19 | Radar comparado | Dos poligonos cerrados en coordenadas polares, uno por perfil, distinguidos por color, para comparar dos entidades eje a eje. |
| 20 | Barras divergentes | Valores con signo que crecen a ambos lados del cero; el color codifica el signo para leer de un vistazo ganancias y perdidas. |
| 21 | Area al 100 % | Areas apiladas que siempre llenan el 100 % de la altura: lo que se ve no es el volumen sino como cambia el peso relativo de cada serie. |
| 22 | Cascada | Barras flotantes encadenadas: cada una empieza donde termino la anterior, mostrando como sumas (verde) y restas (rojo) llevan de un inicio a un total (azul). |
| 23 | Velas | Cada vela resume un periodo: el cuerpo va de apertura a cierre (verde si sube, rojo si baja) y la mecha llega al maximo y al minimo. |
| 24 | Gantt | Cada barra horizontal va del inicio al fin de una tarea, mostrando su duracion y como se solapan las fases. |
| 25 | Barras con seleccion | Al tocar una barra, queda resaltada, las demas se atenuan y un globo muestra su categoria y su valor. |
| 26 | Lineas con crosshair | Al tocar o arrastrar sobre la grafica aparece una guia (crosshair) y un globo con el valor de cada serie en ese punto. |
| 27 | Dispersion con brush | Arrastrando el dedo se dibuja un rectangulo de seleccion: los puntos dentro conservan su color y los de fuera se atenuan. |
| 28 | Radar con area | Tres poligonos rellenos en los mismos ejes: dos entidades y su promedio como referencia. El relleno hace visible cuanta superficie domina cada una. |
| 29 | Medidor | Un semicirculo que se llena segun un valor sobre su maximo, imitando un velocimetro, con la cifra en el centro. |
| 30 | Doble eje | Dos series de unidades distintas en una misma grafica: las barras se leen en el eje izquierdo y la linea en un segundo eje a la derecha, con su propia escala. |
| 31 | Diagrama de caja | Resume cada grupo en cinco numeros: minimo y maximo (la mecha), primer y tercer cuartil (la caja) y la mediana (la franja blanca), calculados a partir de los datos. |
| 32 | Anotaciones | Una serie con tres capas de anotacion: una region sombreada que marca un periodo, una linea de promedio y etiquetas de texto ancladas a valores de los datos. |
