import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../../core/lienzo_descrito.dart';
import '../../mock/datos_mock.dart';

// ============================================================
// graphic — 20 GRAFICAS AVANZADAS
// Composiciones que aprovechan la gramatica: coordenadas polares,
// apilados, modificadores y marcas combinadas. Son el fuerte de
// graphic frente a librerias de tipos prefabricados. Cada grafica
// se envuelve en LienzoDescrito, que muestra para que sirve y
// cuando conviene usarla, igual que las basicas.
// ============================================================

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

/// 1. Rosa de Nightingale (barras polares).
class GrRosa extends StatelessWidget {
  const GrRosa({super.key});
  @override
  Widget build(BuildContext context) {
    final datos =
        DatosMock.ventasMensuales.map((p) => {'cat': p.categoria, 'val': p.valor}).toList();
    return LienzoDescrito(
      titulo: 'graphic · Rosa de Nightingale',
      paraQue:
          'Barras en coordenadas polares: el radio codifica el valor y cada '
          'sector es una categoria. Une la lectura angular del pastel con la '
          'magnitud de las barras.',
      cuando:
          'Para datos ciclicos o estacionales donde se comparan magnitudes '
          'alrededor de un ciclo: meses, direcciones, franjas horarias.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
        },
        marks: [
          IntervalMark(
            color: ColorEncode(variable: 'cat', values: Defaults.colors10),
          ),
        ],
        coord: PolarCoord(),
        axes: [Defaults.circularAxis, Defaults.radialAxis],
      ),
    );
  }
}

/// 2. Barras polares apiladas (radar de barras).
class GrPolarApiladas extends StatelessWidget {
  const GrPolarApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras polares apiladas',
      paraQue:
          'Barras apiladas llevadas a coordenadas polares: en cada angulo las '
          'series se acumulan una sobre otra a lo largo del radio.',
      cuando:
          'Para comparar la composicion de varias series en un eje categorico '
          'dispuesto en circulo.',
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
            modifiers: [StackModifier()],
          ),
        ],
        coord: PolarCoord(),
        axes: [Defaults.circularAxis, Defaults.radialAxis],
      ),
    );
  }
}

/// 3. Area apilada.
class GrAreaApilada extends StatelessWidget {
  const GrAreaApilada({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Area apilada',
      paraQue:
          'Areas de varias series sumadas una sobre otra con StackModifier: la '
          'silueta superior es el total y cada franja el aporte de una serie.',
      cuando:
          'Para ver como se reparte un total entre varias series a lo largo de '
          'las categorias.',
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
          AreaMark(
            position: Varset('cat') * Varset('val'),
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
            modifiers: [StackModifier()],
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 4. Barras apiladas por color.
class GrBarrasApiladas extends StatelessWidget {
  const GrBarrasApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Barras apiladas',
      paraQue:
          'Barras de varias series acumuladas por categoria con StackModifier, '
          'mostrando el total y el peso de cada serie dentro de la barra.',
      cuando:
          'Para comparar el total por categoria y a la vez la contribucion de '
          'cada serie.',
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
            modifiers: [StackModifier()],
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 5. Anillo (barras radiales concentricas).
class GrAnillo extends StatelessWidget {
  const GrAnillo({super.key});
  @override
  Widget build(BuildContext context) {
    final datos =
        DatosMock.perfilRadar.map((e) => {'cat': e.eje, 'val': e.valor}).toList();
    return LienzoDescrito(
      titulo: 'graphic · Anillo',
      paraQue:
          'Barras radiales (polar transpuesto) que parten de un radio interior; '
          'cada categoria es un arco cuya longitud codifica el valor.',
      cuando:
          'Para mostrar magnitudes por categoria con un estilo circular y '
          'compacto.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0, max: 100)),
        },
        marks: [
          IntervalMark(
            color: ColorEncode(variable: 'cat', values: Defaults.colors10),
          ),
        ],
        coord: PolarCoord(transposed: true, startRadius: 0.2),
        axes: [Defaults.circularAxis],
      ),
    );
  }
}

/// 6. Linea suavizada.
class GrLineaSuave extends StatelessWidget {
  const GrLineaSuave({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = <Map>[];
    for (int i = 0; i < DatosMock.serieTemporal.length; i++) {
      datos.add({'i': i, 'val': DatosMock.serieTemporal[i].valor});
    }
    return LienzoDescrito(
      titulo: 'graphic · Linea suavizada',
      paraQue:
          'Una linea con curvatura (BasicLineShape smooth) que redondea las '
          'variaciones bruscas de la serie.',
      cuando:
          'Para series con ruido donde interesa la tendencia general mas que '
          'el detalle de cada punto.',
      grafica: Chart(
        data: datos,
        variables: {
          'i': Variable(accessor: (Map m) => m['i'] as num),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0, max: 100)),
        },
        marks: [
          LineMark(shape: ShapeEncode(value: BasicLineShape(smooth: true))),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 7. Linea + puntos superpuestos (dos marcas).
class GrLineaPuntos extends StatelessWidget {
  const GrLineaPuntos({super.key});
  @override
  Widget build(BuildContext context) {
    final datos =
        DatosMock.ventasMensuales.map((p) => {'cat': p.categoria, 'val': p.valor}).toList();
    return LienzoDescrito(
      titulo: 'graphic · Linea + puntos',
      paraQue:
          'Dos marcas sobre los mismos datos: una linea de fondo para la '
          'tendencia y puntos encima que marcan cada valor medido.',
      cuando:
          'Para seguir la evolucion y a la vez destacar cada dato concreto.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
        },
        // Dos marcas en la misma grafica: linea de fondo y puntos encima.
        marks: [
          LineMark(),
          PointMark(),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 8. Dispersion con tamano variable (burbuja).
class GrBurbuja extends StatelessWidget {
  const GrBurbuja({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion
        .map((p) => {'x': p.x, 'y': p.y, 't': p.tamano})
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Burbuja',
      paraQue:
          'Dispersion donde el tamano del punto (SizeEncode) añade una tercera '
          'variable al plano X-Y.',
      cuando:
          'Para relacionar dos medidas y ponderar cada punto por una magnitud: '
          'poblacion, ventas, peso.',
      grafica: Chart(
        data: datos,
        variables: {
          'x': Variable(accessor: (Map m) => m['x'] as num),
          'y': Variable(accessor: (Map m) => m['y'] as num),
          't': Variable(accessor: (Map m) => m['t'] as num),
        },
        marks: [
          PointMark(
            size: SizeEncode(variable: 't', values: [4, 24]),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 9. Barras con etiquetas de valor.
class GrBarrasEtiquetas extends StatelessWidget {
  const GrBarrasEtiquetas({super.key});
  @override
  Widget build(BuildContext context) {
    final datos =
        DatosMock.ventasMensuales.map((p) => {'cat': p.categoria, 'val': p.valor}).toList();
    return LienzoDescrito(
      titulo: 'graphic · Barras con etiquetas',
      paraQue:
          'Barras con el valor escrito encima mediante LabelEncode, que dibuja '
          'un texto por cada elemento.',
      cuando:
          'Cuando el lector necesita la cifra exacta ademas de la comparacion '
          'visual de alturas.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
        },
        marks: [
          IntervalMark(
            label: LabelEncode(
              encoder: (tuple) => Label(
                (tuple['val'] as num).toStringAsFixed(0),
                LabelStyle(textStyle: const TextStyle(fontSize: 10)),
              ),
            ),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 10. Grafico de anillos concentricos por serie (polar apilado 100%).
class GrAnillosSeries extends StatelessWidget {
  const GrAnillosSeries({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Anillos por serie',
      paraQue:
          'Barras polares con Stack + Dodge que forman anillos concentricos, '
          'un anillo por serie alrededor del centro.',
      cuando:
          'Para comparar varias series en un diseño circular de anillos '
          'apilados.',
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
            modifiers: [StackModifier(), DodgeModifier(ratio: 0.1)],
          ),
        ],
        coord: PolarCoord(transposed: true),
        axes: [Defaults.circularAxis],
      ),
    );
  }
}

/// 11. Barras + linea de tendencia (IntervalMark + LineMark).
class GrBarrasTendencia extends StatelessWidget {
  const GrBarrasTendencia({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales
        .map((p) => {'cat': p.categoria, 'val': p.valor})
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Barras + tendencia',
      paraQue:
          'Dos marcas sobre la misma posicion cat*val: las barras dan la '
          'magnitud por categoria y la linea encima resalta la tendencia.',
      cuando:
          'Para comparar magnitudes por categoria y ver a la vez la tendencia '
          'que siguen.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
        },
        marks: [
          IntervalMark(
            color: ColorEncode(
                value: Defaults.colors10.first.withValues(alpha: 0.5)),
          ),
          LineMark(
            shape: ShapeEncode(value: BasicLineShape(smooth: true)),
            size: SizeEncode(value: 2),
            color: ColorEncode(value: Colors.redAccent),
          ),
          PointMark(color: ColorEncode(value: Colors.redAccent)),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 12. Pastel con etiquetas de porcentaje (pastel + LabelEncode).
class GrPastelPorcentaje extends StatelessWidget {
  const GrPastelPorcentaje({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cuotaMercado
        .map((p) => {'cat': p.categoria, 'val': p.valor})
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Pastel con %',
      paraQue:
          'El pastel clasico (Proportion + Stack + polar) al que se le suma un '
          'LabelEncode que escribe el porcentaje calculado sobre cada sector.',
      cuando:
          'Para mostrar el reparto porcentual de un total y que cada porcion '
          'muestre ademas su cifra exacta.',
      grafica: Chart(
        data: datos,
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
            label: LabelEncode(
              encoder: (tuple) => Label(
                '${((tuple['percent'] as num) * 100).toStringAsFixed(0)}%',
                LabelStyle(
                  textStyle: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
        coord: PolarCoord(transposed: true, dimCount: 1),
      ),
    );
  }
}

/// 13. Area + puntos marcados (AreaMark + PointMark).
class GrAreaPuntos extends StatelessWidget {
  const GrAreaPuntos({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales
        .map((p) => {'cat': p.categoria, 'val': p.valor})
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Area + puntos',
      paraQue:
          'El area transmite el volumen bajo la curva y los puntos encima '
          'marcan el valor exacto de cada categoria.',
      cuando:
          'Para enfatizar el volumen acumulado y a la vez señalar el valor '
          'puntual de cada dato.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
        },
        marks: [
          AreaMark(
            color: ColorEncode(
                value: Defaults.colors10.first.withValues(alpha: 0.3)),
          ),
          LineMark(size: SizeEncode(value: 2)),
          PointMark(
            size: SizeEncode(value: 6),
            color: ColorEncode(value: Defaults.colors10.first),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 14. Lineas multiples + puntos por serie (LineMark + PointMark + color).
class GrLineasPuntosSerie extends StatelessWidget {
  const GrLineasPuntosSerie({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Lineas + puntos por serie',
      paraQue:
          'Una linea por serie distinguida por color, con los puntos de cada '
          'serie encima para resaltar los valores medidos.',
      cuando:
          'Para comparar la evolucion de varias series resaltando cada uno de '
          'sus valores.',
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
            position: Varset('cat') * Varset('val') / Varset('serie'),
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
          ),
          PointMark(
            position: Varset('cat') * Varset('val') / Varset('serie'),
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 15. Dispersion con tamano y forma (PointMark + SizeEncode + ShapeEncode).
class GrDispersionTamForma extends StatelessWidget {
  const GrDispersionTamForma({super.key});
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
      titulo: 'graphic · Dispersion tamano + forma',
      paraQue:
          'Cada punto codifica cuatro datos: X, Y, tamano (SizeEncode) y una '
          'cuarta variable por la FORMA (ShapeEncode), no por color.',
      cuando:
          'Para analisis multivariable donde la cuarta dimension debe '
          'distinguirse sin color: accesibilidad o impresion en blanco y negro.',
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
            shape: ShapeEncode(
              variable: 'grupo',
              values: [CircleShape(), SquareShape()],
            ),
            color: ColorEncode(
                value: Defaults.colors10.first.withValues(alpha: 0.7)),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 16. Barras agrupadas + apiladas (grouped-stacked).
class GrAgrupadasApiladas extends StatelessWidget {
  const GrAgrupadasApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    // cat (trimestre) x region (dodge) x producto (stack).
    const tabla = {
      'Norte': {'A': 30.0, 'B': 20.0},
      'Sur': {'A': 25.0, 'B': 28.0},
    };
    final datos = <Map>[];
    for (final cat in ['T1', 'T2', 'T3', 'T4']) {
      int k = 0;
      for (final region in tabla.keys) {
        k++;
        for (final prod in tabla[region]!.keys) {
          datos.add({
            'cat': cat,
            'region': region,
            'prod': prod,
            'val': tabla[region]![prod]! + k * 4.0,
          });
        }
      }
    }
    return LienzoDescrito(
      titulo: 'graphic · Agrupadas + apiladas',
      paraQue:
          'Doble modificador en coordenada rectangular: el nest por region '
          'separa los grupos (DodgeModifier) y el color por producto apila las '
          'capas dentro de cada grupo (StackModifier).',
      cuando:
          'Para datos con dos niveles de agrupacion a la vez: grupos lado a '
          'lado y composicion interna apilada en cada uno.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0)),
          'region': Variable(accessor: (Map m) => m['region'] as String),
          'prod': Variable(accessor: (Map m) => m['prod'] as String),
        },
        marks: [
          IntervalMark(
            position: Varset('cat') * Varset('val') / Varset('region'),
            color: ColorEncode(variable: 'prod', values: Defaults.colors10),
            modifiers: [DodgeModifier(), StackModifier()],
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 17. Pastel anidado de dos niveles (dos IntervalMark polares).
class GrPastelAnidado extends StatelessWidget {
  const GrPastelAnidado({super.key});
  @override
  Widget build(BuildContext context) {
    final interior = DatosMock.cuotaMercado
        .map((p) => {'cat': p.categoria, 'val': p.valor})
        .toList();
    // Desglose del anillo exterior (suma coherente con el interior).
    final exterior = [
      {'cat': 'Android-A', 'val': 28.0},
      {'cat': 'Android-B', 'val': 20.0},
      {'cat': 'iOS-A', 'val': 22.0},
      {'cat': 'iOS-B', 'val': 15.0},
      {'cat': 'Web', 'val': 10.0},
      {'cat': 'Otros', 'val': 5.0},
    ];
    Widget anillo(List<Map> datos, double startRadius, double endRadius) {
      return Chart(
        data: datos,
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
        coord: PolarCoord(
          transposed: true,
          dimCount: 1,
          startRadius: startRadius,
          endRadius: endRadius,
        ),
      );
    }

    return LienzoDescrito(
      titulo: 'graphic · Pastel anidado',
      paraQue:
          'Jerarquia en coordenadas polares: un disco interior con las '
          'categorias padre y un anillo exterior con su desglose, cada uno un '
          'IntervalMark polar superpuesto.',
      cuando:
          'Para mostrar una jerarquia de dos niveles: el total por categoria '
          'padre y como se reparte en sus subcategorias.',
      grafica: Stack(
        children: [
          anillo(exterior, 0.55, 0.9), // anillo exterior (desglose)
          anillo(interior, 0.0, 0.5), // disco interior (padres)
        ],
      ),
    );
  }
}

/// 18. Lineas con area de banda min-max (AreaMark de rango + LineMark).
class GrBandaMinMax extends StatelessWidget {
  const GrBandaMinMax({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = <Map>[];
    for (int i = 0; i < DatosMock.serieTemporal.length; i++) {
      final v = DatosMock.serieTemporal[i].valor;
      datos.add({
        'i': i,
        'val': v,
        'low': (v - 12).clamp(0, 100).toDouble(),
        'high': (v + 12).clamp(0, 100).toDouble(),
      });
    }
    Variable<Map, num> esc(String k) => Variable(
          accessor: (Map m) => m[k] as num,
          scale: LinearScale(min: 0, max: 100),
        );
    return LienzoDescrito(
      titulo: 'graphic · Banda min-max',
      paraQue:
          'El AreaMark usa el operador blend (low + high) para pintar una banda '
          'entre el minimo y el maximo, y el LineMark traza el valor central.',
      cuando:
          'Para series con incertidumbre o rango donde interesa el valor '
          'central y su banda de variacion: pronosticos, intervalos.',
      grafica: Chart(
        data: datos,
        variables: {
          'i': Variable(accessor: (Map m) => m['i'] as num),
          'val': esc('val'),
          'low': esc('low'),
          'high': esc('high'),
        },
        marks: [
          AreaMark(
            position: Varset('i') * (Varset('low') + Varset('high')),
            shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
            color: ColorEncode(
                value: Defaults.colors10.first.withValues(alpha: 0.25)),
          ),
          LineMark(
            position: Varset('i') * Varset('val'),
            shape: ShapeEncode(value: BasicLineShape(smooth: true)),
            size: SizeEncode(value: 2),
            color: ColorEncode(value: Defaults.colors10.first),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

/// 19. Radar de dos perfiles comparados (dos LineMark polares).
class GrRadarComparado extends StatelessWidget {
  const GrRadarComparado({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = <Map>[];
    for (final e in DatosMock.perfilRadar) {
      datos.add({'eje': e.eje, 'val': e.valor, 'perfil': 'Jugador 1'});
    }
    for (final e in DatosMock.perfilRadar2) {
      datos.add({'eje': e.eje, 'val': e.valor, 'perfil': 'Jugador 2'});
    }
    return LienzoDescrito(
      titulo: 'graphic · Radar comparado',
      paraQue:
          'Dos poligonos cerrados en coordenadas polares, uno por perfil, '
          'distinguidos por color, para comparar dos entidades eje a eje.',
      cuando:
          'Para comparar dos entidades evaluadas en los mismos criterios: dos '
          'jugadores, dos productos, dos candidatos.',
      grafica: Chart(
        data: datos,
        variables: {
          'eje': Variable(accessor: (Map m) => m['eje'] as String),
          'val': Variable(
              accessor: (Map m) => m['val'] as num,
              scale: LinearScale(min: 0, max: 100)),
          'perfil': Variable(accessor: (Map m) => m['perfil'] as String),
        },
        marks: [
          LineMark(
            position: Varset('eje') * Varset('val') / Varset('perfil'),
            shape: ShapeEncode(value: BasicLineShape(loop: true)),
            color: ColorEncode(variable: 'perfil', values: Defaults.colors10),
            size: SizeEncode(value: 2),
          ),
          PointMark(
            position: Varset('eje') * Varset('val') / Varset('perfil'),
            color: ColorEncode(variable: 'perfil', values: Defaults.colors10),
          ),
        ],
        coord: PolarCoord(),
        axes: [Defaults.circularAxis, Defaults.radialAxis],
      ),
    );
  }
}

/// 20. Barras divergentes positivo/negativo (IntervalMark + color por signo).
class GrBarrasDivergentes extends StatelessWidget {
  const GrBarrasDivergentes({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cascada
        .map((p) => {
              'cat': p.categoria,
              'val': p.valor,
              'signo': p.valor >= 0 ? 'Positivo' : 'Negativo',
            })
        .toList();
    return LienzoDescrito(
      titulo: 'graphic · Barras divergentes',
      paraQue:
          'Valores con signo que crecen a ambos lados del cero; el color '
          'codifica el signo para leer de un vistazo ganancias y perdidas.',
      cuando:
          'Para valores con signo donde conviene separar lo positivo de lo '
          'negativo: variaciones, saldos, desviaciones respecto a una meta.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(accessor: (Map m) => m['val'] as num),
          'signo': Variable(accessor: (Map m) => m['signo'] as String),
        },
        marks: [
          IntervalMark(
            color: ColorEncode(
              variable: 'signo',
              values: [Colors.redAccent, Colors.green],
            ),
          ),
        ],
        coord: RectCoord(transposed: true),
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}

const double _piGr = 3.141592653589793;
 
/// Cuantil con interpolacion lineal sobre una lista ya ordenada.
double _cuantilGr(List<double> ordenada, double q) {
  final pos = (ordenada.length - 1) * q;
  final i = pos.floor();
  final f = pos - i;
  if (i + 1 >= ordenada.length) return ordenada[i];
  return ordenada[i] + (ordenada[i + 1] - ordenada[i]) * f;
}
 
/// 21. Area apilada al 100 %.
/// Proportion anidada por categoria convierte cada serie en su fraccion
/// del total, y el StackModifier las apila hasta llenar el 100 %.
class GrArea100 extends StatelessWidget {
  const GrArea100({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Area al 100 %',
      paraQue:
          'Areas apiladas que siempre llenan el 100 % de la altura: lo que '
          'se ve no es el volumen sino como cambia el peso relativo de cada '
          'serie.',
      cuando:
          'Para seguir la composicion en el tiempo: participacion de cada '
          'producto o canal, aunque el total crezca o caiga.',
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
          AreaMark(
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
 
/// 22. Cascada (waterfall).
/// El operador blend (desde + hasta) dibuja barras flotantes: cada paso
/// arranca donde termino el anterior.
class GrCascada extends StatelessWidget {
  const GrCascada({super.key});
  @override
  Widget build(BuildContext context) {
    final pasos = DatosMock.cascada; // valores con signo
    final datos = <Map>[];
    double acum = 0;
    for (final p in pasos) {
      final desde = acum;
      acum += p.valor;
      datos.add({
        'cat': p.categoria,
        'desde': desde,
        'hasta': acum,
        'delta': p.valor,
        'tipo': 'Paso',
      });
    }
    datos.add({
      'cat': 'Total',
      'desde': 0.0,
      'hasta': acum,
      'delta': acum,
      'tipo': 'Total',
    });
    final tope = datos
            .map((d) => (d['hasta'] as num).toDouble())
            .reduce((a, b) => a > b ? a : b) *
        1.15;
    Variable<Map, num> esc(String k) => Variable(
          accessor: (Map m) => m[k] as num,
          scale: LinearScale(min: 0, max: tope),
        );
    return LienzoDescrito(
      titulo: 'graphic · Cascada',
      paraQue:
          'Barras flotantes encadenadas: cada una empieza donde termino la '
          'anterior, mostrando como sumas (verde) y restas (rojo) llevan de '
          'un inicio a un total (azul).',
      cuando:
          'Para explicar como se llega a un resultado paso a paso: de '
          'ingreso bruto a utilidad neta, de saldo inicial a final.',
      grafica: Chart(
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'desde': esc('desde'),
          'hasta': esc('hasta'),
          'delta': Variable(accessor: (Map m) => m['delta'] as num),
          'tipo': Variable(accessor: (Map m) => m['tipo'] as String),
        },
        marks: [
          IntervalMark(
            position: Varset('cat') * (Varset('desde') + Varset('hasta')),
            color: ColorEncode(
              encoder: (tuple) => tuple['tipo'] == 'Total'
                  ? Colors.blue
                  : ((tuple['delta'] as num) >= 0
                      ? Colors.green
                      : Colors.redAccent),
            ),
            label: LabelEncode(
              encoder: (tuple) {
                final d = tuple['delta'] as num;
                final signo = tuple['tipo'] == 'Total' || d < 0 ? '' : '+';
                return Label(
                  '$signo${d.toStringAsFixed(0)}',
                  LabelStyle(textStyle: const TextStyle(fontSize: 11)),
                );
              },
            ),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 23. Velas japonesas.
/// CandlestickShape dibuja cada vela a partir de cuatro valores
/// (apertura, maximo, minimo, cierre) combinados con el operador blend.
class GrVelas extends StatelessWidget {
  const GrVelas({super.key});
  @override
  Widget build(BuildContext context) {
    final velas = DatosMock.velas.take(12).toList();
    final datos = <Map>[
      for (final v in velas)
        {
          'time': '${v.fecha.day}/${v.fecha.month}',
          'start': v.apertura,
          'max': v.alto,
          'min': v.bajo,
          'end': v.cierre,
        },
    ];
    final minimo = velas.map((v) => v.bajo).reduce((a, b) => a < b ? a : b);
    final maximo = velas.map((v) => v.alto).reduce((a, b) => a > b ? a : b);
    // Las cuatro variables comparten escala para que las velas cuadren.
    Variable<Map, num> esc(String k) => Variable(
          accessor: (Map m) => m[k] as num,
          scale: LinearScale(min: minimo - 5, max: maximo + 5),
        );
    return LienzoDescrito(
      titulo: 'graphic · Velas',
      paraQue:
          'Cada vela resume un periodo: el cuerpo va de apertura a cierre '
          '(verde si sube, rojo si baja) y la mecha llega al maximo y al '
          'minimo.',
      cuando:
          'Para datos bursatiles o de mercado donde importan los cuatro '
          'valores del periodo y la direccion en que cerro.',
      grafica: Chart(
        data: datos,
        variables: {
          'time': Variable(accessor: (Map m) => m['time'] as String),
          'start': esc('start'),
          'max': esc('max'),
          'min': esc('min'),
          'end': esc('end'),
        },
        marks: [
          CustomMark(
            shape: ShapeEncode(value: CandlestickShape(hollow: false)),
            position: Varset('time') *
                (Varset('start') +
                    Varset('max') +
                    Varset('min') +
                    Varset('end')),
            color: ColorEncode(
              encoder: (tuple) => (tuple['end'] as num) >= (tuple['start'] as num)
                  ? Colors.green
                  : Colors.redAccent,
            ),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 24. Gantt (barras flotantes horizontales).
/// El operador blend (inicio + fin) con la coordenada transpuesta dibuja
/// cada tarea como una barra horizontal de inicio a fin.
class GrGantt extends StatelessWidget {
  const GrGantt({super.key});
  @override
  Widget build(BuildContext context) {
    // Mismas tareas que el Gantt de las otras librerias (semanas 0-12).
    const tareas = [
      ['Analisis', 0, 3],
      ['Diseno', 2, 6],
      ['Desarrollo', 5, 10],
      ['Pruebas', 8, 12],
      ['Entrega', 11, 12],
    ];
    final datos = <Map>[
      for (final t in tareas)
        {'tarea': t[0], 'inicio': t[1], 'fin': t[2]},
    ];
    Variable<Map, num> esc(String k) => Variable(
          accessor: (Map m) => m[k] as num,
          scale: LinearScale(min: 0, max: 12),
        );
    return LienzoDescrito(
      titulo: 'graphic · Gantt',
      paraQue:
          'Cada barra horizontal va del inicio al fin de una tarea, '
          'mostrando su duracion y como se solapan las fases.',
      cuando:
          'Para planificar proyectos: cronogramas, fases de trabajo, '
          'calendarios de tareas con solapamientos.',
      grafica: Chart(
        data: datos,
        variables: {
          'tarea': Variable(accessor: (Map m) => m['tarea'] as String),
          'inicio': esc('inicio'),
          'fin': esc('fin'),
        },
        marks: [
          IntervalMark(
            position: Varset('tarea') * (Varset('inicio') + Varset('fin')),
            size: SizeEncode(value: 22),
            color: ColorEncode(variable: 'tarea', values: Defaults.colors10),
            label: LabelEncode(
              encoder: (tuple) => Label(
                'sem ${tuple['inicio']}-${tuple['fin']}',
                LabelStyle(textStyle: const TextStyle(fontSize: 10)),
              ),
            ),
          ),
        ],
        // verticalRange invertido: la primera tarea queda arriba.
        coord: RectCoord(transposed: true, verticalRange: [1, 0]),
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 25. Barras con seleccion y tooltip.
/// Una PointSelection por toque atenua las barras no elegidas
/// (ColorEncode con updaters) y el TooltipGuide muestra su valor.
class GrBarrasSeleccion extends StatelessWidget {
  const GrBarrasSeleccion({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Defaults.colors10.first;
    return LienzoDescrito(
      titulo: 'graphic · Barras con seleccion',
      paraQue:
          'Al tocar una barra, queda resaltada, las demas se atenuan y un '
          'globo muestra su categoria y su valor.',
      cuando:
          'En tableros interactivos donde el usuario explora categorias '
          'una a una y necesita aislar la que esta revisando.',
      grafica: Chart(
        data: _seriesPlanas()
            .where((m) => m['serie'] == DatosMock.seriesMultiples.first.nombre)
            .toList(),
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'val': Variable(
            accessor: (Map m) => m['val'] as num,
            scale: LinearScale(min: 0),
          ),
        },
        marks: [
          IntervalMark(
            color: ColorEncode(
              value: color,
              updaters: {
                'tap': {false: (c) => c.withAlpha(80)},
              },
            ),
          ),
        ],
        selections: {'tap': PointSelection(dim: Dim.x)},
        tooltip: TooltipGuide(),
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 26. Lineas con crosshair y tooltip multiple.
/// Al tocar o arrastrar, una guia sigue al dedo y el tooltip muestra el
/// valor de todas las series en ese punto.
class GrLineasCrosshair extends StatelessWidget {
  const GrLineasCrosshair({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'graphic · Lineas con crosshair',
      paraQue:
          'Al tocar o arrastrar sobre la grafica aparece una guia '
          '(crosshair) y un globo con el valor de cada serie en ese '
          'punto.',
      cuando:
          'Cuando hay varias series y se quiere leer sus valores a la vez '
          'en un mismo instante, sin llenar la grafica de etiquetas.',
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
          LineMark(
            position: Varset('cat') * Varset('val') / Varset('serie'),
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
          ),
          PointMark(
            position: Varset('cat') * Varset('val') / Varset('serie'),
            color: ColorEncode(variable: 'serie', values: Defaults.colors10),
          ),
        ],
        selections: {
          'touchMove': PointSelection(
            on: {
              GestureType.scaleUpdate,
              GestureType.tapDown,
              GestureType.longPressMoveUpdate,
            },
            dim: Dim.x,
            // Expande la seleccion a todas las series del mismo periodo.
            variable: 'cat',
          ),
        },
        crosshair: CrosshairGuide(followPointer: [false, false]),
        tooltip: TooltipGuide(multiTuples: true),
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 27. Dispersion con seleccion por brush.
/// Un IntervalSelection permite arrastrar un rectangulo; los puntos que
/// quedan fuera se atenuan.
class GrDispersionBrush extends StatelessWidget {
  const GrDispersionBrush({super.key});
  @override
  Widget build(BuildContext context) {
    final datos =
        DatosMock.dispersion.map((p) => {'x': p.x, 'y': p.y}).toList();
    return LienzoDescrito(
      titulo: 'graphic · Dispersion con brush',
      paraQue:
          'Arrastrando el dedo se dibuja un rectangulo de seleccion: los '
          'puntos dentro conservan su color y los de fuera se atenuan.',
      cuando:
          'Para explorar nubes densas y aislar una zona: ver que puntos '
          'caen en cierto rango de las dos variables.',
      grafica: Chart(
        data: datos,
        variables: {
          'x': Variable(accessor: (Map m) => m['x'] as num),
          'y': Variable(accessor: (Map m) => m['y'] as num),
        },
        marks: [
          PointMark(
            size: SizeEncode(value: 8),
            color: ColorEncode(
              value: Defaults.colors10.first,
              updaters: {
                'brush': {false: (c) => c.withAlpha(35)},
              },
            ),
          ),
        ],
        selections: {'brush': IntervalSelection()},
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 28. Radar con area rellena (tres perfiles).
/// Los dos perfiles de DatosMock mas un tercero calculado, el promedio
/// de ambos, dibujados como poligonos rellenos en coordenadas polares.
class GrRadarArea extends StatelessWidget {
  const GrRadarArea({super.key});
  @override
  Widget build(BuildContext context) {
    final a = DatosMock.perfilRadar;
    final b = DatosMock.perfilRadar2;
    final datos = <Map>[
      for (final e in a) {'eje': e.eje, 'val': e.valor, 'perfil': 'Jugador 1'},
      for (final e in b) {'eje': e.eje, 'val': e.valor, 'perfil': 'Jugador 2'},
      for (int i = 0; i < a.length; i++)
        {
          'eje': a[i].eje,
          'val': (a[i].valor + b[i].valor) / 2,
          'perfil': 'Promedio',
        },
    ];
    final colores = Defaults.colors10.take(3).toList();
    return LienzoDescrito(
      titulo: 'graphic · Radar con area',
      paraQue:
          'Tres poligonos rellenos en los mismos ejes: dos entidades y su '
          'promedio como referencia. El relleno hace visible cuanta '
          'superficie domina cada una.',
      cuando:
          'Para comparar dos candidatos o productos contra un estandar: '
          'dos jugadores contra el promedio del plantel.',
      grafica: Chart(
        data: datos,
        variables: {
          'eje': Variable(accessor: (Map m) => m['eje'] as String),
          'val': Variable(
            accessor: (Map m) => m['val'] as num,
            scale: LinearScale(min: 0, max: 100),
          ),
          'perfil': Variable(accessor: (Map m) => m['perfil'] as String),
        },
        marks: [
          AreaMark(
            position: Varset('eje') * Varset('val') / Varset('perfil'),
            shape: ShapeEncode(value: BasicAreaShape(loop: true)),
            color: ColorEncode(
              variable: 'perfil',
              values: [for (final c in colores) c.withValues(alpha: 0.2)],
            ),
          ),
          LineMark(
            position: Varset('eje') * Varset('val') / Varset('perfil'),
            shape: ShapeEncode(value: BasicLineShape(loop: true)),
            size: SizeEncode(value: 2),
            color: ColorEncode(variable: 'perfil', values: colores),
          ),
        ],
        coord: PolarCoord(),
        axes: [Defaults.circularAxis, Defaults.radialAxis],
      ),
    );
  }
}
 
/// 29. Medidor semicircular.
/// Un IntervalMark polar limitado a media circunferencia
/// (startAngle a endAngle) y con radio interior, que se llena segun un
/// valor sobre su maximo.
class GrMedidor extends StatelessWidget {
  const GrMedidor({super.key});
  @override
  Widget build(BuildContext context) {
    const valor = DatosMock.valorMedidor;
    const rango = DatosMock.rangoMedidor;
    final datos = <Map>[
      {'cat': 'Uso', 'val': valor},
      {'cat': 'Resto', 'val': rango - valor},
    ];
    return LienzoDescrito(
      titulo: 'graphic · Medidor',
      paraQue:
          'Un semicirculo que se llena segun un valor sobre su maximo, '
          'imitando un velocimetro, con la cifra en el centro.',
      cuando:
          'Para un indicador unico de avance o uso: capacidad, '
          'cumplimiento, nivel de un recurso.',
      grafica: Stack(
        children: [
          Chart(
            data: datos,
            variables: {
              'cat': Variable(accessor: (Map m) => m['cat'] as String),
              'val': Variable(accessor: (Map m) => m['val'] as num),
            },
            transforms: [Proportion(variable: 'val', as: 'percent')],
            marks: [
              IntervalMark(
                position: Varset('percent') / Varset('cat'),
                color: ColorEncode(
                  variable: 'cat',
                  values: [Defaults.colors10.first, Colors.grey.shade300],
                ),
                modifiers: [StackModifier()],
              ),
            ],
            coord: PolarCoord(
              transposed: true,
              dimCount: 1,
              startAngle: _piGr,
              endAngle: 2 * _piGr,
              startRadius: 0.6,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.15),
            child: Text(
              '${valor.toStringAsFixed(0)} / ${rango.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 30. Barras + linea con doble eje.
/// Las barras (ventas) usan el eje izquierdo y la linea (variacion
/// porcentual mensual) un segundo eje a la derecha, con su propia escala.
/// Cada variable tiene su escala y AxisGuide.variable decide a cual
/// pertenece cada eje.
class GrDobleEje extends StatelessWidget {
  const GrDobleEje({super.key});
  @override
  Widget build(BuildContext context) {
    final v = DatosMock.ventasMensuales;
    // La variacion necesita el mes anterior: se parte del segundo mes.
    final datos = <Map>[
      for (int i = 1; i < v.length; i++)
        {
          'cat': v[i].categoria,
          'ventas': v[i].valor,
          'var': (v[i].valor - v[i - 1].valor) / v[i - 1].valor * 100,
        },
    ];
    final colorBarra = Defaults.colors10.first;
    const colorLinea = Colors.redAccent;
    return LienzoDescrito(
      titulo: 'graphic · Doble eje',
      paraQue:
          'Dos series de unidades distintas en una misma grafica: las '
          'barras se leen en el eje izquierdo y la linea en un segundo eje '
          'a la derecha, con su propia escala.',
      cuando:
          'Cuando se relacionan una magnitud y su cambio relativo: ventas '
          'y crecimiento mensual, produccion y rendimiento.',
      grafica: Chart(
        padding: (_) => const EdgeInsets.fromLTRB(40, 10, 46, 25),
        data: datos,
        variables: {
          'cat': Variable(accessor: (Map m) => m['cat'] as String),
          'ventas': Variable(
            accessor: (Map m) => m['ventas'] as num,
            scale: LinearScale(min: 0),
          ),
          'var': Variable(accessor: (Map m) => m['var'] as num),
        },
        marks: [
          IntervalMark(
            position: Varset('cat') * Varset('ventas'),
            color: ColorEncode(value: colorBarra.withValues(alpha: 0.6)),
          ),
          LineMark(
            position: Varset('cat') * Varset('var'),
            size: SizeEncode(value: 2.5),
            color: ColorEncode(value: colorLinea),
          ),
          PointMark(
            position: Varset('cat') * Varset('var'),
            size: SizeEncode(value: 7),
            color: ColorEncode(value: colorLinea),
          ),
        ],
        axes: [
          Defaults.horizontalAxis,
          // Eje izquierdo: ventas.
          Defaults.verticalAxis..variable = 'ventas',
          // Eje derecho: variacion %, sin cuadricula propia.
          AxisGuide(
            dim: Dim.y,
            variable: 'var',
            position: 1,
            flip: true,
            label: LabelStyle(
              textStyle: Defaults.textStyle.copyWith(color: colorLinea),
              offset: const Offset(7.5, 0),
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 31. Diagrama de caja (boxplot).
/// Resume la distribucion de cada periodo en cinco numeros. Se arma con
/// tres IntervalMark con blend: la mecha (min-max), la caja (q1-q3) y una
/// franja fina blanca que marca la mediana.
class GrBoxplot extends StatelessWidget {
  const GrBoxplot({super.key});
  @override
  Widget build(BuildContext context) {
    final d = DatosMock.serieTemporal;
    Map fila(String nombre, int desde, int hasta) {
      final v = d.sublist(desde, hasta).map((p) => p.valor).toList()..sort();
      final med = _cuantilGr(v, 0.5);
      return {
        'periodo': nombre,
        'min': v.first,
        'q1': _cuantilGr(v, 0.25),
        // La mediana se dibuja como una franja de 1 unidad de alto.
        'med0': med - 0.5,
        'med1': med + 0.5,
        'q3': _cuantilGr(v, 0.75),
        'max': v.last,
      };
    }
 
    final datos = <Map>[
      fila('Dias 1-10', 0, 10),
      fila('Dias 11-20', 10, 20),
      fila('Dias 21-30', 20, 30),
    ];
    Variable<Map, num> esc(String k) => Variable(
          accessor: (Map m) => m[k] as num,
          scale: LinearScale(min: 0, max: 100),
        );
    return LienzoDescrito(
      titulo: 'graphic · Diagrama de caja',
      paraQue:
          'Resume cada grupo en cinco numeros: minimo y maximo (la mecha), '
          'primer y tercer cuartil (la caja) y la mediana (la franja '
          'blanca), calculados a partir de los datos.',
      cuando:
          'Para comparar la distribucion de varios grupos de un vistazo: '
          'centro, dispersion y asimetria, sin mostrar cada dato.',
      grafica: Chart(
        data: datos,
        variables: {
          'periodo': Variable(accessor: (Map m) => m['periodo'] as String),
          'min': esc('min'),
          'q1': esc('q1'),
          'med0': esc('med0'),
          'med1': esc('med1'),
          'q3': esc('q3'),
          'max': esc('max'),
        },
        marks: [
          // Mecha.
          IntervalMark(
            position: Varset('periodo') * (Varset('min') + Varset('max')),
            size: SizeEncode(value: 2),
            color: ColorEncode(value: Colors.grey.shade700),
          ),
          // Caja.
          IntervalMark(
            position: Varset('periodo') * (Varset('q1') + Varset('q3')),
            size: SizeEncode(value: 44),
            color: ColorEncode(
              variable: 'periodo',
              values: [
                for (final c in Defaults.colors10.take(3))
                  c.withValues(alpha: 0.7),
              ],
            ),
          ),
          // Mediana.
          IntervalMark(
            position: Varset('periodo') * (Varset('med0') + Varset('med1')),
            size: SizeEncode(value: 44),
            color: ColorEncode(value: Colors.white),
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}
 
/// 32. Serie con anotaciones (region, linea y etiquetas).
/// Combina los tres tipos de anotacion de graphic sobre una serie: una
/// region sombreada, una linea de promedio y etiquetas de texto.
class GrAnotaciones extends StatelessWidget {
  const GrAnotaciones({super.key});
  @override
  Widget build(BuildContext context) {
    final d = DatosMock.serieTemporal;
    final datos = <Map>[
      for (int i = 0; i < d.length; i++) {'i': i, 'val': d[i].valor},
    ];
    final promedio = d.map((p) => p.valor).reduce((a, b) => a + b) / d.length;
    const inicio = 8; // periodo destacado de ejemplo (dias 9-17)
    const fin = 16;
    final color = Defaults.colors10.first;
    return LienzoDescrito(
      titulo: 'graphic · Anotaciones',
      paraQue:
          'Una serie con tres capas de anotacion: una region sombreada que '
          'marca un periodo, una linea de promedio y etiquetas de texto '
          'ancladas a valores de los datos.',
      cuando:
          'Para contar la historia de una serie: marcar una campana, una '
          'crisis o un mantenimiento y senalar la referencia contra la '
          'que se compara.',
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
          LineMark(
            shape: ShapeEncode(value: BasicLineShape(smooth: true)),
            size: SizeEncode(value: 2),
            color: ColorEncode(value: color),
          ),
        ],
        annotations: [
          RegionAnnotation(
            dim: Dim.x,
            values: [inicio, fin],
            color: Colors.amber.withValues(alpha: 0.25),
          ),
          LineAnnotation(
            dim: Dim.y,
            value: promedio,
            style: PaintStyle(
              strokeColor: Colors.redAccent,
              strokeWidth: 1.5,
              dash: [6, 4],
            ),
          ),
          TagAnnotation(
            label: Label(
              'Periodo destacado',
              LabelStyle(
                textStyle: Defaults.textStyle,
                align: Alignment.topCenter,
              ),
            ),
            variables: ['i', 'val'],
            values: [(inicio + fin) / 2, 98],
          ),
          TagAnnotation(
            label: Label(
              'Promedio ${promedio.toStringAsFixed(0)}',
              LabelStyle(
                textStyle: Defaults.textStyle.copyWith(color: Colors.redAccent),
                align: Alignment.topLeft,
              ),
            ),
            variables: ['i', 'val'],
            values: [d.length - 7, promedio],
          ),
        ],
        axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
      ),
    );
  }
}