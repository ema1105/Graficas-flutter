import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/lienzo_descrito.dart';
import '../../mock/datos_mock.dart';
import 'dart:math' as math;

// ============================================================
// fl_chart — 20 GRAFICAS BASICAS
// Las 10 primeras son los tipos fundamentales. Las 10 siguientes son
// COMBINACIONES: cada una fusiona dos o mas formas de visualizacion
// para comunicar algo que ninguna de las partes dice por si sola.
// Todas incluyen su explicacion (para que sirve / cuando usarla).
// ============================================================

List<Color> _paleta(BuildContext context) {
  final e = Theme.of(context).colorScheme;
  return [e.primary, e.tertiary, e.secondary, e.error, e.primaryContainer];
}

Widget _etiquetaX(List<String> etiquetas, double valor) {
  final i = valor.toInt();
  if (i < 0 || i >= etiquetas.length) return const SizedBox();
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Text(etiquetas[i], style: const TextStyle(fontSize: 10)),
  );
}

FlTitlesData _titulos(List<String> cats) => FlTitlesData(
      leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
      rightTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (v, _) => _etiquetaX(cats, v),
        ),
      ),
    );

// ============================================================
// PARTE 1 — LOS 10 TIPOS FUNDAMENTALES (ahora con descripcion)
// ============================================================

/// 1. Barras verticales.
class FlBarras extends StatelessWidget {
  const FlBarras({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final color = Theme.of(context).colorScheme.primary;
    return LienzoDescrito(
      titulo: 'fl_chart · Barras',
      paraQue:
          'Compara cantidades entre categorias distintas mediante la altura '
          'de cada barra. Es el grafico mas directo para ver quien tiene mas.',
      cuando:
          'Cuando se comparan valores de categorias independientes: ventas '
          'por mes, votos por candidato, unidades por producto.',
      grafica: BarChart(
        BarChartData(
          maxY: 80,
          barGroups: [
            for (int i = 0; i < datos.length; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                    toY: datos[i].valor,
                    color: color,
                    width: 18,
                    borderRadius: BorderRadius.circular(4)),
              ]),
          ],
          titlesData: _titulos(datos.map((e) => e.categoria).toList()),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
        ),
      ),
    );
  }
}

/// 2. Lineas.
class FlLineas extends StatelessWidget {
  const FlLineas({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final color = Theme.of(context).colorScheme.primary;
    return LienzoDescrito(
      titulo: 'fl_chart · Lineas',
      paraQue:
          'Muestra como cambia un valor a lo largo de una secuencia, uniendo '
          'los puntos para que la tendencia se vea de un trazo.',
      cuando:
          'Para evoluciones continuas en el tiempo: temperatura por hora, '
          'precio por dia, usuarios por mes.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 80,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < datos.length; i++)
                  FlSpot(i.toDouble(), datos[i].valor),
              ],
              color: color,
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          ],
          titlesData: _titulos(datos.map((e) => e.categoria).toList()),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

/// 3. Area.
class FlArea extends StatelessWidget {
  const FlArea({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final color = Theme.of(context).colorScheme.primary;
    return LienzoDescrito(
      titulo: 'fl_chart · Area',
      paraQue:
          'Como una linea, pero rellena el espacio debajo para enfatizar el '
          'volumen o la magnitud acumulada, no solo la tendencia.',
      cuando:
          'Cuando ademas de la evolucion importa transmitir "cuanto" hubo en '
          'total: trafico acumulado, consumo, ingresos a lo largo del tiempo.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 80,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < datos.length; i++)
                  FlSpot(i.toDouble(), datos[i].valor),
              ],
              color: color,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: color.withValues(alpha: 0.25),
              ),
            ),
          ],
          titlesData: _titulos(datos.map((e) => e.categoria).toList()),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

/// 4. Pastel.
class FlPastel extends StatelessWidget {
  const FlPastel({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cuotaMercado;
    final colores = _paleta(context);
    return LienzoDescrito(
      titulo: 'fl_chart · Pastel',
      paraQue:
          'Divide un total en porciones, mostrando que parte del todo ocupa '
          'cada categoria.',
      cuando:
          'Cuando el mensaje es la proporcion sobre un total y hay pocas '
          'categorias (idealmente menos de seis).',
      grafica: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 0,
          sections: [
            for (int i = 0; i < datos.length; i++)
              PieChartSectionData(
                value: datos[i].valor,
                title: '${datos[i].categoria}\n${datos[i].valor.toInt()}%',
                color: colores[i % colores.length],
                radius: 110,
                titleStyle:
                    const TextStyle(fontSize: 11, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

/// 5. Dona.
class FlDona extends StatelessWidget {
  const FlDona({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cuotaMercado;
    final colores = _paleta(context);
    return LienzoDescrito(
      titulo: 'fl_chart · Dona',
      paraQue:
          'Igual que el pastel pero con un hueco central, que aligera la '
          'figura y deja espacio para un dato o titulo en el centro.',
      cuando:
          'Cuando se busca la misma lectura de proporcion que el pastel con '
          'un estilo mas moderno, comun en tableros.',
      grafica: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 60,
          sections: [
            for (int i = 0; i < datos.length; i++)
              PieChartSectionData(
                value: datos[i].valor,
                title: '${datos[i].valor.toInt()}%',
                color: colores[i % colores.length],
                radius: 60,
                titleStyle:
                    const TextStyle(fontSize: 11, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

/// 6. Barras horizontales.
class FlBarrasHorizontales extends StatelessWidget {
  const FlBarrasHorizontales({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final color = Theme.of(context).colorScheme.tertiary;
    return LienzoDescrito(
      titulo: 'fl_chart · Barras horizontales',
      paraQue:
          'Barras tumbadas de izquierda a derecha. La orientacion horizontal '
          'da espacio para etiquetas de categoria largas.',
      cuando:
          'Cuando los nombres de categoria son largos o hay muchas '
          'categorias, situacion en que las barras verticales se aprietan.',
      grafica: RotatedBox(
        quarterTurns: 1,
        child: BarChart(
          BarChartData(
            maxY: 80,
            barGroups: [
              for (int i = 0; i < datos.length; i++)
                BarChartGroupData(x: i, barRods: [
                  BarChartRodData(
                      toY: datos[i].valor, color: color, width: 16),
                ]),
            ],
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (v, _) {
                    final i = v.toInt();
                    if (i < 0 || i >= datos.length) return const SizedBox();
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Text(datos[i].categoria,
                          style: const TextStyle(fontSize: 10)),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}

/// 7. Lineas multiples.
class FlLineasMultiples extends StatelessWidget {
  const FlLineasMultiples({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    final colores = _paleta(context);
    return LienzoDescrito(
      titulo: 'fl_chart · Lineas multiples',
      paraQue:
          'Traza varias lineas en el mismo plano para comparar la evolucion '
          'de varias series a la vez.',
      cuando:
          'Cuando se comparan tendencias de varios elementos en el mismo '
          'periodo: ventas de tres productos, trafico de tres paginas.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 60,
          lineBarsData: [
            for (int s = 0; s < series.length; s++)
              LineChartBarData(
                spots: [
                  for (int i = 0; i < series[s].puntos.length; i++)
                    FlSpot(i.toDouble(), series[s].puntos[i].valor),
                ],
                color: colores[s % colores.length],
                barWidth: 3,
                dotData: const FlDotData(show: true),
              ),
          ],
          titlesData:
              _titulos(series.first.puntos.map((p) => p.categoria).toList()),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

/// 8. Barras apiladas.
class FlBarrasApiladas extends StatelessWidget {
  const FlBarrasApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    final colores = _paleta(context);
    final trimestres = series.first.puntos.length;
    return LienzoDescrito(
      titulo: 'fl_chart · Barras apiladas',
      paraQue:
          'Apila varias series en una sola barra, mostrando el total de cada '
          'periodo y como se compone internamente.',
      cuando:
          'Cuando interesan a la vez el total y el aporte de cada parte: '
          'ingresos por linea de negocio, ventas por canal.',
      grafica: BarChart(
        BarChartData(
          maxY: 130,
          barGroups: [
            for (int t = 0; t < trimestres; t++)
              BarChartGroupData(
                x: t,
                barRods: [
                  BarChartRodData(
                    toY: series.fold<double>(
                        0, (suma, s) => suma + s.puntos[t].valor),
                    width: 22,
                    rodStackItems: _apilar(series, t, colores),
                  ),
                ],
              ),
          ],
          titlesData:
              _titulos(series.first.puntos.map((p) => p.categoria).toList()),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  List<BarChartRodStackItem> _apilar(
      List<SerieNombrada> series, int t, List<Color> colores) {
    final items = <BarChartRodStackItem>[];
    double acumulado = 0;
    for (int s = 0; s < series.length; s++) {
      final v = series[s].puntos[t].valor;
      items.add(BarChartRodStackItem(
          acumulado, acumulado + v, colores[s % colores.length]));
      acumulado += v;
    }
    return items;
  }
}

/// 9. Dispersion.
class FlDispersion extends StatelessWidget {
  const FlDispersion({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final color = Theme.of(context).colorScheme.primary;
    return LienzoDescrito(
      titulo: 'fl_chart · Dispersion',
      paraQue:
          'Ubica cada dato como un punto segun dos variables, revelando si '
          'existe relacion o correlacion entre ellas.',
      cuando:
          'Para analizar la relacion entre dos medidas numericas: peso vs '
          'altura, horas de estudio vs nota, precio vs demanda.',
      grafica: ScatterChart(
        ScatterChartData(
          minX: 0,
          maxX: 100,
          minY: 0,
          maxY: 100,
          scatterSpots: [
            for (final p in datos)
              ScatterSpot(
                p.x,
                p.y,
                dotPainter: FlDotCirclePainter(color: color, radius: 5),
              ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}

/// 10. Area con gradiente.
class FlAreaGradiente extends StatelessWidget {
  const FlAreaGradiente({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Area con gradiente',
      paraQue:
          'Un area cuyo relleno se desvanece de arriba hacia abajo, dando '
          'profundidad visual a la tendencia.',
      cuando:
          'Igual que el area, pero cuando ademas importa un acabado estetico '
          'cuidado, tipico en pantallas de inicio y tableros destacados.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < datos.length; i++)
                  FlSpot(i.toDouble(), datos[i].valor),
              ],
              gradient: LinearGradient(
                  colors: [esquema.primary, esquema.tertiary]),
              barWidth: 3,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    esquema.primary.withValues(alpha: 0.35),
                    esquema.primary.withValues(alpha: 0.02),
                  ],
                ),
              ),
            ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true),
        ),
      ),
    );
  }
}


// ============================================================
// PARTE 2 — 10 COMBINACIONES
// Cada una fusiona dos o mas formas de visualizacion.
// ============================================================

/// 11. Barras + linea de tendencia.
/// Combina barras (valor por periodo) con una linea encima (tendencia).
class FlBarrasTendencia extends StatelessWidget {
  const FlBarrasTendencia({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final esquema = Theme.of(context).colorScheme;
    final cats = datos.map((e) => e.categoria).toList();
    return LienzoDescrito(
      titulo: 'fl_chart · Barras + tendencia',
      paraQue:
          'Las barras dan el valor exacto de cada periodo y la linea '
          'superpuesta revela la direccion general que las barras no muestran.',
      cuando:
          'Cuando se quiere leer a la vez el dato de cada mes y si el '
          'conjunto sube o baja: ventas mensuales con su tendencia.',
      grafica: Stack(
        children: [
          BarChart(
            BarChartData(
              maxY: 85,
              barGroups: [
                for (int i = 0; i < datos.length; i++)
                  BarChartGroupData(x: i, barRods: [
                    BarChartRodData(
                        toY: datos[i].valor,
                        color: esquema.primary.withValues(alpha: 0.45),
                        width: 18),
                  ]),
              ],
              titlesData: _titulos(cats),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
          LineChart(
            LineChartData(
              minY: 0,
              maxY: 85,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (int i = 0; i < datos.length; i++)
                      FlSpot(i.toDouble(), datos[i].valor),
                  ],
                  isCurved: true,
                  color: esquema.error,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                ),
              ],
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineTouchData: const LineTouchData(enabled: false),
            ),
          ),
        ],
      ),
    );
  }
}

/// 12. Linea con banda de dispersion.
/// Combina una linea central con un area (minimo-maximo) alrededor.
class FlLineaBanda extends StatelessWidget {
  const FlLineaBanda({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    final inferior = <FlSpot>[];
    final superior = <FlSpot>[];
    for (int i = 0; i < datos.length; i++) {
      inferior.add(FlSpot(i.toDouble(), (datos[i].valor - 14).clamp(0, 100)));
      superior.add(FlSpot(i.toDouble(), (datos[i].valor + 14).clamp(0, 100)));
    }
    return LienzoDescrito(
      titulo: 'fl_chart · Linea con banda',
      paraQue:
          'La linea marca el valor central y la banda sombreada muestra su '
          'margen de variacion o incertidumbre alrededor de ese valor.',
      cuando:
          'Para datos con rango de error o variabilidad: pronosticos con '
          'margen, mediciones con tolerancia, estimaciones con intervalo.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: superior,
              color: esquema.primary.withValues(alpha: 0.35),
              barWidth: 1,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: esquema.primary.withValues(alpha: 0.12),
              ),
            ),
            LineChartBarData(
              spots: inferior,
              color: esquema.primary.withValues(alpha: 0.35),
              barWidth: 1,
              dotData: const FlDotData(show: false),
            ),
            LineChartBarData(
              spots: [
                for (int i = 0; i < datos.length; i++)
                  FlSpot(i.toDouble(), datos[i].valor),
              ],
              isCurved: true,
              color: esquema.primary,
              barWidth: 3,
              dotData: const FlDotData(show: false),
            ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

/// 13. Pastel anidado (dos anillos concentricos).
/// Combina dos donas: el anillo exterior detalla, el interior agrupa.
class FlPastelAnidado extends StatelessWidget {
  const FlPastelAnidado({super.key});
  @override
  Widget build(BuildContext context) {
    final detalle = DatosMock.cuotaMercado;
    final colores = _paleta(context);
    // Agrupacion interior: moviles (Android + iOS) vs resto.
    final moviles = detalle
        .where((p) => p.categoria == 'Android' || p.categoria == 'iOS')
        .fold<double>(0, (s, p) => s + p.valor);
    final otros = detalle.fold<double>(0, (s, p) => s + p.valor) - moviles;
    return LienzoDescrito(
      titulo: 'fl_chart · Pastel anidado',
      paraQue:
          'Dos anillos concentricos: el interior muestra grandes grupos y el '
          'exterior su desglose, ligando el total con sus partes.',
      cuando:
          'Cuando los datos tienen dos niveles de jerarquia: categorias y '
          'subcategorias, regiones y paises, familias y productos.',
      grafica: Stack(
        alignment: Alignment.center,
        children: [
          // Anillo exterior: detalle.
          PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 75,
              sections: [
                for (int i = 0; i < detalle.length; i++)
                  PieChartSectionData(
                    value: detalle[i].valor,
                    title: detalle[i].categoria,
                    color: colores[i % colores.length],
                    radius: 35,
                    titleStyle: const TextStyle(
                        fontSize: 9, color: Colors.white),
                  ),
              ],
            ),
          ),
          // Anillo interior: agrupacion.
          PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 35,
              sections: [
                PieChartSectionData(
                    value: moviles,
                    title: 'Movil',
                    color: colores[0].withValues(alpha: 0.6),
                    radius: 35,
                    titleStyle: const TextStyle(
                        fontSize: 9, color: Colors.white)),
                PieChartSectionData(
                    value: otros,
                    title: 'Otros',
                    color: colores[2].withValues(alpha: 0.6),
                    radius: 35,
                    titleStyle: const TextStyle(
                        fontSize: 9, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 14. Dispersion + lineas de promedio.
/// Combina la nube de puntos con dos ejes de referencia (promedios),
/// dividiendo el plano en cuatro cuadrantes.
class FlDispersionPromedio extends StatelessWidget {
  const FlDispersionPromedio({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final esquema = Theme.of(context).colorScheme;
    final promX = datos.map((p) => p.x).reduce((a, b) => a + b) / datos.length;
    final promY = datos.map((p) => p.y).reduce((a, b) => a + b) / datos.length;
    return LienzoDescrito(
      titulo: 'fl_chart · Dispersion + promedios',
      paraQue:
          'A la nube de puntos le anade una linea de promedio en cada eje, '
          'partiendo el plano en cuatro cuadrantes para clasificar los puntos.',
      cuando:
          'Para analisis tipo "matriz": clasificar elementos como alto/bajo '
          'en dos dimensiones, por ejemplo esfuerzo vs impacto.',
      grafica: Stack(
        children: [
          ScatterChart(
            ScatterChartData(
              minX: 0,
              maxX: 100,
              minY: 0,
              maxY: 100,
              scatterSpots: [
                for (final p in datos)
                  ScatterSpot(
                    p.x,
                    p.y,
                    dotPainter: FlDotCirclePainter(
                        color: esquema.primary, radius: 5),
                  ),
              ],
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: 30)),
                bottomTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: 22)),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: true),
            ),
          ),
          // Lineas de promedio dibujadas con un LineChart transparente.
          LineChart(
            LineChartData(
              minX: 0,
              maxX: 100,
              minY: 0,
              maxY: 100,
              lineBarsData: const [],
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                      y: promY,
                      color: esquema.error.withValues(alpha: 0.6),
                      strokeWidth: 1.5,
                      dashArray: [5, 4]),
                ],
                verticalLines: [
                  VerticalLine(
                      x: promX,
                      color: esquema.error.withValues(alpha: 0.6),
                      strokeWidth: 1.5,
                      dashArray: [5, 4]),
                ],
              ),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineTouchData: const LineTouchData(enabled: false),
            ),
          ),
        ],
      ),
    );
  }
}

/// 15. Area + barras de hito.
/// Combina una tendencia continua (area) con barras que marcan eventos.
class FlAreaHitos extends StatelessWidget {
  const FlAreaHitos({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    // Hitos: los indices donde ocurre algo notable (cada 7 dias).
    final hitos = {6, 13, 20, 27};
    return LienzoDescrito(
      titulo: 'fl_chart · Area + hitos',
      paraQue:
          'El area muestra la evolucion continua y las barras verticales '
          'marcan momentos puntuales relevantes sobre esa evolucion.',
      cuando:
          'Cuando una serie continua tiene eventos destacados: ventas con '
          'fechas de campana, trafico con lanzamientos, metricas con cambios.',
      grafica: Stack(
        children: [
          LineChart(
            LineChartData(
              minY: 0,
              maxY: 100,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (int i = 0; i < datos.length; i++)
                      FlSpot(i.toDouble(), datos[i].valor),
                  ],
                  color: esquema.primary,
                  barWidth: 2,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: esquema.primary.withValues(alpha: 0.18),
                  ),
                ),
              ],
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: 30)),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
            ),
          ),
          LineChart(
            LineChartData(
              minX: 0,
              maxX: (datos.length - 1).toDouble(),
              minY: 0,
              maxY: 100,
              lineBarsData: const [],
              extraLinesData: ExtraLinesData(
                verticalLines: [
                  for (final h in hitos)
                    VerticalLine(
                        x: h.toDouble(),
                        color: esquema.tertiary.withValues(alpha: 0.7),
                        strokeWidth: 2),
                ],
              ),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineTouchData: const LineTouchData(enabled: false),
            ),
          ),
        ],
      ),
    );
  }
}

/// 16. Barras apiladas + lineas multiples.
/// Combina el total apilado por periodo con el recorrido de cada serie.
class FlApiladasLineas extends StatelessWidget {
  const FlApiladasLineas({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    final colores = _paleta(context);
    final n = series.first.puntos.length;
    return LienzoDescrito(
      titulo: 'fl_chart · Apiladas + lineas',
      paraQue:
          'Las barras apiladas muestran la composicion total de cada periodo '
          'y las lineas encima siguen el recorrido individual de cada serie.',
      cuando:
          'Cuando se necesita ver el conjunto apilado y, a la vez, como '
          'evoluciona cada componente por separado.',
      grafica: Stack(
        children: [
          BarChart(
            BarChartData(
              maxY: 130,
              barGroups: [
                for (int t = 0; t < n; t++)
                  BarChartGroupData(x: t, barRods: [
                    BarChartRodData(
                      toY: series.fold<double>(
                          0, (s, serie) => s + serie.puntos[t].valor),
                      width: 26,
                      rodStackItems: () {
                        final items = <BarChartRodStackItem>[];
                        double acum = 0;
                        for (int s = 0; s < series.length; s++) {
                          final v = series[s].puntos[t].valor;
                          items.add(BarChartRodStackItem(acum, acum + v,
                              colores[s % colores.length]
                                  .withValues(alpha: 0.4)));
                          acum += v;
                        }
                        return items;
                      }(),
                    ),
                  ]),
              ],
              titlesData: _titulos(
                  series.first.puntos.map((p) => p.categoria).toList()),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
          LineChart(
            LineChartData(
              minY: 0,
              maxY: 130,
              lineBarsData: [
                for (int s = 0; s < series.length; s++)
                  LineChartBarData(
                    spots: [
                      for (int i = 0; i < n; i++)
                        FlSpot(i.toDouble(), series[s].puntos[i].valor),
                    ],
                    color: colores[s % colores.length],
                    barWidth: 2,
                    dotData: const FlDotData(show: true),
                  ),
              ],
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineTouchData: const LineTouchData(enabled: false),
            ),
          ),
        ],
      ),
    );
  }
}

/// 17. Linea de doble eje (dos escalas distintas).
/// Combina dos lineas con rangos muy diferentes, cada una con su eje.
class FlLineaDobleEje extends StatelessWidget {
  const FlLineaDobleEje({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final esquema = Theme.of(context).colorScheme;
    final cats = datos.map((e) => e.categoria).toList();
    // Serie A: valores grandes (0-80). Serie B: valores pequenos (0-8).
    return LienzoDescrito(
      titulo: 'fl_chart · Doble eje',
      paraQue:
          'Muestra dos series de unidades muy distintas en el mismo grafico, '
          'cada una referida a su propio eje (izquierdo y derecho).',
      cuando:
          'Cuando se relacionan dos metricas de escalas diferentes: ingresos '
          '(miles) y numero de clientes (decenas), temperatura y lluvia.',
      grafica: Stack(
        children: [
          // Serie A — eje izquierdo (0-80).
          LineChart(
            LineChartData(
              minY: 0,
              maxY: 80,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (int i = 0; i < datos.length; i++)
                      FlSpot(i.toDouble(), datos[i].valor),
                  ],
                  color: esquema.primary,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: 30)),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) => _etiquetaX(cats, v)),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
          // Serie B — eje derecho (0-8).
          LineChart(
            LineChartData(
              minY: 0,
              maxY: 8,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (int i = 0; i < datos.length; i++)
                      FlSpot(i.toDouble(), datos[i].valor / 10),
                  ],
                  color: esquema.error,
                  barWidth: 3,
                  dashArray: [5, 3],
                  dotData: const FlDotData(show: false),
                ),
              ],
              titlesData: const FlTitlesData(
                rightTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: 28)),
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineTouchData: const LineTouchData(enabled: false),
            ),
          ),
        ],
      ),
    );
  }
}

/// 18. Embudo de conversion.
/// Combina barras horizontales centradas de ancho decreciente para
/// mostrar como se reduce una cantidad a traves de etapas.
class FlEmbudo extends StatelessWidget {
  const FlEmbudo({super.key});
  @override
  Widget build(BuildContext context) {
    final etapas = const [
      PuntoCategoria('Visitas', 100),
      PuntoCategoria('Registros', 64),
      PuntoCategoria('Pruebas', 38),
      PuntoCategoria('Compras', 20),
    ];
    final colores = _paleta(context);
    return LienzoDescrito(
      titulo: 'fl_chart · Embudo de conversion',
      paraQue:
          'Barras centradas que se angostan en cada etapa, mostrando cuanta '
          'cantidad se pierde al avanzar por un proceso de varios pasos.',
      cuando:
          'Para procesos con abandono entre fases: embudo de ventas, pasos '
          'de un registro, conversion de un sitio web.',
      grafica: RotatedBox(
        quarterTurns: 1,
        child: BarChart(
          BarChartData(
            minY: -55,
            maxY: 55,
            barGroups: [
              for (int i = 0; i < etapas.length; i++)
                BarChartGroupData(x: i, barRods: [
                  // Barra centrada: de -mitad a +mitad del valor.
                  BarChartRodData(
                    fromY: -etapas[i].valor / 2,
                    toY: etapas[i].valor / 2,
                    color: colores[i % colores.length],
                    width: 34,
                  ),
                ]),
            ],
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 44,
                  getTitlesWidget: (v, _) {
                    final i = v.toInt();
                    if (i < 0 || i >= etapas.length) return const SizedBox();
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                          '${etapas[i].categoria}\n${etapas[i].valor.toInt()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 9)),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
          ),
        ),
      ),
    );
  }
}

/// 19. Pareto (barras ordenadas + linea de porcentaje acumulado).
/// Combina barras descendentes con una linea acumulada para el 80/20.
class FlPareto extends StatelessWidget {
  const FlPareto({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = [...DatosMock.ventasMensuales]
      ..sort((a, b) => b.valor.compareTo(a.valor));
    final esquema = Theme.of(context).colorScheme;
    final total = datos.fold<double>(0, (s, p) => s + p.valor);
    // Porcentaje acumulado.
    final acum = <double>[];
    double suma = 0;
    for (final p in datos) {
      suma += p.valor;
      acum.add(suma / total * 100);
    }
    final cats = datos.map((e) => e.categoria).toList();
    return LienzoDescrito(
      titulo: 'fl_chart · Pareto',
      paraQue:
          'Barras ordenadas de mayor a menor con una linea de porcentaje '
          'acumulado, para ver que pocas categorias concentran casi todo.',
      cuando:
          'Para el analisis 80/20: identificar las causas o productos que '
          'generan la mayor parte del resultado y priorizarlos.',
      grafica: Stack(
        children: [
          BarChart(
            BarChartData(
              maxY: 85,
              barGroups: [
                for (int i = 0; i < datos.length; i++)
                  BarChartGroupData(x: i, barRods: [
                    BarChartRodData(
                        toY: datos[i].valor,
                        color: esquema.primary.withValues(alpha: 0.55),
                        width: 18),
                  ]),
              ],
              titlesData: _titulos(cats),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
          // Linea de % acumulado, escalada a 0-85 (donde 85 = 100%).
          LineChart(
            LineChartData(
              minY: 0,
              maxY: 85,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (int i = 0; i < acum.length; i++)
                      FlSpot(i.toDouble(), acum[i] / 100 * 85),
                  ],
                  color: esquema.error,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                ),
              ],
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineTouchData: const LineTouchData(enabled: false),
            ),
          ),
        ],
      ),
    );
  }
}

/// 20. Mapa de calor en cuadricula.
/// Combina dispersion con cuadrados coloreados por intensidad, formando
/// una matriz de dos dimensiones categoricas.
class FlMapaCalor extends StatelessWidget {
  const FlMapaCalor({super.key});
  @override
  Widget build(BuildContext context) {
    // Submatriz 7 dias x 8 horas para que las celdas sean legibles.
    final celdas =
        DatosMock.matrizCalor.where((c) => c.x < 8).toList();
    final esquema = Theme.of(context).colorScheme;
    Color colorIntensidad(double v) =>
        Color.lerp(esquema.surfaceContainerHighest, esquema.primary, v / 100)!;
    return LienzoDescrito(
      titulo: 'fl_chart · Mapa de calor',
      paraQue:
          'Una cuadricula donde el color de cada celda codifica la intensidad '
          'de un valor en el cruce de dos dimensiones categoricas.',
      cuando:
          'Para ver patrones en dos dimensiones: actividad por dia y hora, '
          'ventas por region y mes, correlaciones entre variables.',
      grafica: ScatterChart(
        ScatterChartData(
          minX: -1,
          maxX: 8,
          minY: -1,
          maxY: 7,
          scatterSpots: [
            for (final c in celdas)
              ScatterSpot(
                c.x.toDouble(),
                c.y.toDouble(),
                dotPainter: FlDotSquarePainter(
                  color: colorIntensidad(c.intensidad),
                  size: 22,
                  strokeWidth: 0,
                ),
              ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 24)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 20)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
// 21. Linea punteada.
/// Una linea con trazo discontinuo (dashArray): util para diferenciar
/// visualmente datos estimados o proyectados de los reales.
class FlLineaPunteada extends StatelessWidget {
  const FlLineaPunteada({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final color = Theme.of(context).colorScheme.primary;
    return LienzoDescrito(
      titulo: 'fl_chart · Linea punteada',
      paraQue:
          'Una linea cuyo trazo es discontinuo, lo que la distingue de una '
          'serie solida y comunica que el dato es una estimacion o un plan.',
      cuando:
          'Para proyecciones, metas o pronosticos: ventas esperadas, '
          'presupuesto planificado, tendencia estimada a futuro.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 80,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < datos.length; i++)
                  FlSpot(i.toDouble(), datos[i].valor),
              ],
              color: color,
              barWidth: 3,
              dashArray: [8, 6],
              dotData: const FlDotData(show: true),
            ),
          ],
          titlesData: _titulos(datos.map((e) => e.categoria).toList()),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
 
/// 22. Barras con bordes redondeados grandes (estilo "pill").
/// Columnas con radio igual a la mitad del ancho y degradado vertical.
class FlBarrasPill extends StatelessWidget {
  const FlBarrasPill({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final esquema = Theme.of(context).colorScheme;
    const ancho = 26.0;
    return LienzoDescrito(
      titulo: 'fl_chart · Barras pill',
      paraQue:
          'Columnas con extremos totalmente redondeados, en forma de capsula, '
          'que dan un aspecto suave y moderno al mismo comparativo de barras.',
      cuando:
          'En tableros y apps de estilo moderno donde la estetica cuenta y '
          'hay pocas categorias, para que las capsulas no se aprieten.',
      grafica: BarChart(
        BarChartData(
          maxY: 80,
          barGroups: [
            for (int i = 0; i < datos.length; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: datos[i].valor,
                  width: ancho,
                  borderRadius: BorderRadius.circular(ancho / 2),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [esquema.primary, esquema.tertiary],
                  ),
                ),
              ]),
          ],
          titlesData: _titulos(datos.map((e) => e.categoria).toList()),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
        ),
      ),
    );
  }
}
 
/// 23. Pastel con una seccion separada.
/// fl_chart no trae un parametro para "explotar" una porcion, asi que se
/// simula con dos PieChart apilados: el de abajo dibuja todas las porciones
/// menos la destacada, y el de arriba solo la destacada, desplazada con
/// Transform.translate en la direccion de su angulo central.
class FlPastelSeparado extends StatelessWidget {
  const FlPastelSeparado({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cuotaMercado;
    final colores = _paleta(context);
    const separacion = 16.0;
    const inicio = -90.0; // la primera porcion arranca arriba (12 en punto)
    final total = datos.fold<double>(0, (s, p) => s + p.valor);
 
    // Porcion destacada: la de mayor valor.
    var destacada = 0;
    for (int i = 1; i < datos.length; i++) {
      if (datos[i].valor > datos[destacada].valor) destacada = i;
    }
 
    // Angulo central de esa porcion, para saber hacia donde desplazarla.
    final previo =
        datos.take(destacada).fold<double>(0, (s, p) => s + p.valor);
    final centro =
        inicio + (previo + datos[destacada].valor / 2) / total * 360;
    final rad = centro * math.pi / 180;
 
    // [soloDestacada] = true dibuja unicamente la porcion destacada;
    // false dibuja todas las demas. Las ocultas quedan transparentes para
    // conservar los mismos angulos en ambas capas.
    PieChartData construir(bool soloDestacada) => PieChartData(
          startDegreeOffset: inicio,
          sectionsSpace: 2,
          centerSpaceRadius: 0,
          sections: [
            for (int i = 0; i < datos.length; i++)
              PieChartSectionData(
                value: datos[i].valor,
                title: '${datos[i].categoria}\n${datos[i].valor.toInt()}%',
                color: (i == destacada) == soloDestacada
                    ? colores[i % colores.length]
                    : Colors.transparent,
                showTitle: (i == destacada) == soloDestacada,
                radius: 100,
                titleStyle:
                    const TextStyle(fontSize: 11, color: Colors.white),
              ),
          ],
        );
 
    return LienzoDescrito(
      titulo: 'fl_chart · Pastel con seccion separada',
      paraQue:
          'Un pastel en el que una porcion se desplaza hacia afuera del '
          'centro para llamar la atencion sobre ella.',
      cuando:
          'Cuando hay una categoria clave que se quiere resaltar frente al '
          'resto: la region lider, el producto estrella, el mayor gasto.',
      grafica: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(construir(false)),
          Transform.translate(
            offset: Offset(
              separacion * math.cos(rad),
              separacion * math.sin(rad),
            ),
            child: PieChart(construir(true)),
          ),
        ],
      ),
    );
  }
}
 
/// 24. Lineas con relleno entre dos series.
/// Usa betweenBarsData para colorear la brecha entre ambas lineas.
class FlLineasRelleno extends StatelessWidget {
  const FlLineasRelleno({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    final a = series[0];
    final b = series[1];
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Lineas con relleno entre series',
      paraQue:
          'Dos lineas curvas con el espacio entre ellas coloreado, de modo '
          'que la brecha entre una serie y otra se lea como una mancha.',
      cuando:
          'Para resaltar la distancia entre dos series: real contra '
          'presupuesto, este ano contra el anterior, oferta contra demanda.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 60,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < a.puntos.length; i++)
                  FlSpot(i.toDouble(), a.puntos[i].valor),
              ],
              isCurved: true,
              color: esquema.primary,
              barWidth: 3,
              dotData: const FlDotData(show: false),
            ),
            LineChartBarData(
              spots: [
                for (int i = 0; i < b.puntos.length; i++)
                  FlSpot(i.toDouble(), b.puntos[i].valor),
              ],
              isCurved: true,
              color: esquema.tertiary,
              barWidth: 3,
              dotData: const FlDotData(show: false),
            ),
          ],
          betweenBarsData: [
            BetweenBarsData(
              fromIndex: 0,
              toIndex: 1,
              gradient: LinearGradient(colors: [
                esquema.primary.withValues(alpha: 0.35),
                esquema.tertiary.withValues(alpha: 0.35),
              ]),
            ),
          ],
          titlesData:
              _titulos(a.puntos.map((p) => p.categoria).toList()),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
 
/// 25. Barras positivas y negativas.
/// Valores con signo: color segun signo y linea base en cero.
class FlBarrasPosNeg extends StatelessWidget {
  const FlBarrasPosNeg({super.key});
  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo locales (variacion mensual, con signo).
    const cats = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul'];
    const cambios = [12.0, -8.0, 15.0, -14.0, 6.0, -4.0, 18.0];
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Barras positivas y negativas',
      paraQue:
          'Barras que salen hacia arriba o hacia abajo de una linea base en '
          'cero, con un color distinto segun el valor sea positivo o negativo.',
      cuando:
          'Para variaciones, saldos o diferencias: ganancia y perdida por '
          'mes, cambio porcentual, balance de ingresos menos gastos.',
      grafica: BarChart(
        BarChartData(
          minY: -20,
          maxY: 20,
          barGroups: [
            for (int i = 0; i < cambios.length; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: cambios[i],
                  color: cambios[i] >= 0 ? esquema.primary : esquema.error,
                  width: 18,
                  borderRadius: cambios[i] >= 0
                      ? const BorderRadius.vertical(top: Radius.circular(4))
                      : const BorderRadius.vertical(
                          bottom: Radius.circular(4)),
                ),
              ]),
          ],
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                  y: 0, color: esquema.outline, strokeWidth: 1.5),
            ],
          ),
          titlesData: _titulos(cats),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
        ),
      ),
    );
  }
}
 
/// 26. Dispersion con tamano por valor.
/// Antesala de la burbuja: el radio y la opacidad de cada punto crecen con
/// su propio valor en Y (no hay una tercera variable).
class FlDispersionTamano extends StatelessWidget {
  const FlDispersionTamano({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final color = Theme.of(context).colorScheme.primary;
    return LienzoDescrito(
      titulo: 'fl_chart · Dispersion con tamano por valor',
      paraQue:
          'Puntos cuyo radio y opacidad crecen con su valor, de modo que los '
          'datos mas altos pesan mas a la vista que los bajos.',
      cuando:
          'Para reforzar visualmente la magnitud en una dispersion: hacer '
          'que los valores extremos salten a la vista sin una tercera '
          'variable (si la hay, usar la burbuja).',
      grafica: ScatterChart(
        ScatterChartData(
          minX: 0,
          maxX: 100,
          minY: 0,
          maxY: 100,
          scatterSpots: [
            for (final p in datos)
              ScatterSpot(
                p.x,
                p.y,
                dotPainter: FlDotCirclePainter(
                  color: color.withValues(
                      alpha:
                          0.3 + 0.6 * (p.y / 100).clamp(0.0, 1.0).toDouble()),
                  radius:
                      3 + 10 * (p.y / 100).clamp(0.0, 1.0).toDouble(),
                ),
              ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}
 
/// 27. Area escalonada (step).
/// Linea en escalones (isStepLineChart) con el area rellena debajo.
class FlAreaEscalonada extends StatelessWidget {
  const FlAreaEscalonada({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final color = Theme.of(context).colorScheme.primary;
    return LienzoDescrito(
      titulo: 'fl_chart · Area escalonada',
      paraQue:
          'Una area cuyo borde avanza en escalones: el valor se mantiene '
          'constante hasta que cambia de golpe, sin rampas entre puntos.',
      cuando:
          'Para magnitudes que cambian por saltos y se sostienen entre '
          'cambios: inventario, tarifas, nivel de stock, capacidad instalada.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < datos.length; i++)
                  FlSpot(i.toDouble(), datos[i].valor),
              ],
              isStepLineChart: true,
              lineChartStepData: const LineChartStepData(
                  stepDirection: LineChartStepData.stepDirectionForward),
              color: color,
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: color.withValues(alpha: 0.25),
              ),
            ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
 
/// 28. Barras con linea de meta.
/// La linea de objetivo se dibuja con extraLinesData del propio BarChart,
/// asi queda alineada con el eje Y (sin necesidad de apilar dos graficas).
class FlBarrasMeta extends StatelessWidget {
  const FlBarrasMeta({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final esquema = Theme.of(context).colorScheme;
    const meta = 45.0;
    return LienzoDescrito(
      titulo: 'fl_chart · Barras con linea de meta',
      paraQue:
          'Columnas con una linea horizontal de objetivo; las barras que '
          'alcanzan la meta se pintan fuertes y las que no, atenuadas.',
      cuando:
          'Cuando cada periodo se evalua contra un objetivo fijo: ventas '
          'contra cuota, produccion contra plan, tickets contra SLA.',
      grafica: BarChart(
        BarChartData(
          maxY: 80,
          barGroups: [
            for (int i = 0; i < datos.length; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: datos[i].valor,
                  color: datos[i].valor >= meta
                      ? esquema.primary
                      : esquema.primary.withValues(alpha: 0.4),
                  width: 18,
                  borderRadius: BorderRadius.circular(4),
                ),
              ]),
          ],
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: meta,
                color: esquema.error,
                strokeWidth: 2,
                dashArray: [6, 4],
                label: HorizontalLineLabel(
                  show: true,
                  labelResolver: (_) => 'Meta ${meta.toInt()}',
                  style: TextStyle(fontSize: 10, color: esquema.error),
                ),
              ),
            ],
          ),
          titlesData: _titulos(datos.map((e) => e.categoria).toList()),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
        ),
      ),
    );
  }
}
 
/// 29. Dona con multiples anillos finos.
/// Tres PieChart concentricos (como el pastel anidado), cada uno con un
/// avance sobre 100 y un riel gris de fondo; leyenda en el centro.
class FlDonaAnillosFinos extends StatelessWidget {
  const FlDonaAnillosFinos({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final colores = _paleta(context);
    // Datos de ejemplo locales (avance de cada indicador, sobre 100).
    const nombres = ['Ventas', 'Cobros', 'Entregas'];
    const avance = [82.0, 61.0, 38.0];
    const grosor = 12.0; // ancho de cada anillo
    const hueco = 6.0; // separacion entre anillos
    const radioLibre = 56.0; // hueco central del anillo mas interno
    return LienzoDescrito(
      titulo: 'fl_chart · Dona con anillos finos',
      paraQue:
          'Varios anillos delgados concentricos, cada uno con su propio '
          'avance, que se leen como indicadores de progreso comparables.',
      cuando:
          'Para mostrar el cumplimiento de varias metas a la vez en poco '
          'espacio: anillos de actividad, avance de objetivos por area.',
      grafica: Stack(
        alignment: Alignment.center,
        children: [
          // El indice 0 es el anillo exterior.
          for (int i = 0; i < nombres.length; i++)
            PieChart(
              PieChartData(
                startDegreeOffset: -90,
                sectionsSpace: 0,
                centerSpaceRadius:
                    radioLibre + (nombres.length - 1 - i) * (grosor + hueco),
                sections: [
                  PieChartSectionData(
                    value: avance[i],
                    color: colores[i % colores.length],
                    radius: grosor,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: 100 - avance[i],
                    color: esquema.surfaceContainerHighest,
                    radius: grosor,
                    showTitle: false,
                  ),
                ],
              ),
            ),
          // Leyenda en el hueco central.
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < nombres.length; i++)
                Text(
                  '● ${nombres[i]} ${avance[i].toInt()}%',
                  style: TextStyle(
                      fontSize: 9, color: colores[i % colores.length]),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
 
/// 30. Linea con puntos de colores por umbral.
/// getDotPainter decide el color de cada punto segun su valor.
class FlLineaUmbral extends StatelessWidget {
  const FlLineaUmbral({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    const umbral = 60.0;
    return LienzoDescrito(
      titulo: 'fl_chart · Linea con puntos por umbral',
      paraQue:
          'Una linea cuyos puntos cambian de color segun superen o no un '
          'umbral, marcado con una linea de referencia.',
      cuando:
          'Para detectar de un vistazo que lecturas quedan dentro o fuera '
          'de un limite: temperatura, tiempos de respuesta, indicadores KPI.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: umbral,
                color: esquema.outline,
                strokeWidth: 1.5,
                dashArray: [6, 4],
                label: HorizontalLineLabel(
                  show: true,
                  labelResolver: (_) => 'Umbral ${umbral.toInt()}',
                  style: TextStyle(fontSize: 10, color: esquema.outline),
                ),
              ),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < datos.length; i++)
                  FlSpot(i.toDouble(), datos[i].valor),
              ],
              color: esquema.primary.withValues(alpha: 0.5),
              barWidth: 2,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                  radius: 5,
                  color: spot.y >= umbral ? esquema.primary : esquema.error,
                  strokeWidth: 1.5,
                  strokeColor: esquema.surface,
                ),
              ),
            ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
 
/// 31. Barras horizontales apiladas.
/// Combina el apilado de FlBarrasApiladas con la rotacion de
/// FlBarrasHorizontales (RotatedBox).
class FlBarrasHorizApiladas extends StatelessWidget {
  const FlBarrasHorizApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    final colores = _paleta(context);
    final periodos = series.first.puntos.map((p) => p.categoria).toList();
    return LienzoDescrito(
      titulo: 'fl_chart · Barras horizontales apiladas',
      paraQue:
          'Barras tumbadas donde cada una se compone de segmentos apilados: '
          'muestra el total de cada categoria y su desglose por serie.',
      cuando:
          'Cuando hay etiquetas largas o muchas categorias y ademas importa '
          'la composicion: ventas por canal en cada region, gasto por rubro.',
      grafica: RotatedBox(
        quarterTurns: 1,
        child: BarChart(
          BarChartData(
            maxY: 130,
            barGroups: [
              for (int t = 0; t < periodos.length; t++)
                BarChartGroupData(x: t, barRods: [
                  BarChartRodData(
                    toY: series.fold<double>(
                        0, (suma, s) => suma + s.puntos[t].valor),
                    width: 22,
                    rodStackItems: _apilar(series, t, colores),
                  ),
                ]),
            ],
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: (v, _) {
                    final i = v.toInt();
                    if (i < 0 || i >= periodos.length) {
                      return const SizedBox();
                    }
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Text(periodos[i],
                          style: const TextStyle(fontSize: 10)),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: true, drawVerticalLine: false),
          ),
        ),
      ),
    );
  }
 
  List<BarChartRodStackItem> _apilar(
      List<SerieNombrada> series, int t, List<Color> colores) {
    final items = <BarChartRodStackItem>[];
    double acumulado = 0;
    for (int s = 0; s < series.length; s++) {
      final v = series[s].puntos[t].valor;
      items.add(BarChartRodStackItem(
          acumulado, acumulado + v, colores[s % colores.length]));
      acumulado += v;
    }
    return items;
  }
}