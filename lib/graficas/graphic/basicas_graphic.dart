import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import '../../core/lienzo_descrito.dart';

import '../../mock/datos_mock.dart';


// Convierte una lista categoria->valor a la lista de mapas de graphic.
List<Map> _cat(List<PuntoCategoria> datos) =>
    datos.map((p) => {'cat': p.categoria, 'val': p.valor}).toList();

/// Variables comunes para las series categoria->valor.
Map<String, Variable<Map, dynamic>> _varsCat({num? minVal}) => {
      'cat': Variable(accessor: (Map m) => m['cat'] as String),
      'val': Variable(
        accessor: (Map m) => m['val'] as num,
        scale: minVal != null ? LinearScale(min: minVal) : null,
      ),
    };

/// Aplana las series multiples a filas {cat, val, serie}.
List<Map> _seriesPlanas() {
  final datos = <Map>[];
  for (final s in DatosMock.seriesMultiples) {
    for (final p in s.puntos) {
      datos.add({'cat': p.categoria, 'val': p.valor, 'serie': s.nombre});
    }
  }
  return datos;
}
/// 1. Barras (IntervalMark).
class GrBarras extends StatelessWidget {
  const GrBarras({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras',
      paraQue:
          'Compara cantidades entre categorias. En graphic una barra es un '
          'IntervalMark: un intervalo del eje base al valor.',
      cuando:
          'Para comparar valores de categorias independientes: ventas por '
          'mes, cantidades por grupo.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [IntervalMark()],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 2. Puntos (PointMark).
class GrPuntos extends StatelessWidget {
  const GrPuntos({super.key});
  @override
  Widget build(BuildContext context) {
    final datos =
        DatosMock.dispersion.map((p) => {'x': p.x, 'y': p.y}).toList();
    return LienzoDescrito(
      titulo: 'graphic · Puntos',
      paraQue:
          'Ubica cada dato como un punto segun dos variables, para ver la '
          'relacion entre ellas. Es el PointMark de la gramatica.',
      cuando:
          'Para analizar correlacion entre dos medidas numericas.',
      grafica: Chart(
        data: datos,
        variables: {
          'x': Variable(accessor: (Map m) => m['x'] as num),
          'y': Variable(accessor: (Map m) => m['y'] as num),
        },
        marks: [PointMark()],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 3. Lineas (LineMark).
class GrLineas extends StatelessWidget {
  const GrLineas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Lineas',
      paraQue:
          'Une los datos con una linea para mostrar la tendencia. Es el '
          'LineMark, que recorre y conecta todos los puntos.',
      cuando:
          'Para evoluciones continuas: valores a lo largo del tiempo o de '
          'una secuencia ordenada.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [LineMark()],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 4. Area (AreaMark).
class GrArea extends StatelessWidget {
  const GrArea({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Area',
      paraQue:
          'Rellena el espacio bajo la linea para enfatizar el volumen. Es el '
          'AreaMark de la gramatica.',
      cuando:
          'Cuando ademas de la tendencia importa el volumen acumulado bajo '
          'la curva.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [AreaMark()],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 5. Pastel (IntervalMark + Proportion + PolarCoord).
class GrPastel extends StatelessWidget {
  const GrPastel({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Pastel',
      paraQue:
          'Un pastel es una barra apilada en coordenadas polares: la '
          'gramatica lo compone con Proportion + StackModifier + PolarCoord.',
      cuando:
          'Para mostrar el reparto porcentual de un total entre pocas '
          'categorias.',
      grafica: Chart(
        data: _cat(DatosMock.cuotaMercado),
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(accessor: (Map m) => m['val'] as num),
        },
        transforms: [Proportion(variable: 'val', as: 'percent')],
        marks: [
          IntervalMark(
            position: Varset('percent') / Varset('cat'),
            color: ColorEncode(variable: 'cat', values: Defaults.colors10),
            modifiers: [StackModifier()],
          ),
        ],
        coord: PolarCoord(transposed: true, dimCount: 1),
      ),
    );
  }
}

/// 6. Dona (pastel con radio interno).
class GrDona extends StatelessWidget {
  const GrDona({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Dona',
      paraQue:
          'El mismo pastel pero con un radio interior (startRadius), dejando '
          'el centro hueco.',
      cuando:
          'La misma lectura de proporcion que el pastel, con estilo mas '
          'moderno.',
      grafica: Chart(
        data: _cat(DatosMock.cuotaMercado),
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(accessor: (Map m) => m['val'] as num),
        },
        transforms: [Proportion(variable: 'val', as: 'percent')],
        marks: [
          IntervalMark(
            position: Varset('percent') / Varset('cat'),
            color: ColorEncode(variable: 'cat', values: Defaults.colors10),
            modifiers: [StackModifier()],
          ),
        ],
        coord: PolarCoord(transposed: true, dimCount: 1, startRadius: 0.4),
      ),
    );
  }
}

/// 7. Barras agrupadas por color (DodgeModifier).
class GrBarrasAgrupadas extends StatelessWidget {
  const GrBarrasAgrupadas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras agrupadas',
      paraQue:
          'Varias series por categoria, separadas lado a lado con el '
          'DodgeModifier, que desplaza las barras para que no se solapen.',
      cuando:
          'Para comparar varios elementos dentro de cada categoria.',
      grafica: Chart(
        data: _seriesPlanas(),
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
          'serie': Variable(accessor: (Map m) => m['serie'] as String),
        },
        marks: [
          IntervalMark(
            position: Varset('cat') * Varset('val'),
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
            modifiers: [DodgeModifier()],
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 8. Lineas por grupo.
class GrLineasGrupo extends StatelessWidget {
  const GrLineasGrupo({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Lineas por grupo',
      paraQue:
          'Una linea por serie, distinguidas por color mediante un '
          'ColorEncode sobre la variable de grupo.',
      cuando:
          'Para comparar la evolucion de varias series en el mismo plano.',
      grafica: Chart(
        data: _seriesPlanas(),
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
          'serie': Variable(accessor: (Map m) => m['serie'] as String),
        },
        marks: [
          LineMark(
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 9. Dispersion coloreada por categoria.
class GrDispersionColor extends StatelessWidget {
  const GrDispersionColor({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion
        .map((p) => {'x': p.x, 'y': p.y, 'grupo': p.y > 50 ? 'Alto' : 'Bajo'})
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Dispersion coloreada',
      paraQue:
          'Puntos coloreados por el grupo al que pertenecen, para ver si los '
          'grupos ocupan zonas distintas del plano.',
      cuando:
          'Cuando se analiza la relacion entre dos variables y se comparan '
          'categorias a la vez.',
      grafica: Chart(
        data: datos,
        variables: {
          'x': Variable(accessor: (Map m) => m['x'] as num),
          'y': Variable(accessor: (Map m) => m['y'] as num),
          'grupo': Variable(accessor: (Map m) => m['grupo'] as String),
        },
        marks: [
          PointMark(
            color: ColorEncode(variable: 'grupo', values: Defaults.colors10),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 10. Barras horizontales (coordenada transpuesta).
class GrBarrasHorizontales extends StatelessWidget {
  const GrBarrasHorizontales({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras horizontales',
      paraQue:
          'Las mismas barras pero con la coordenada transpuesta '
          '(RectCoord transposed), que intercambia los ejes.',
      cuando:
          'Cuando las etiquetas de categoria son largas y necesitan espacio '
          'horizontal.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [IntervalMark()],
        coord: RectCoord(transposed: true),
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
/// 11. Puntos con forma por categoria (ShapeEncode).
class GrPuntosForma extends StatelessWidget {
  const GrPuntosForma({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion
        .map((p) => {'x': p.x, 'y': p.y, 'grupo': p.y > 50 ? 'Alto' : 'Bajo'})
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Puntos por forma',
      paraQue:
          'Codifica la categoria de cada punto con su forma (circulo o '
          'cuadrado) ademas del color, usando ShapeEncode.',
      cuando:
          'Cuando los grupos deben distinguirse sin depender solo del color, '
          'util para accesibilidad o impresion en blanco y negro.',
      grafica: Chart(
        data: datos,
        variables: {
          'x': Variable(accessor: (Map m) => m['x'] as num),
          'y': Variable(accessor: (Map m) => m['y'] as num),
          'grupo': Variable(accessor: (Map m) => m['grupo'] as String),
        },
        marks: [
          PointMark(
            shape: ShapeEncode(
              variable: 'grupo',
              values: [CircleShape(), SquareShape()],
            ),
            color: ColorEncode(variable: 'grupo', values: Defaults.colors10),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 12. Area + linea de borde.
class GrAreaBorde extends StatelessWidget {
  const GrAreaBorde({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Area + borde',
      paraQue:
          'Un area rellena con una linea nitida encima que resalta su '
          'contorno, combinando volumen y definicion del limite superior.',
      cuando:
          'Cuando el relleno transmite magnitud pero se quiere un borde claro '
          'para seguir la tendencia con precision.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [
          AreaMark(),
          LineMark(size: SizeEncode(value: 2)),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 13. Histograma (barras pegadas por intervalo).
class GrHistograma extends StatelessWidget {
  const GrHistograma({super.key});
  @override
  Widget build(BuildContext context) {
    // Agrupa la distribucion en 6 intervalos de ancho 17 (0-100).
    final valores = DatosMock.distribucion;
    final conteo = List<int>.filled(6, 0);
    for (final v in valores) {
      final i = (v / 17).floor().clamp(0, 5);
      conteo[i]++;
    }
    final datos = [
      for (int i = 0; i < 6; i++)
        {'rango': '${i * 17}-${(i + 1) * 17}', 'freq': conteo[i]},
    ];
    return LienzoDescrito(
      titulo: 'graphic · Histograma',
      paraQue:
          'Barras sin separacion que muestran cuantos datos caen en cada '
          'intervalo, revelando la forma de la distribucion.',
      cuando:
          'Para ver como se reparten los valores de una variable continua: '
          'notas, edades, tiempos de respuesta.',
      grafica: Chart(
        data: datos,
        variables: {
          'rango': Variable(accessor: (Map m) => m['rango'] as String),
          'freq': Variable(
              accessor: (Map m) => m['freq'] as num,
              scale: LinearScale(min: 0)),
        },
        marks: [IntervalMark(size: SizeEncode(value: 40))],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 14. Burbujas (tamano + color codificados).
class GrBurbujas extends StatelessWidget {
  const GrBurbujas({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion
        .map((p) => {
              'x': p.x,
              'y': p.y,
              't': p.tamano,
              'grupo': p.y > 50 ? 'Alto' : 'Bajo',
            })
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Burbujas',
      paraQue:
          'Puntos que codifican cuatro datos: posicion X, Y, tamano '
          '(SizeEncode) y color de grupo (ColorEncode), todo a la vez.',
      cuando:
          'Para analisis multivariable donde cada elemento tiene dos '
          'coordenadas, un peso y una categoria.',
      grafica: Chart(
        data: datos,
        variables: {
          'x': Variable(accessor: (Map m) => m['x'] as num),
          'y': Variable(accessor: (Map m) => m['y'] as num),
          't': Variable(accessor: (Map m) => m['t'] as num),
          'grupo': Variable(accessor: (Map m) => m['grupo'] as String),
        },
        marks: [
          PointMark(
            size: SizeEncode(variable: 't', values: [4, 24]),
            color: ColorEncode(variable: 'grupo', values: Defaults.colors10),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 15. Barras con gradiente de color por valor (ColorEncode continuo).
class GrBarrasGradiente extends StatelessWidget {
  const GrBarrasGradiente({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras con gradiente',
      paraQue:
          'Barras cuyo color va de claro a oscuro segun su valor, usando un '
          'ColorEncode continuo sobre la magnitud en vez de por categoria.',
      cuando:
          'Cuando el color debe reforzar la magnitud: resaltar los valores '
          'mas altos con un tono mas intenso de un vistazo.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
        },
        marks: [
          IntervalMark(
            color: ColorEncode(
              variable: 'val',
              values: [Colors.blue.shade100, Colors.blue.shade900],
            ),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 16. Radar (linea en coordenadas polares).
class GrRadar extends StatelessWidget {
  const GrRadar({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.perfilRadar
        .map((e) => {'eje': e.eje, 'val': e.valor})
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Radar',
      paraQue:
          'Una linea cerrada en coordenadas polares que forma el poligono '
          'del perfil de una entidad en varias dimensiones.',
      cuando:
          'Para evaluar una entidad en varios criterios a la vez: '
          'habilidades, caracteristicas, competencias.',
      grafica: Chart(
        data: datos,
        variables: {
          'eje': Variable(accessor: (Map m) => m['eje'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0, max: 100)),
        },
        marks: [
          LineMark(
            shape: ShapeEncode(value: BasicLineShape(loop: true)),
            color: ColorEncode(value: Defaults.colors10.first),
          ),
          PointMark(
            color: ColorEncode(value: Defaults.colors10.first),
          ),
        ],
        coord: PolarCoord(),
        axes: [Defaults.circularAxis, Defaults.radialAxis],
      ),
    );
  }
}

/// 17. Barras + regla de promedio (anotacion).
class GrBarrasPromedio extends StatelessWidget {
  const GrBarrasPromedio({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final promedio =
        datos.map((p) => p.valor).reduce((a, b) => a + b) / datos.length;
    return LienzoDescrito(
      titulo: 'graphic · Barras + promedio',
      paraQue:
          'Barras con una regla horizontal de promedio superpuesta '
          '(anotacion), para ver que categorias estan por encima o debajo.',
      cuando:
          'Cuando los valores se juzgan contra una referencia: media, meta, '
          'umbral aceptable.',
      grafica: Chart(
        data: _cat(datos),
        variables: _varsCat(minVal: 0),
        marks: [IntervalMark()],
        annotations: [
          LineAnnotation(
            dim: Dim.y,
            value: promedio,
            style: PaintStyle(
              strokeColor: Colors.red,
              strokeWidth: 2,
              dash: [6, 4],
            ),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 18. Treemap (rectangulos de area proporcional).
///
/// graphic no tiene un mark de treemap de areas libres (su PolygonMark es
/// para heatmaps en grilla). Por eso este treemap se dibuja a mano con
/// Widgets dentro del lienzo de la pantalla.
class GrTreemap extends StatelessWidget {
  const GrTreemap({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = [...DatosMock.cuotaMercado]
      ..sort((a, b) => b.valor.compareTo(a.valor));
    return LienzoDescrito(
      titulo: 'graphic · Treemap',
      paraQue:
          'Rectangulos cuya area es proporcional al valor de cada categoria, '
          'mostrando la jerarquia de tamanos de un vistazo.',
      cuando:
          'Cuando hay muchas categorias de tamanos muy distintos y el pastel '
          'quedaria ilegible: participacion de mercado, uso de disco.',
      grafica: _TreemapWidget(datos: datos),
    );
  }
}

class _TreemapWidget extends StatelessWidget {
  final List<PuntoCategoria> datos;
  const _TreemapWidget({required this.datos});

  @override
  Widget build(BuildContext context) {
    final colores = Defaults.colors10;
    return LayoutBuilder(
      builder: (context, cons) {
        final total = datos.fold<double>(0, (s, d) => s + d.valor);
        // Treemap simple en franjas horizontales proporcionales al valor.
        final hijos = <Widget>[];
        double yUsado = 0;
        for (int i = 0; i < datos.length; i++) {
          final frac = datos[i].valor / total;
          final alto = frac * cons.maxHeight;
          hijos.add(Positioned(
            top: yUsado,
            left: 0,
            width: cons.maxWidth,
            height: alto,
            child: Container(
              margin: const EdgeInsets.all(1),
              color: colores[i % colores.length],
              alignment: Alignment.center,
              child: Text(
                '${datos[i].categoria}\n${datos[i].valor.toInt()}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ));
          yUsado += alto;
        }
        return Stack(children: hijos);
      },
    );
  }
}

/// 19. Mapa de calor (PolygonMark en grilla).
class GrMapaCalor extends StatelessWidget {
  const GrMapaCalor({super.key});
  @override
  Widget build(BuildContext context) {
    // Submatriz 7 dias x 8 horas; PolygonMark dibuja la grilla coloreada.
    final datos = DatosMock.matrizCalor
        .where((c) => c.x < 8)
        .map((c) => {
              'hora': c.x.toString(),
              'dia': c.y.toString(),
              'valor': c.intensidad,
            })
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Mapa de calor',
      paraQue:
          'Una grilla donde el color de cada celda codifica la intensidad en '
          'el cruce de dos dimensiones. Es el uso nativo del PolygonMark.',
      cuando:
          'Para ver patrones en dos dimensiones categoricas: actividad por '
          'dia y hora, correlaciones, frecuencias cruzadas.',
      grafica: Chart(
        data: datos,
        variables: {
          'hora': Variable(accessor: (Map m) => m['hora'] as String),
          'dia': Variable(accessor: (Map m) => m['dia'] as String),
          'valor': Variable(accessor: (Map m) => m['valor'] as num),
        },
        marks: [
          PolygonMark(
            color: ColorEncode(
              variable: 'valor',
              values: [Colors.blue.shade50, Colors.blue.shade900],
            ),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 20. Linea escalonada (step).
class GrLineaEscalonada extends StatelessWidget {
  const GrLineaEscalonada({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Linea escalonada',
      paraQue:
          'Una linea que avanza en escalones rectos en vez de diagonales, '
          'mostrando que el valor se mantiene constante hasta el siguiente '
          'cambio.',
      cuando:
          'Para valores que cambian en saltos discretos: tarifas por tramos, '
          'niveles de stock, estados que se mantienen entre eventos.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [
          LineMark(
            shape: ShapeEncode(value: BasicLineShape(smooth: true)),
          ),
          PointMark(),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
/// 21. Linea escalonada real (step).
/// BasicLineShape(stepped: true) dibuja escalones rectos. La "Linea
/// escalonada" que ya existe usa smooth: true, que es una curva suave.
class GrStepReal extends StatelessWidget {
  const GrStepReal({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Step real',
      paraQue:
          'Una linea que avanza en escalones rectos: el valor se mantiene '
          'constante hasta que cambia de golpe. Se logra con '
          'BasicLineShape(stepped: true).',
      cuando:
          'Para magnitudes que cambian por saltos y se sostienen entre '
          'cambios: tarifas por tramos, niveles de stock, estados.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [
          LineMark(
            shape: ShapeEncode(value: BasicLineShape(stepped: true)),
            size: SizeEncode(value: 2),
          ),
          PointMark(size: SizeEncode(value: 6)),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 22. Barras apiladas al 100 %.
/// Proportion con nest convierte cada valor en su fraccion del total de
/// la categoria; el eje muestra porcentajes.
class GrBarras100 extends StatelessWidget {
  const GrBarras100({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras al 100 %',
      paraQue:
          'Barras apiladas donde todas miden lo mismo (100 %) y cada '
          'segmento muestra su proporcion. La transformacion Proportion, '
          'anidada por categoria, calcula la fraccion de cada serie.',
      cuando:
          'Cuando importa la composicion y no el volumen: como cambia el '
          'peso de cada producto entre periodos.',
      grafica: Chart(
        data: _seriesPlanas(),
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(accessor: (Map m) => m['val'] as num),
          'serie': Variable(accessor: (Map m) => m['serie'] as String),
        },
        transforms: [
          Proportion(
            variable: 'val',
            nest: Varset('cat'),
            as: 'percent',
            scale: LinearScale(
              min: 0,
              max: 1,
              formatter: (v) => '${(v * 100).round()}%',
            ),
          ),
        ],
        marks: [
          IntervalMark(
            position: Varset('cat') * Varset('percent'),
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
            modifiers: [StackModifier()],
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 23. Ranking horizontal ordenado.
/// La transformacion Sort ordena las categorias de mayor a menor y la
/// coordenada transpuesta las tumba, con el valor impreso en cada barra.
class GrRanking extends StatelessWidget {
  const GrRanking({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Ranking horizontal',
      paraQue:
          'Barras tumbadas y ordenadas de mayor a menor (transformacion '
          'Sort), de modo que la primera es la lider, con su valor impreso.',
      cuando:
          'Para clasificaciones: productos mas vendidos, regiones por '
          'ingresos, cualquier lista donde el orden es el mensaje.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        transforms: [
          Sort(
            compare: (a, b) => (b['val'] as num).compareTo(a['val'] as num),
          ),
        ],
        marks: [
          IntervalMark(
            color: ColorEncode(
              variable: 'val',
              values: [Colors.blue.shade200, Colors.blue.shade800],
            ),
            label: LabelEncode(
              encoder: (tuple) => Label(
                (tuple['val'] as num).toStringAsFixed(0),
                LabelStyle(textStyle: const TextStyle(fontSize: 11)),
              ),
            ),
          ),
        ],
        // verticalRange invertido: la primera categoria queda arriba.
        coord: RectCoord(transposed: true, verticalRange: [1, 0]),
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 24. Lollipop (paleta).
/// Combina dos marcas sobre la misma posicion: un IntervalMark muy
/// delgado (el palo) y un PointMark (el caramelo).
class GrLollipop extends StatelessWidget {
  const GrLollipop({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Defaults.colors10.first;
    return LienzoDescrito(
      titulo: 'graphic · Lollipop',
      paraQue:
          'Cada valor es un palo delgado que termina en un punto: dice lo '
          'mismo que una barra pero con mucha menos tinta.',
      cuando:
          'Cuando hay muchas categorias y las barras gruesas saturarian '
          'la vista, o cuando el valor puntual es lo importante.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [
          IntervalMark(
            size: SizeEncode(value: 3),
            color: ColorEncode(value: color.withValues(alpha: 0.6)),
          ),
          PointMark(
            size: SizeEncode(value: 14),
            color: ColorEncode(value: color),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 25. Area con degradado.
/// GradientEncode rellena el area con un degradado vertical que se
/// desvanece hacia abajo, con una linea nitida encima.
class GrAreaDegradado extends StatelessWidget {
  const GrAreaDegradado({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Defaults.colors10.first;
    final datos = <Map>[
      for (int i = 0; i < DatosMock.serieTemporal.length; i++)
        {'i': i, 'val': DatosMock.serieTemporal[i].valor},
    ];
    return LienzoDescrito(
      titulo: 'graphic · Area con degradado',
      paraQue:
          'Un area cuyo relleno se desvanece de arriba hacia abajo '
          '(GradientEncode), con una linea suave encima que marca el '
          'contorno.',
      cuando:
          'Para tableros y pantallas de inicio donde el acabado visual '
          'importa y la tendencia debe leerse de un vistazo.',
      grafica: Chart(
        data: datos,
        variables: {
          'i': Variable(accessor: (Map m) => m['i'] as num),
          'val': Variable(
            accessor: (Map m) => m['val'] as num,
            scale: LinearScale(min: 0, max: 100),
          ),
        },
        marks: [
          AreaMark(
            shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
            gradient: GradientEncode(
              value: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withValues(alpha: 0.5),
                  color.withValues(alpha: 0.02),
                ],
              ),
            ),
          ),
          LineMark(
            shape: ShapeEncode(value: BasicLineShape(smooth: true)),
            size: SizeEncode(value: 2),
            color: ColorEncode(value: color),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 26. Dispersion con recta de regresion.
/// La recta de minimos cuadrados se calcula con los datos y se agrega a
/// cada fila como una variable mas, que un LineMark dibuja.
class GrDispersionRegresion extends StatelessWidget {
  const GrDispersionRegresion({super.key});
  @override
  Widget build(BuildContext context) {
    final pts = DatosMock.dispersion;
    final n = pts.length;
    final sumX = pts.fold<double>(0, (s, p) => s + p.x);
    final sumY = pts.fold<double>(0, (s, p) => s + p.y);
    final sumXY = pts.fold<double>(0, (s, p) => s + p.x * p.y);
    final sumX2 = pts.fold<double>(0, (s, p) => s + p.x * p.x);
    final m = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    final b = (sumY - m * sumX) / n;
    final datos = <Map>[
      for (final p in pts)
        {
          'x': p.x,
          'y': p.y,
          'ajuste': (m * p.x + b).clamp(0, 100).toDouble(),
        },
    ]..sort((a, c) => (a['x'] as num).compareTo(c['x'] as num));
    // 'y' y 'ajuste' deben compartir escala para que la recta cuadre.
    Variable<Map, num> vy(String k) => Variable(
          accessor: (Map map) => map[k] as num,
          scale: LinearScale(min: 0, max: 100),
        );
    return LienzoDescrito(
      titulo: 'graphic · Dispersion + regresion',
      paraQue:
          'A la nube de puntos le suma la recta que mejor la resume '
          '(minimos cuadrados), haciendo visible la tendencia y su '
          'pendiente.',
      cuando:
          'Cuando se quiere cuantificar la relacion entre dos variables: '
          'direccion, fuerza y puntos que se alejan de la recta.',
      grafica: Chart(
        data: datos,
        variables: {
          'x': Variable(
            accessor: (Map map) => map['x'] as num,
            scale: LinearScale(min: 0, max: 100),
          ),
          'y': vy('y'),
          'ajuste': vy('ajuste'),
        },
        marks: [
          PointMark(
            position: Varset('x') * Varset('y'),
            color: ColorEncode(
                value: Defaults.colors10.first.withValues(alpha: 0.6)),
          ),
          LineMark(
            position: Varset('x') * Varset('ajuste'),
            size: SizeEncode(value: 2.5),
            color: ColorEncode(value: Colors.redAccent),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 27. Barras horizontales apiladas.
/// Combina el apilado (StackModifier) con la coordenada transpuesta.
class GrBarrasHorizApiladas extends StatelessWidget {
  const GrBarrasHorizApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras horizontales apiladas',
      paraQue:
          'Barras tumbadas donde cada una se compone de segmentos '
          'apilados: muestra el total por categoria y su desglose por '
          'serie.',
      cuando:
          'Cuando hay etiquetas largas o muchas categorias y ademas '
          'importa la composicion: ventas por canal en cada region.',
      grafica: Chart(
        data: _seriesPlanas(),
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
            accessor: (Map m) => m['val'] as num,
            scale: LinearScale(min: 0),
          ),
          'serie': Variable(accessor: (Map m) => m['serie'] as String),
        },
        marks: [
          IntervalMark(
            position: Varset('cat') * Varset('val'),
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
            modifiers: [StackModifier()],
          ),
        ],
        coord: RectCoord(transposed: true, verticalRange: [1, 0]),
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 28. Barras redondeadas.
/// RectShape con borderRadius redondea las esquinas superiores de cada
/// barra, que ademas se hace mas angosta con SizeEncode.
class GrBarrasRedondeadas extends StatelessWidget {
  const GrBarrasRedondeadas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras redondeadas',
      paraQue:
          'Columnas con las esquinas superiores redondeadas y un ancho '
          'fijo, para un acabado suave en lugar de bloques rigidos.',
      cuando:
          'En apps de estilo moderno con pocas categorias, donde la '
          'estetica pesa tanto como la lectura.',
      grafica: Chart(
        data: _cat(DatosMock.ventasMensuales),
        variables: _varsCat(minVal: 0),
        marks: [
          IntervalMark(
            size: SizeEncode(value: 26),
            shape: ShapeEncode(
              value: RectShape(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
              ),
            ),
            color: ColorEncode(value: Defaults.colors10[3]),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 29. Strip plot (puntos con jitter).
/// Muestra todos los datos de cada periodo como puntos y el
/// JitterModifier los dispersa horizontalmente para que no se tapen.
class GrStripJitter extends StatelessWidget {
  const GrStripJitter({super.key});
  @override
  Widget build(BuildContext context) {
    final d = DatosMock.serieTemporal;
    final datos = <Map>[
      for (int i = 0; i < d.length; i++)
        {
          'periodo': i < 10 ? 'Dias 1-10' : (i < 20 ? 'Dias 11-20' : 'Dias 21-30'),
          'val': d[i].valor,
        },
    ];
    return LienzoDescrito(
      titulo: 'graphic · Strip plot',
      paraQue:
          'Cada dato es un punto sobre su periodo; el JitterModifier los '
          'separa al azar en horizontal para que ninguno quede tapado.',
      cuando:
          'Para comparar la distribucion de varios grupos mostrando todos '
          'los datos, sin resumirlos: pocos puntos por grupo.',
      grafica: Chart(
        data: datos,
        variables: {
          'periodo': Variable(accessor: (Map m) => m['periodo'] as String),
          'val': Variable(
            accessor: (Map m) => m['val'] as num,
            scale: LinearScale(min: 0, max: 100),
          ),
        },
        marks: [
          PointMark(
            position: Varset('periodo') * Varset('val'),
            size: SizeEncode(value: 7),
            color: ColorEncode(variable: 'periodo', values: Defaults.colors10),
            modifiers: [JitterModifier()],
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 30. Barras de rango (minimo-maximo).
/// El operador blend (min + max) dibuja un IntervalMark flotante que va
/// del minimo al maximo de cada periodo.
class GrBarrasRango extends StatelessWidget {
  const GrBarrasRango({super.key});
  @override
  Widget build(BuildContext context) {
    final d = DatosMock.serieTemporal;
    List<Map> tramo(String nombre, int desde, int hasta) {
      final v = d.sublist(desde, hasta).map((p) => p.valor).toList();
      return [
        {
          'periodo': nombre,
          'min': v.reduce((a, b) => a < b ? a : b),
          'max': v.reduce((a, b) => a > b ? a : b),
        }
      ];
    }
 
    final datos = <Map>[
      ...tramo('Dias 1-10', 0, 10),
      ...tramo('Dias 11-20', 10, 20),
      ...tramo('Dias 21-30', 20, 30),
    ];
    Variable<Map, num> esc(String k) => Variable(
          accessor: (Map m) => m[k] as num,
          scale: LinearScale(min: 0, max: 100),
        );
    return LienzoDescrito(
      titulo: 'graphic · Barras de rango',
      paraQue:
          'Barras flotantes que no parten de cero: van del minimo al '
          'maximo de cada periodo, mostrando cuanto oscilo el valor.',
      cuando:
          'Para variacion dentro de cada periodo: temperaturas minima y '
          'maxima, rango de precios, dispersion de mediciones.',
      grafica: Chart(
        data: datos,
        variables: {
          'periodo': Variable(accessor: (Map m) => m['periodo'] as String),
          'min': esc('min'),
          'max': esc('max'),
        },
        marks: [
          IntervalMark(
            position: Varset('periodo') * (Varset('min') + Varset('max')),
            size: SizeEncode(value: 36),
            color: ColorEncode(variable: 'periodo', values: Defaults.colors10),
            label: LabelEncode(
              encoder: (tuple) => Label(
                '${(tuple['min'] as num).toStringAsFixed(0)} - '
                '${(tuple['max'] as num).toStringAsFixed(0)}',
                LabelStyle(textStyle: const TextStyle(fontSize: 11)),
              ),
            ),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 31. Mapa de calor con valores.
/// El mapa de calor de siempre (PolygonMark) con el numero de cada celda
/// escrito encima, para leer el dato exacto ademas del color.
class GrMapaCalorValores extends StatelessWidget {
  const GrMapaCalorValores({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.matrizCalor
        .where((c) => c.x < 8)
        .map((c) => {
              'hora': c.x.toString(),
              'dia': c.y.toString(),
              'valor': c.intensidad,
            })
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Mapa de calor con valores',
      paraQue:
          'Una grilla coloreada por intensidad que ademas imprime el valor '
          'de cada celda, para combinar la vista global con la cifra '
          'exacta.',
      cuando:
          'Cuando el patron general importa pero tambien se consultan '
          'celdas concretas: actividad por dia y hora, matrices de '
          'correlacion.',
      grafica: Chart(
        data: datos,
        variables: {
          'hora': Variable(accessor: (Map m) => m['hora'] as String),
          'dia': Variable(accessor: (Map m) => m['dia'] as String),
          'valor': Variable(accessor: (Map m) => m['valor'] as num),
        },
        marks: [
          PolygonMark(
            color: ColorEncode(
              variable: 'valor',
              values: [Colors.blue.shade50, Colors.blue.shade900],
            ),
            label: LabelEncode(
              encoder: (tuple) => Label(
                (tuple['valor'] as num).toStringAsFixed(0),
                LabelStyle(
                  textStyle: const TextStyle(fontSize: 9, color: Colors.black87),
                ),
              ),
            ),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}