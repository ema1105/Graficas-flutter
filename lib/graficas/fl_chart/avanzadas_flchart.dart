import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/lienzo_descrito.dart';

import '../../mock/datos_mock.dart';
import 'dart:math' as math;

// ============================================================
// Variantes que aprovechan la personalizacion de fl_chart:
// curvas, sombras, toque, apilado y bandas.
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

/// 1. Radar (dos perfiles superpuestos).
class FlRadar extends StatelessWidget {
  const FlRadar({super.key});
  @override
  Widget build(BuildContext context) {
    final ejes = DatosMock.perfilRadar;
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Radar',
      paraQue:
          'Compara dos entidades en varias dimensiones a la vez, superponiendo '
          'sus poligonos para ver en que criterios gana cada una.',
      cuando:
          'Para enfrentar dos perfiles multidimensionales: dos jugadores, dos '
          'productos, dos candidatos evaluados en los mismos criterios.',
      grafica: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          dataSets: [
            RadarDataSet(
              dataEntries:
                  DatosMock.perfilRadar.map((e) => RadarEntry(value: e.valor)).toList(),
              borderColor: esquema.primary,
              fillColor: esquema.primary.withValues(alpha: 0.2),
              borderWidth: 2,
            ),
            RadarDataSet(
              dataEntries: DatosMock.perfilRadar2
                  .map((e) => RadarEntry(value: e.valor))
                  .toList(),
              borderColor: esquema.tertiary,
              fillColor: esquema.tertiary.withValues(alpha: 0.2),
              borderWidth: 2,
            ),
          ],
          getTitle: (index, angle) =>
              RadarChartTitle(text: ejes[index % ejes.length].eje),
          tickCount: 4,
          ticksTextStyle:
              const TextStyle(fontSize: 9, color: Colors.transparent),
        ),
      ),
    );
  }
}

/// 2. Linea curva con sombra.
class FlLineaCurvaSombra extends StatelessWidget {
  const FlLineaCurvaSombra({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final color = Theme.of(context).colorScheme.primary;
    return LienzoDescrito(
      titulo: 'fl_chart · Linea curva con sombra',
      paraQue:
          'Suaviza la linea con curvas y le anade una sombra, dando una '
          'lectura de tendencia mas fluida y con relieve visual.',
      cuando:
          'Cuando la estetica importa y los datos no requieren precision de '
          'punto a punto: pantallas de inicio, resumenes visuales.',
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
              isCurved: true,
              color: color,
              barWidth: 4,
              dotData: const FlDotData(show: false),
              shadow: const Shadow(
                  color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
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

/// 3. Barras con fondo.
class FlBarrasConFondo extends StatelessWidget {
  const FlBarrasConFondo({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Barras con fondo',
      paraQue:
          'Dibuja detras de cada barra una barra fantasma que representa el '
          'maximo posible, para leer cada valor como proporcion de ese tope.',
      cuando:
          'Cuando cada barra se interpreta contra un maximo o meta comun: '
          'porcentaje de capacidad usada, avance sobre un objetivo fijo.',
      grafica: BarChart(
        BarChartData(
          maxY: 80,
          barGroups: [
            for (int i = 0; i < datos.length; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: datos[i].valor,
                  color: esquema.primary,
                  width: 18,
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 80,
                    color: esquema.surfaceContainerHighest,
                  ),
                ),
              ]),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) =>
                    _etiquetaX(datos.map((e) => e.categoria).toList(), v),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

/// 4. Pastel con seccion resaltada al tocar.
class FlPastelInteractivo extends StatefulWidget {
  const FlPastelInteractivo({super.key});
  @override
  State<FlPastelInteractivo> createState() => _FlPastelInteractivoState();
}

class _FlPastelInteractivoState extends State<FlPastelInteractivo> {
  int _tocado = -1;
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cuotaMercado;
    final colores = _paleta(context);
    return LienzoDescrito(
      titulo: 'fl_chart · Pastel interactivo',
      paraQue:
          'Un pastel que resalta y agranda la porcion que el usuario toca, '
          'invitando a explorar los datos con el dedo.',
      cuando:
          'En apps donde el usuario inspecciona activamente: tableros '
          'interactivos, informes que se navegan en pantalla.',
      grafica: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 30,
          pieTouchData: PieTouchData(
            touchCallback: (evento, respuesta) {
              setState(() {
                _tocado =
                    respuesta?.touchedSection?.touchedSectionIndex ?? -1;
              });
            },
          ),
          sections: [
            for (int i = 0; i < datos.length; i++)
              PieChartSectionData(
                value: datos[i].valor,
                title: datos[i].categoria,
                color: colores[i % colores.length],
                radius: i == _tocado ? 120 : 100,
                titleStyle: TextStyle(
                    fontSize: i == _tocado ? 14 : 11, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

/// 5. Burbuja.
class FlBurbuja extends StatelessWidget {
  const FlBurbuja({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final color = Theme.of(context).colorScheme.tertiary;
    return LienzoDescrito(
      titulo: 'fl_chart · Burbuja',
      paraQue:
          'Como una dispersion, pero el tamano de cada punto codifica una '
          'tercera variable, mostrando tres datos por punto.',
      cuando:
          'Cuando hay tres dimensiones numericas que relacionar: ingreso vs '
          'gasto vs tamano de empresa, por ejemplo.',
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
                    color: color.withValues(alpha: 0.5), radius: p.tamano),
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

/// 6. Linea con tooltip de toque.
class FlLineaTooltip extends StatelessWidget {
  const FlLineaTooltip({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Linea con tooltip',
      paraQue:
          'Al tocar la linea, muestra en un globo el valor exacto del punto, '
          'uniendo la vista general con la consulta puntual.',
      cuando:
          'Cuando la serie tiene muchos puntos y el usuario necesita conocer '
          'el valor concreto de alguno sin saturar la grafica de etiquetas.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => esquema.inverseSurface,
              getTooltipItems: (spots) => spots
                  .map((s) => LineTooltipItem(
                        s.y.toStringAsFixed(1),
                        TextStyle(color: esquema.onInverseSurface),
                      ))
                  .toList(),
            ),
          ),
          lineBarsData: [
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

/// 7. Barras agrupadas.
class FlBarrasAgrupadas extends StatelessWidget {
  const FlBarrasAgrupadas({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    final colores = _paleta(context);
    final trimestres = series.first.puntos.length;
    return LienzoDescrito(
      titulo: 'fl_chart · Barras agrupadas',
      paraQue:
          'Coloca varias barras juntas por cada categoria, para comparar '
          'varias series dentro de cada periodo lado a lado.',
      cuando:
          'Cuando se comparan varios elementos en cada categoria: ventas de '
          'tres productos por trimestre, resultados por region y ano.',
      grafica: BarChart(
        BarChartData(
          maxY: 60,
          barGroups: [
            for (int t = 0; t < trimestres; t++)
              BarChartGroupData(
                x: t,
                barsSpace: 4,
                barRods: [
                  for (int s = 0; s < series.length; s++)
                    BarChartRodData(
                      toY: series[s].puntos[t].valor,
                      color: colores[s % colores.length],
                      width: 10,
                    ),
                ],
              ),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) => _etiquetaX(
                    series.first.puntos.map((p) => p.categoria).toList(), v),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

/// 8. Area apilada.
class FlAreaApilada extends StatelessWidget {
  const FlAreaApilada({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    final colores = _paleta(context);
    final acumuladas = <List<double>>[];
    for (int s = 0; s < series.length; s++) {
      final fila = <double>[];
      for (int i = 0; i < series[s].puntos.length; i++) {
        final previo = s == 0 ? 0.0 : acumuladas[s - 1][i];
        fila.add(previo + series[s].puntos[i].valor);
      }
      acumuladas.add(fila);
    }
    return LienzoDescrito(
      titulo: 'fl_chart · Area apilada',
      paraQue:
          'Apila el area de varias series una sobre otra, mostrando el total '
          'acumulado y el aporte de cada serie a ese total.',
      cuando:
          'Cuando interesa el volumen total a lo largo del tiempo y como se '
          'compone: trafico por fuente, ingresos por canal acumulados.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 130,
          lineBarsData: [
            for (int s = series.length - 1; s >= 0; s--)
              LineChartBarData(
                spots: [
                  for (int i = 0; i < acumuladas[s].length; i++)
                    FlSpot(i.toDouble(), acumuladas[s][i]),
                ],
                color: colores[s % colores.length],
                barWidth: 2,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: colores[s % colores.length].withValues(alpha: 0.4),
                ),
              ),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) => _etiquetaX(
                    series.first.puntos.map((p) => p.categoria).toList(), v),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

/// 9. Lineas de referencia.
class FlLineasReferencia extends StatelessWidget {
  const FlLineasReferencia({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    final promedio =
        datos.map((p) => p.valor).reduce((a, b) => a + b) / datos.length;
    return LienzoDescrito(
      titulo: 'fl_chart · Lineas de referencia',
      paraQue:
          'Traza la serie y superpone una linea horizontal de referencia (el '
          'promedio), para ver que puntos estan por encima o por debajo.',
      cuando:
          'Cuando los valores se juzgan contra un umbral fijo: promedio, meta, '
          'limite aceptable, linea de equilibrio.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: promedio,
                color: esquema.error,
                strokeWidth: 2,
                dashArray: [6, 4],
                label: HorizontalLineLabel(
                  show: true,
                  labelResolver: (_) => 'Prom ${promedio.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 10, color: esquema.error),
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
              color: esquema.primary,
              barWidth: 2,
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

/// 10. Banda min-max.
class FlBandaMinMax extends StatelessWidget {
  const FlBandaMinMax({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    final inferior = <FlSpot>[];
    final superior = <FlSpot>[];
    for (int i = 0; i < datos.length; i++) {
      inferior.add(FlSpot(i.toDouble(), (datos[i].valor - 12).clamp(0, 100)));
      superior.add(FlSpot(i.toDouble(), (datos[i].valor + 12).clamp(0, 100)));
    }
    return LienzoDescrito(
      titulo: 'fl_chart · Banda min-max',
      paraQue:
          'Muestra una linea central con una banda sombreada entre un minimo '
          'y un maximo, delimitando el rango esperado.',
      cuando:
          'Para visualizar rangos de operacion normal: temperaturas minima y '
          'maxima, precios piso y techo, margenes de tolerancia.',
      grafica: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: superior,
              color: esquema.primary.withValues(alpha: 0.4),
              barWidth: 1,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: esquema.primary.withValues(alpha: 0.15),
              ),
            ),
            LineChartBarData(
              spots: inferior,
              color: esquema.primary.withValues(alpha: 0.4),
              barWidth: 1,
              dotData: const FlDotData(show: false),
            ),
            LineChartBarData(
              spots: [
                for (int i = 0; i < datos.length; i++)
                  FlSpot(i.toDouble(), datos[i].valor),
              ],
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

/// 11. Burbujas + cuadrantes.
/// Combina burbujas (3 variables) con dos ejes de promedio que parten
/// el plano en cuatro zonas.
class FlBurbujaCuadrantes extends StatelessWidget {
  const FlBurbujaCuadrantes({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final esquema = Theme.of(context).colorScheme;
    final promX = datos.map((p) => p.x).reduce((a, b) => a + b) / datos.length;
    final promY = datos.map((p) => p.y).reduce((a, b) => a + b) / datos.length;
    return LienzoDescrito(
      titulo: 'fl_chart · Burbujas + cuadrantes',
      paraQue:
          'Burbujas de tamano variable (tres datos por punto) sobre un plano '
          'dividido en cuatro cuadrantes por los promedios de cada eje.',
      cuando:
          'Para priorizar elementos por dos criterios considerando ademas su '
          'peso: matriz esfuerzo/impacto donde el tamano es el costo.',
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
                        color: esquema.tertiary.withValues(alpha: 0.5),
                        radius: p.tamano),
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

/// 12. Cascada (waterfall).
/// Barras flotantes encadenadas: cada una parte donde termino la suma
/// anterior, mostrando como un valor inicial sube y baja hasta un total.
class FlCascada extends StatelessWidget {
  const FlCascada({super.key});
  @override
  Widget build(BuildContext context) {
    final pasos = DatosMock.cascada; // valores con signo
    final esquema = Theme.of(context).colorScheme;
    // Calcular el inicio y fin de cada barra flotante.
    final rods = <BarChartGroupData>[];
    double acum = 0;
    final etiquetas = <String>[];
    for (int i = 0; i < pasos.length; i++) {
      final desde = acum;
      acum += pasos[i].valor;
      rods.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
          fromY: desde,
          toY: acum,
          color: pasos[i].valor >= 0 ? esquema.primary : esquema.error,
          width: 24,
        ),
      ]));
      etiquetas.add(pasos[i].categoria);
    }
    // Barra final: el total acumulado, desde 0.
    rods.add(BarChartGroupData(x: pasos.length, barRods: [
      BarChartRodData(
          fromY: 0, toY: acum, color: esquema.tertiary, width: 24),
    ]));
    etiquetas.add('Total');
    return LienzoDescrito(
      titulo: 'fl_chart · Cascada',
      paraQue:
          'Barras flotantes que se encadenan: cada una empieza donde termino '
          'la anterior, mostrando el efecto acumulado de sumas y restas.',
      cuando:
          'Para descomponer como se llega a un resultado: de ingreso bruto a '
          'neto restando costos, de saldo inicial a final paso por paso.',
      grafica: BarChart(
        BarChartData(
          minY: 0,
          maxY: 140,
          barGroups: rods,
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 34,
                getTitlesWidget: (v, _) {
                  final i = v.toInt();
                  if (i < 0 || i >= etiquetas.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(etiquetas[i],
                        style: const TextStyle(fontSize: 9)),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
        ),
      ),
    );
  }
}

/// 13. Barras + area de fondo (contexto).
/// Combina barras con una zona sombreada detras que marca un rango meta.
class FlBarrasAreaFondo extends StatelessWidget {
  const FlBarrasAreaFondo({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final esquema = Theme.of(context).colorScheme;
    final cats = datos.map((e) => e.categoria).toList();
    return LienzoDescrito(
      titulo: 'fl_chart · Barras + zona meta',
      paraQue:
          'Las barras muestran el valor de cada periodo sobre una franja de '
          'fondo que marca el rango objetivo, para ver quien cae dentro.',
      cuando:
          'Cuando cada valor se evalua contra un rango aceptable: ventas '
          'frente a la meta mensual, metricas dentro de un rango sano.',
      grafica: Stack(
        children: [
          // Zona meta de fondo (45-65) con un LineChart de anotacion.
          LineChart(
            LineChartData(
              minX: -0.5,
              maxX: (datos.length - 0.5),
              minY: 0,
              maxY: 85,
              lineBarsData: const [],
              rangeAnnotations: RangeAnnotations(
                horizontalRangeAnnotations: [
                  HorizontalRangeAnnotation(
                    y1: 45,
                    y2: 65,
                    color: esquema.tertiary.withValues(alpha: 0.15),
                  ),
                ],
              ),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              lineTouchData: const LineTouchData(enabled: false),
            ),
          ),
          BarChart(
            BarChartData(
              maxY: 85,
              barGroups: [
                for (int i = 0; i < datos.length; i++)
                  BarChartGroupData(x: i, barRods: [
                    BarChartRodData(
                        toY: datos[i].valor,
                        color: esquema.primary,
                        width: 18,
                        borderRadius: BorderRadius.circular(4)),
                  ]),
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
        ],
      ),
    );
  }
}

/// 14. Radar + barras laterales.
/// Combina el radar (perfil multidimensional) con una fila de barras que
/// dan el valor exacto de cada eje.
class FlRadarBarras extends StatelessWidget {
  const FlRadarBarras({super.key});
  @override
  Widget build(BuildContext context) {
    final ejes = DatosMock.perfilRadar;
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Radar + barras',
      paraQue:
          'El radar da la forma global del perfil y las barras de abajo el '
          'valor numerico exacto de cada dimension.',
      cuando:
          'Cuando el radar ayuda a ver el conjunto pero tambien se necesita '
          'leer con precision cada criterio por separado.',
      grafica: Column(
        children: [
          Expanded(
            child: RadarChart(
              RadarChartData(
                radarShape: RadarShape.polygon,
                dataSets: [
                  RadarDataSet(
                    dataEntries:
                        ejes.map((e) => RadarEntry(value: e.valor)).toList(),
                    borderColor: esquema.primary,
                    fillColor: esquema.primary.withValues(alpha: 0.25),
                    borderWidth: 2,
                  ),
                ],
                getTitle: (index, angle) =>
                    RadarChartTitle(text: ejes[index % ejes.length].eje),
                tickCount: 4,
                ticksTextStyle:
                    const TextStyle(fontSize: 9, color: Colors.transparent),
              ),
            ),
          ),
          SizedBox(
            height: 90,
            child: BarChart(
              BarChartData(
                maxY: 100,
                barGroups: [
                  for (int i = 0; i < ejes.length; i++)
                    BarChartGroupData(x: i, barRods: [
                      BarChartRodData(
                          toY: ejes[i].valor,
                          color: esquema.primary,
                          width: 12),
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
                        if (i < 0 || i >= ejes.length) return const SizedBox();
                        return Text(ejes[i].eje.substring(0, 3),
                            style: const TextStyle(fontSize: 8));
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 15. Termometro de progreso.
/// Combina una barra de progreso (lleno vs vacio) con una marca de meta.
class FlTermometro extends StatelessWidget {
  const FlTermometro({super.key});
  @override
  Widget build(BuildContext context) {
    final valor = DatosMock.valorMedidor; // 72
    const meta = 85.0;
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Termometro de progreso',
      paraQue:
          'Una barra que se llena segun el avance actual con una marca que '
          'senala la meta, comparando lo logrado con lo esperado.',
      cuando:
          'Para campanas y objetivos: fondos recaudados vs meta, progreso de '
          'un reto, avance de un proyecto contra su objetivo.',
      grafica: Center(
        child: SizedBox(
          width: 120,
          child: BarChart(
            BarChartData(
              maxY: 100,
              alignment: BarChartAlignment.center,
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(
                    toY: valor,
                    width: 60,
                    borderRadius: BorderRadius.circular(8),
                    color: esquema.primary,
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 100,
                      color: esquema.surfaceContainerHighest,
                    ),
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
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }
}

/// 16. Dispersion + linea de regresion.
/// Combina la nube de puntos con la recta de minimos cuadrados que la
/// resume.
class FlRegresion extends StatelessWidget {
  const FlRegresion({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final esquema = Theme.of(context).colorScheme;
    // Minimos cuadrados: pendiente m e intercepto b.
    final n = datos.length;
    final sumX = datos.fold<double>(0, (s, p) => s + p.x);
    final sumY = datos.fold<double>(0, (s, p) => s + p.y);
    final sumXY = datos.fold<double>(0, (s, p) => s + p.x * p.y);
    final sumX2 = datos.fold<double>(0, (s, p) => s + p.x * p.x);
    final m = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
    final b = (sumY - m * sumX) / n;
    return LienzoDescrito(
      titulo: 'fl_chart · Dispersion + regresion',
      paraQue:
          'A la nube de puntos le anade la recta que mejor los resume '
          '(minimos cuadrados), haciendo visible la tendencia subyacente.',
      cuando:
          'Cuando se quiere cuantificar la relacion entre dos variables y '
          'mostrar la direccion y fuerza de esa relacion.',
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
                        color: esquema.primary.withValues(alpha: 0.6),
                        radius: 4),
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
          LineChart(
            LineChartData(
              minX: 0,
              maxX: 100,
              minY: 0,
              maxY: 100,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, (b).clamp(0, 100)),
                    FlSpot(100, (m * 100 + b).clamp(0, 100)),
                  ],
                  color: esquema.error,
                  barWidth: 3,
                  dotData: const FlDotData(show: false),
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

/// 17. Velas japonesas (candlestick).
/// Combina un rango alto-bajo (linea fina) con el cuerpo apertura-cierre
/// (barra gruesa) por cada periodo.
class FlVelas extends StatelessWidget {
  const FlVelas({super.key});
  @override
  Widget build(BuildContext context) {
    final velas = DatosMock.velas.take(12).toList();
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Velas',
      paraQue:
          'Cada vela resume cuatro datos de un periodo: maximo y minimo (la '
          'mecha fina) y apertura y cierre (el cuerpo grueso).',
      cuando:
          'Para datos bursatiles o de mercado donde importan los cuatro '
          'valores del periodo y si cerro al alza o a la baja.',
      grafica: BarChart(
        BarChartData(
          minY: 50,
          maxY: 150,
          barGroups: [
            for (int i = 0; i < velas.length; i++)
              BarChartGroupData(
                x: i,
                groupVertically: true,
                barRods: [
                  // Mecha: de minimo a maximo, fina.
                  BarChartRodData(
                    fromY: velas[i].bajo,
                    toY: velas[i].alto,
                    color: esquema.onSurface.withValues(alpha: 0.5),
                    width: 3,
                  ),
                  // Cuerpo: de apertura a cierre, grueso.
                  BarChartRodData(
                    fromY: velas[i].apertura < velas[i].cierre
                        ? velas[i].apertura
                        : velas[i].cierre,
                    toY: velas[i].apertura < velas[i].cierre
                        ? velas[i].cierre
                        : velas[i].apertura,
                    color: velas[i].cierre >= velas[i].apertura
                        ? esquema.primary
                        : esquema.error,
                    width: 12,
                  ),
                ],
              ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 32)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
        ),
      ),
    );
  }
}

/// 18. Area comparativa (diferencia entre dos series).
/// Combina dos lineas con el relleno de la brecha entre ambas.
class FlAreaDiferencia extends StatelessWidget {
  const FlAreaDiferencia({super.key});
  @override
  Widget build(BuildContext context) {
    final a = DatosMock.seriesMultiples[0];
    final b = DatosMock.seriesMultiples[1];
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'fl_chart · Area de diferencia',
      paraQue:
          'Dos lineas con la zona entre ellas rellena, para que el tamano de '
          'la diferencia entre ambas series sea visible de inmediato.',
      cuando:
          'Cuando lo importante es la brecha entre dos series: ingresos vs '
          'gastos, oferta vs demanda, real vs presupuestado.',
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
              color: esquema.primary,
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
            LineChartBarData(
              spots: [
                for (int i = 0; i < b.puntos.length; i++)
                  FlSpot(i.toDouble(), b.puntos[i].valor),
              ],
              color: esquema.tertiary,
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          ],
          betweenBarsData: [
            BetweenBarsData(
              fromIndex: 0,
              toIndex: 1,
              color: esquema.primary.withValues(alpha: 0.15),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) =>
                    _etiquetaX(a.puntos.map((p) => p.categoria).toList(), v),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

/// 19. Barras agrupadas + linea objetivo.
/// Combina varias series por periodo con una linea horizontal de meta.
class FlAgrupadasObjetivo extends StatelessWidget {
  const FlAgrupadasObjetivo({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    final colores = _paleta(context);
    final esquema = Theme.of(context).colorScheme;
    final n = series.first.puntos.length;
    const objetivo = 40.0;
    final cats = series.first.puntos.map((p) => p.categoria).toList();
    return LienzoDescrito(
      titulo: 'fl_chart · Agrupadas + objetivo',
      paraQue:
          'Barras agrupadas por periodo con una linea horizontal de meta, '
          'para ver de un vistazo que series superan el objetivo.',
      cuando:
          'Cuando varias series se comparan entre si y, a la vez, contra un '
          'umbral comun: ventas de productos frente a la cuota minima.',
      grafica: Stack(
        children: [
          BarChart(
            BarChartData(
              maxY: 60,
              barGroups: [
                for (int t = 0; t < n; t++)
                  BarChartGroupData(x: t, barsSpace: 4, barRods: [
                    for (int s = 0; s < series.length; s++)
                      BarChartRodData(
                        toY: series[s].puntos[t].valor,
                        color: colores[s % colores.length],
                        width: 10,
                      ),
                  ]),
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
          LineChart(
            LineChartData(
              minX: -0.5,
              maxX: n - 0.5,
              minY: 0,
              maxY: 60,
              lineBarsData: const [],
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: objetivo,
                    color: esquema.error,
                    strokeWidth: 2,
                    dashArray: [6, 4],
                    label: HorizontalLineLabel(
                      show: true,
                      labelResolver: (_) => 'Objetivo ${objetivo.toInt()}',
                      style: TextStyle(fontSize: 10, color: esquema.error),
                    ),
                  ),
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

/// 20. Gantt / linea de tiempo.
/// Barras horizontales flotantes que van del inicio al fin de cada tarea,
/// mostrando duracion y solapamiento.
class FlGantt extends StatelessWidget {
  const FlGantt({super.key});
  @override
  Widget build(BuildContext context) {
    // Tareas: inicio y fin en una escala de semanas (0-12).
    final tareas = const [
      _Tarea('Analisis', 0, 3),
      _Tarea('Diseno', 2, 6),
      _Tarea('Desarrollo', 5, 10),
      _Tarea('Pruebas', 8, 12),
      _Tarea('Entrega', 11, 12),
    ];
    final colores = _paleta(context);
    return LienzoDescrito(
      titulo: 'fl_chart · Gantt',
      paraQue:
          'Cada barra horizontal va del inicio al fin de una tarea en una '
          'linea de tiempo, mostrando duracion y como se solapan las fases.',
      cuando:
          'Para planificar proyectos: cronogramas, fases de trabajo, '
          'calendarios de tareas con dependencias y solapamientos.',
      grafica: RotatedBox(
        quarterTurns: 1,
        child: BarChart(
          BarChartData(
            minY: 0,
            maxY: 12,
            barGroups: [
              for (int i = 0; i < tareas.length; i++)
                BarChartGroupData(x: i, barRods: [
                  BarChartRodData(
                    fromY: tareas[i].inicio.toDouble(),
                    toY: tareas[i].fin.toDouble(),
                    color: colores[i % colores.length],
                    width: 18,
                    borderRadius: BorderRadius.circular(4),
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
                  reservedSize: 60,
                  getTitlesWidget: (v, _) {
                    final i = v.toInt();
                    if (i < 0 || i >= tareas.length) return const SizedBox();
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Text(tareas[i].nombre,
                          style: const TextStyle(fontSize: 9)),
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
}

class _Tarea {
  final String nombre;
  final int inicio;
  final int fin;
  const _Tarea(this.nombre, this.inicio, this.fin);
}
// Espacio reservado compartido por las capas superpuestas.
const double _izq = 30;
const double _der = 36;
const double _inf = 24;
 
/// Eje que reserva espacio pero no dibuja nada: mantiene alineadas las
/// capas superpuestas.
AxisTitles _ejeVacio(double ancho) => AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: ancho,
        getTitlesWidget: (_, __) => const SizedBox.shrink(),
      ),
    );
 
const AxisTitles _ejeOculto =
    AxisTitles(sideTitles: SideTitles(showTitles: false));
 
/// Elemento de leyenda: cuadro de color + texto.
class _ItemLeyenda extends StatelessWidget {
  final Color color;
  final String texto;
  const _ItemLeyenda(this.color, this.texto);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(texto, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
 
/// 21. Velas + linea de volumen.
/// Velas japonesas arriba y, debajo, la linea de volumen del mismo
/// periodo, alineada vela por vela.
class FlVelasVolumen extends StatelessWidget {
  const FlVelasVolumen({super.key});
 
  // Volumen de ejemplo (miles de unidades) para las 12 sesiones.
  // DatosMock.velas no incluye volumen.
  static const _volumen = <double>[
    320.0, 410.0, 280.0, 520.0, 460.0, 380.0,
    610.0, 350.0, 430.0, 570.0, 300.0, 480.0,
  ];
 
  @override
  Widget build(BuildContext context) {
    final velas = DatosMock.velas.take(12).toList();
    final esquema = Theme.of(context).colorScheme;
    final n = velas.length;
    return LienzoDescrito(
      titulo: 'fl_chart · Velas + volumen',
      paraQue:
          'Las velas muestran apertura, cierre, maximo y minimo de cada '
          'periodo y, justo debajo, una linea con el volumen negociado, '
          'alineada vela por vela.',
      cuando:
          'Para analisis bursatil: confirmar si un movimiento de precio '
          'viene respaldado por volumen alto o es un salto con poco '
          'respaldo.',
      grafica: Column(
        children: [
          Expanded(
            flex: 3,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                minY: 50,
                maxY: 150,
                barGroups: [
                  for (int i = 0; i < n; i++)
                    BarChartGroupData(
                      x: i,
                      groupVertically: true,
                      barRods: [
                        BarChartRodData(
                          fromY: velas[i].bajo,
                          toY: velas[i].alto,
                          color: esquema.onSurface.withValues(alpha: 0.5),
                          width: 3,
                        ),
                        BarChartRodData(
                          fromY: math.min(velas[i].apertura, velas[i].cierre),
                          toY: math.max(velas[i].apertura, velas[i].cierre),
                          color: velas[i].cierre >= velas[i].apertura
                              ? esquema.primary
                              : esquema.error,
                          width: 12,
                        ),
                      ],
                    ),
                ],
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: _izq)),
                  bottomTitles: _ejeOculto,
                  rightTitles: _ejeOculto,
                  topTitles: _ejeOculto,
                ),
                borderData: FlBorderData(show: false),
                gridData:
                    const FlGridData(show: true, drawVerticalLine: false),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 1,
            child: LineChart(
              LineChartData(
                minX: -0.5,
                maxX: n - 0.5,
                minY: 0,
                maxY: 700,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (int i = 0; i < n; i++)
                        FlSpot(i.toDouble(), _volumen[i]),
                    ],
                    color: esquema.tertiary,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: esquema.tertiary.withValues(alpha: 0.2),
                    ),
                  ),
                ],
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: _izq,
                          interval: 300)),
                  bottomTitles: _ejeOculto,
                  rightTitles: _ejeOculto,
                  topTitles: _ejeOculto,
                ),
                borderData: FlBorderData(show: false),
                gridData:
                    const FlGridData(show: true, drawVerticalLine: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 22. Radar de tres perfiles.
/// Los dos perfiles de DatosMock mas un tercero calculado: el promedio de
/// ambos, que sirve de referencia.
class FlRadarTresPerfiles extends StatelessWidget {
  const FlRadarTresPerfiles({super.key});
  @override
  Widget build(BuildContext context) {
    final a = DatosMock.perfilRadar;
    final b = DatosMock.perfilRadar2;
    final esquema = Theme.of(context).colorScheme;
    final promedio = [
      for (int i = 0; i < a.length; i++) (a[i].valor + b[i].valor) / 2,
    ];
    return LienzoDescrito(
      titulo: 'fl_chart · Radar de tres perfiles',
      paraQue:
          'Superpone tres poligonos en los mismos ejes: dos entidades y un '
          'perfil de referencia (el promedio), para ver quien queda por '
          'encima o por debajo de la media en cada criterio.',
      cuando:
          'Para comparar dos candidatos o productos contra un estandar: '
          'dos jugadores contra el promedio del plantel, dos ofertas '
          'contra el mercado.',
      grafica: Column(
        children: [
          Expanded(
            child: RadarChart(
              RadarChartData(
                radarShape: RadarShape.polygon,
                dataSets: [
                  RadarDataSet(
                    dataEntries:
                        a.map((e) => RadarEntry(value: e.valor)).toList(),
                    borderColor: esquema.primary,
                    fillColor: esquema.primary.withValues(alpha: 0.18),
                    borderWidth: 2,
                  ),
                  RadarDataSet(
                    dataEntries:
                        b.map((e) => RadarEntry(value: e.valor)).toList(),
                    borderColor: esquema.tertiary,
                    fillColor: esquema.tertiary.withValues(alpha: 0.18),
                    borderWidth: 2,
                  ),
                  RadarDataSet(
                    dataEntries:
                        promedio.map((v) => RadarEntry(value: v)).toList(),
                    borderColor: esquema.error,
                    fillColor: Colors.transparent,
                    borderWidth: 2,
                  ),
                ],
                getTitle: (index, angle) =>
                    RadarChartTitle(text: a[index % a.length].eje),
                tickCount: 4,
                ticksTextStyle:
                    const TextStyle(fontSize: 9, color: Colors.transparent),
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            children: [
              _ItemLeyenda(esquema.primary, 'Perfil 1'),
              _ItemLeyenda(esquema.tertiary, 'Perfil 2'),
              _ItemLeyenda(esquema.error, 'Promedio'),
            ],
          ),
        ],
      ),
    );
  }
}
 
/// Dibuja un contorno (poligono) alrededor de su punto, en pixeles.
/// Se usa como "dotPainter" de un ScatterSpot ubicado en el centro de la
/// nube: asi la posicion la resuelve fl_chart y no hay que alinear nada.
class _PuntoContorno extends FlDotPainter {
  final List<Offset> contorno; // relativo al centro, en pixeles
  final Color color;
  const _PuntoContorno(this.contorno, this.color);
 
  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    final path = Path()
      ..addPolygon([for (final o in contorno) o + offsetInCanvas], true);
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: 0.15)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }
 
  @override
  Size getSize(FlSpot spot) => const Size(1, 1);
 
  @override
  Color get mainColor => color;
 
  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) => b;
 
  @override
  List<Object?> get props => [contorno, color];
}
 
/// 23. Dispersion con elipse de agrupacion.
/// Nube de puntos con la elipse de confianza al 95 % (covarianza de los
/// datos) dibujada alrededor.
class FlDispersionElipse extends StatelessWidget {
  const FlDispersionElipse({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final esquema = Theme.of(context).colorScheme;
    final n = datos.length;
 
    // Media y covarianza muestral.
    final mx = datos.fold<double>(0, (s, p) => s + p.x) / n;
    final my = datos.fold<double>(0, (s, p) => s + p.y) / n;
    final sxx =
        datos.fold<double>(0, (s, p) => s + (p.x - mx) * (p.x - mx)) / (n - 1);
    final syy =
        datos.fold<double>(0, (s, p) => s + (p.y - my) * (p.y - my)) / (n - 1);
    final sxy =
        datos.fold<double>(0, (s, p) => s + (p.x - mx) * (p.y - my)) / (n - 1);
 
    // Ejes principales de la elipse (autovalores de la covarianza).
    final angulo = 0.5 * math.atan2(2 * sxy, sxx - syy);
    final traza = sxx + syy;
    final det = sxx * syy - sxy * sxy;
    final disc = math.sqrt(math.max(0.0, traza * traza / 4 - det));
    final l1 = traza / 2 + disc;
    final l2 = math.max(0.0, traza / 2 - disc);
    const k = 2.4477; // raiz de chi-cuadrado(95 %, 2 g.l.) = sqrt(5.991)
    final semiA = k * math.sqrt(l1);
    final semiB = k * math.sqrt(l2);
 
    return LienzoDescrito(
      titulo: 'fl_chart · Dispersion + elipse',
      paraQue:
          'Muestra la nube de puntos y una elipse que encierra la zona donde '
          'se concentra la mayoria (aprox. 95 %), con su inclinacion '
          'indicando la correlacion entre las dos variables.',
      cuando:
          'Para ver la densidad y la forma de una nube: detectar puntos '
          'atipicos fuera de la elipse y apreciar si la relacion es '
          'fuerte (elipse estrecha) o debil (elipse redonda).',
      grafica: LayoutBuilder(
        builder: (context, c) {
          // Escala datos -> pixeles. Los ejes derecho y superior no
          // reservan espacio; el izquierdo y el inferior si.
          final pxX = (c.maxWidth - _izq) / 100;
          final pxY = (c.maxHeight - _inf) / 100;
          final contorno = <Offset>[
            for (int i = 0; i < 72; i++)
              () {
                final t = 2 * math.pi * i / 72;
                final ex = semiA * math.cos(t);
                final ey = semiB * math.sin(t);
                final dx = ex * math.cos(angulo) - ey * math.sin(angulo);
                final dy = ex * math.sin(angulo) + ey * math.cos(angulo);
                return Offset(dx * pxX, -dy * pxY);
              }(),
          ];
          return ScatterChart(
            ScatterChartData(
              minX: 0,
              maxX: 100,
              minY: 0,
              maxY: 100,
              scatterSpots: [
                // Primero la elipse: se dibuja en el orden de la lista,
                // asi que queda por debajo de los puntos.
                ScatterSpot(
                  mx,
                  my,
                  dotPainter: _PuntoContorno(contorno, esquema.tertiary),
                ),
                for (final p in datos)
                  ScatterSpot(
                    p.x,
                    p.y,
                    dotPainter: FlDotCirclePainter(
                        color: esquema.primary.withValues(alpha: 0.7),
                        radius: 4),
                  ),
              ],
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: _izq)),
                bottomTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: _inf)),
                rightTitles: _ejeOculto,
                topTitles: _ejeOculto,
              ),
              borderData: FlBorderData(show: true),
            ),
          );
        },
      ),
    );
  }
}
 
/// 24. Barras + banda de desviacion.
/// Columnas con una franja sombreada de promedio +/- 1 desviacion
/// estandar (poblacional) y la linea del promedio.
class FlBarrasBandaSigma extends StatelessWidget {
  const FlBarrasBandaSigma({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final esquema = Theme.of(context).colorScheme;
    final n = datos.length;
    final mu = datos.fold<double>(0, (s, p) => s + p.valor) / n;
    final sigma = math.sqrt(
        datos.fold<double>(0, (s, p) => s + (p.valor - mu) * (p.valor - mu)) /
            n);
    final cats = datos.map((e) => e.categoria).toList();
    return LienzoDescrito(
      titulo: 'fl_chart · Barras + banda de desviacion',
      paraQue:
          'Columnas sobre una franja que cubre el promedio mas/menos una '
          'desviacion estandar: las barras fuera de la franja se pintan '
          'distinto porque se alejan de lo habitual.',
      cuando:
          'Para control de calidad o monitoreo: detectar periodos '
          'anormalmente altos o bajos respecto de la variacion normal de '
          'la serie.',
      grafica: BarChart(
        BarChartData(
          maxY: 85,
          rangeAnnotations: RangeAnnotations(
            horizontalRangeAnnotations: [
              HorizontalRangeAnnotation(
                y1: mu - sigma,
                y2: mu + sigma,
                color: esquema.tertiary.withValues(alpha: 0.18),
              ),
            ],
          ),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: mu,
                color: esquema.tertiary,
                strokeWidth: 1.5,
                dashArray: [6, 4],
                label: HorizontalLineLabel(
                  show: true,
                  labelResolver: (_) => 'Prom ${mu.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 10, color: esquema.tertiary),
                ),
              ),
            ],
          ),
          barGroups: [
            for (int i = 0; i < n; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: datos[i].valor,
                  color: (datos[i].valor - mu).abs() <= sigma
                      ? esquema.primary
                      : esquema.error,
                  width: 18,
                  borderRadius: BorderRadius.circular(4),
                ),
              ]),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            rightTitles: _ejeOculto,
            topTitles: _ejeOculto,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) => _etiquetaX(cats, v),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
        ),
      ),
    );
  }
}
 
/// 25. Linea con area sobre/bajo umbral.
/// El relleno bajo la linea cambia de color en el nivel del umbral, usando
/// un degradado con corte duro (dos paradas en el mismo punto).
class FlLineaAreaUmbral extends StatelessWidget {
  const FlLineaAreaUmbral({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    const umbral = 60.0;
    const minY = 0.0;
    final spots = [
      for (int i = 0; i < datos.length; i++)
        FlSpot(i.toDouble(), datos[i].valor),
    ];
    // fl_chart aplica el degradado del relleno sobre el rectangulo que va
    // desde el punto mas alto de la serie hasta la base del grafico. La
    // posicion relativa del umbral dentro de ese rectangulo es:
    final techo = spots.map((s) => s.y).reduce(math.max);
    final corte = techo <= minY
        ? 0.0
        : ((techo - umbral) / (techo - minY)).clamp(0.0, 1.0).toDouble();
    return LienzoDescrito(
      titulo: 'fl_chart · Area sobre/bajo umbral',
      paraQue:
          'Una linea cuyo relleno cambia de color en el nivel del umbral: '
          'una tonalidad por encima y otra por debajo, con la linea de '
          'referencia marcada.',
      cuando:
          'Para vigilar un limite: horas por encima de una temperatura '
          'maxima, saldo sobre o bajo el minimo, rendimiento frente a la '
          'meta.',
      grafica: LineChart(
        LineChartData(
          minY: minY,
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
              spots: spots,
              isCurved: true,
              color: esquema.onSurface.withValues(alpha: 0.6),
              barWidth: 2,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    esquema.primary.withValues(alpha: 0.4),
                    esquema.primary.withValues(alpha: 0.4),
                    esquema.error.withValues(alpha: 0.4),
                    esquema.error.withValues(alpha: 0.4),
                  ],
                  stops: [0, corte, corte, 1],
                ),
              ),
            ),
          ],
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
            bottomTitles: _ejeOculto,
            rightTitles: _ejeOculto,
            topTitles: _ejeOculto,
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
 
/// 26. Pareto doble (dos metricas).
/// Dos series de barras ordenadas por la primera metrica, cada una con su
/// linea de porcentaje acumulado (eje derecho 0-100 %).
class FlParetoDoble extends StatelessWidget {
  const FlParetoDoble({super.key});
  @override
  Widget build(BuildContext context) {
    final a = DatosMock.seriesMultiples[0];
    final b = DatosMock.seriesMultiples[1];
    final esquema = Theme.of(context).colorScheme;
    final n = a.puntos.length;
 
    // Orden descendente segun la primera metrica; la segunda lo sigue.
    final orden = List<int>.generate(n, (i) => i)
      ..sort((x, y) => a.puntos[y].valor.compareTo(a.puntos[x].valor));
    final cats = [for (final i in orden) a.puntos[i].categoria];
    final va = [for (final i in orden) a.puntos[i].valor];
    final vb = [for (final i in orden) b.puntos[i].valor];
 
    List<double> acumulado(List<double> v) {
      final total = v.fold<double>(0, (s, x) => s + x);
      final res = <double>[];
      double suma = 0;
      for (final x in v) {
        suma += x;
        res.add(suma / total * 100);
      }
      return res;
    }
 
    final pa = acumulado(va);
    final pb = acumulado(vb);
 
    return LienzoDescrito(
      titulo: 'fl_chart · Pareto doble',
      paraQue:
          'Compara dos metricas con el analisis 80/20: barras ordenadas de '
          'mayor a menor para cada una y dos lineas de porcentaje '
          'acumulado contra la referencia del 80 %.',
      cuando:
          'Cuando se priorizan causas segun dos criterios a la vez: '
          'frecuencia y costo de los defectos, ventas y margen por '
          'producto.',
      grafica: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 60,
                    barGroups: [
                      for (int i = 0; i < n; i++)
                        BarChartGroupData(x: i, barsSpace: 4, barRods: [
                          BarChartRodData(
                              toY: va[i],
                              color: esquema.primary.withValues(alpha: 0.6),
                              width: 14),
                          BarChartRodData(
                              toY: vb[i],
                              color: esquema.tertiary.withValues(alpha: 0.6),
                              width: 14),
                        ]),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true, reservedSize: _izq)),
                      rightTitles: _ejeVacio(_der),
                      topTitles: _ejeOculto,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: _inf,
                          getTitlesWidget: (v, _) => _etiquetaX(cats, v),
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(
                        show: true, drawVerticalLine: false),
                  ),
                ),
                IgnorePointer(
                  child: LineChart(
                    LineChartData(
                      minX: -0.5,
                      maxX: n - 0.5,
                      minY: 0,
                      maxY: 100,
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [
                          HorizontalLine(
                            y: 80,
                            color: esquema.outline,
                            strokeWidth: 1,
                            dashArray: [4, 4],
                          ),
                        ],
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            for (int i = 0; i < n; i++)
                              FlSpot(i.toDouble(), pa[i]),
                          ],
                          color: esquema.primary,
                          barWidth: 3,
                          dotData: const FlDotData(show: true),
                        ),
                        LineChartBarData(
                          spots: [
                            for (int i = 0; i < n; i++)
                              FlSpot(i.toDouble(), pb[i]),
                          ],
                          color: esquema.tertiary,
                          barWidth: 3,
                          dashArray: [6, 4],
                          dotData: const FlDotData(show: true),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: _ejeVacio(_izq),
                        bottomTitles: _ejeVacio(_inf),
                        topTitles: _ejeOculto,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: _der,
                            interval: 25,
                            getTitlesWidget: (v, _) => Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text('${v.toInt()}%',
                                  style: const TextStyle(fontSize: 9)),
                            ),
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                      lineTouchData: const LineTouchData(enabled: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            children: [
              _ItemLeyenda(esquema.primary, '${a.nombre} (barras y % acum.)'),
              _ItemLeyenda(esquema.tertiary, '${b.nombre} (barras y % acum.)'),
            ],
          ),
        ],
      ),
    );
  }
}
 
/// 27. Gantt con progreso.
/// Como el Gantt de siempre, pero cada tarea lleva dentro una barra mas
/// delgada y solida que indica cuanto se ha avanzado.
class FlGanttProgreso extends StatelessWidget {
  const FlGanttProgreso({super.key});
  @override
  Widget build(BuildContext context) {
    // Mismas tareas que FlGantt (semanas 0-12).
    const tareas = [
      _Tarea('Analisis', 0, 3),
      _Tarea('Diseno', 2, 6),
      _Tarea('Desarrollo', 5, 10),
      _Tarea('Pruebas', 8, 12),
      _Tarea('Entrega', 11, 12),
    ];
    // Avance de ejemplo por tarea (0 a 1), en el mismo orden.
    const avances = <double>[1.0, 0.8, 0.5, 0.2, 0.0];
    final colores = _paleta(context);
    return LienzoDescrito(
      titulo: 'fl_chart · Gantt con progreso',
      paraQue:
          'Cada tarea es una barra de inicio a fin; dentro lleva una barra '
          'solida mas delgada que llega hasta donde va el avance real.',
      cuando:
          'Para seguir proyectos en curso: ver de un vistazo que fases van '
          'adelantadas o atrasadas respecto del calendario.',
      grafica: RotatedBox(
        quarterTurns: 1,
        child: BarChart(
          BarChartData(
            minY: 0,
            maxY: 12,
            barGroups: [
              for (int i = 0; i < tareas.length; i++)
                BarChartGroupData(
                  x: i,
                  groupVertically: true,
                  barRods: [
                    // Plan completo: inicio -> fin, tenue.
                    BarChartRodData(
                      fromY: tareas[i].inicio.toDouble(),
                      toY: tareas[i].fin.toDouble(),
                      color: colores[i % colores.length]
                          .withValues(alpha: 0.3),
                      width: 24,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // Avance: inicio -> inicio + duracion * avance.
                    BarChartRodData(
                      fromY: tareas[i].inicio.toDouble(),
                      toY: tareas[i].inicio +
                          (tareas[i].fin - tareas[i].inicio) * avances[i],
                      color: colores[i % colores.length],
                      width: 12,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ],
                ),
            ],
            titlesData: FlTitlesData(
              leftTitles: _ejeOculto,
              rightTitles: _ejeOculto,
              topTitles: _ejeOculto,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 72,
                  getTitlesWidget: (v, _) {
                    final i = v.toInt();
                    if (i < 0 || i >= tareas.length) {
                      return const SizedBox();
                    }
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                          '${tareas[i].nombre} ${(avances[i] * 100).toInt()}%',
                          style: const TextStyle(fontSize: 9)),
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
}
 
/// 28. Mapa de calor con escala de leyenda.
/// El mapa de cuadrados de siempre, con una barra de degradado lateral
/// que indica a que valor corresponde cada color.
class FlMapaCalorLeyenda extends StatelessWidget {
  const FlMapaCalorLeyenda({super.key});
  @override
  Widget build(BuildContext context) {
    final celdas = DatosMock.matrizCalor.where((c) => c.x < 8).toList();
    final esquema = Theme.of(context).colorScheme;
    final bajo = esquema.surfaceContainerHighest;
    final alto = esquema.primary;
    Color colorIntensidad(double v) => Color.lerp(bajo, alto, v / 100)!;
    return LienzoDescrito(
      titulo: 'fl_chart · Mapa de calor con leyenda',
      paraQue:
          'Cuadricula donde el color de cada celda codifica su intensidad, '
          'acompanada de una barra de degradado que traduce cada color a '
          'un valor numerico.',
      cuando:
          'Siempre que el color deba leerse con precision: sin escala el '
          'mapa solo permite comparar celdas entre si; con ella se pueden '
          'estimar valores.',
      grafica: Row(
        children: [
          Expanded(
            child: ScatterChart(
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
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 24)),
                  bottomTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 20)),
                  rightTitles: _ejeOculto,
                  topTitles: _ejeOculto,
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Leyenda: degradado vertical alineado con el area de dibujo
          // (el hueco inferior equivale al eje X del mapa).
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                const Text('100', style: TextStyle(fontSize: 10)),
                const SizedBox(height: 4),
                Expanded(
                  child: Container(
                    width: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [bajo, alto],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text('0', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 29. Embudo horizontal con tasas.
/// El embudo de siempre, con una etiqueta de porcentaje de conversion
/// entre cada par de etapas. Las etiquetas son grupos "fantasma" (sin
/// barra) intercalados entre las etapas, asi fl_chart las ubica solo.
class FlEmbudoTasas extends StatelessWidget {
  const FlEmbudoTasas({super.key});
  @override
  Widget build(BuildContext context) {
    // Mismas etapas que FlEmbudo.
    const etapas = [
      PuntoCategoria('Visitas', 100),
      PuntoCategoria('Registros', 64),
      PuntoCategoria('Pruebas', 38),
      PuntoCategoria('Compras', 20),
    ];
    final colores = _paleta(context);
    final esquema = Theme.of(context).colorScheme;
    final grupos = etapas.length * 2 - 1;
    return LienzoDescrito(
      titulo: 'fl_chart · Embudo con tasas',
      paraQue:
          'Barras centradas que se angostan por etapa y, entre cada par, '
          'el porcentaje de la etapa anterior que logro avanzar.',
      cuando:
          'Para localizar el paso donde mas se pierde: ademas de ver '
          'cuanto queda, se lee cuanto cuesta cada transicion.',
      grafica: RotatedBox(
        quarterTurns: 1,
        child: BarChart(
          BarChartData(
            minY: -55,
            maxY: 55,
            barGroups: [
              for (int k = 0; k < grupos; k++)
                BarChartGroupData(x: k, barRods: [
                  if (k.isEven)
                    BarChartRodData(
                      fromY: -etapas[k ~/ 2].valor / 2,
                      toY: etapas[k ~/ 2].valor / 2,
                      color: colores[(k ~/ 2) % colores.length],
                      width: 30,
                    )
                  else
                    // Grupo fantasma: solo aporta su etiqueta.
                    BarChartRodData(
                      fromY: 0,
                      toY: 0,
                      color: Colors.transparent,
                      width: 30,
                    ),
                ]),
            ],
            titlesData: FlTitlesData(
              leftTitles: _ejeOculto,
              rightTitles: _ejeOculto,
              topTitles: _ejeOculto,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 48,
                  getTitlesWidget: (v, _) {
                    final k = v.toInt();
                    if (k < 0 || k >= grupos) return const SizedBox();
                    if (k.isEven) {
                      final e = etapas[k ~/ 2];
                      return RotatedBox(
                        quarterTurns: 3,
                        child: Text('${e.categoria}\n${e.valor.toInt()}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 9)),
                      );
                    }
                    final j = k ~/ 2;
                    final tasa =
                        etapas[j + 1].valor / etapas[j].valor * 100;
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Text('▼ ${tasa.toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: esquema.error)),
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
 
/// 30. Burbujas con cuadrantes etiquetados.
/// Burbujas (tres datos por punto) sobre un plano partido por los
/// promedios, con un nombre en cada una de las cuatro zonas y las burbujas
/// coloreadas segun la zona en que caen.
class FlBurbujasCuadrantesNombre extends StatelessWidget {
  const FlBurbujasCuadrantesNombre({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final esquema = Theme.of(context).colorScheme;
    final promX = datos.map((p) => p.x).reduce((a, b) => a + b) / datos.length;
    final promY = datos.map((p) => p.y).reduce((a, b) => a + b) / datos.length;
 
    // Colores por cuadrante (x = esfuerzo, y = impacto).
    Color colorDe(PuntoXY p) {
      final derecha = p.x >= promX;
      final arriba = p.y >= promY;
      if (arriba && !derecha) return esquema.primary;
      if (arriba && derecha) return esquema.tertiary;
      if (!arriba && !derecha) return esquema.secondary;
      return esquema.error;
    }
 
    Widget etiqueta(String texto, Alignment alineacion, Color color) => Align(
          alignment: alineacion,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Text(texto,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: color.withValues(alpha: 0.9))),
          ),
        );
 
    return LienzoDescrito(
      titulo: 'fl_chart · Burbujas + cuadrantes con nombre',
      paraQue:
          'Burbujas de tamano variable sobre un plano dividido por los '
          'promedios en cuatro zonas con nombre; el color de cada burbuja '
          'indica la zona en que cae.',
      cuando:
          'Para priorizar con una matriz esfuerzo/impacto donde el tamano '
          'es el costo: decidir que hacer primero, que planificar y que '
          'descartar.',
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
                        color: colorDe(p).withValues(alpha: 0.5),
                        radius: p.tamano),
                  ),
              ],
              titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: _izq)),
                bottomTitles: AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: _inf)),
                rightTitles: _ejeOculto,
                topTitles: _ejeOculto,
              ),
              borderData: FlBorderData(show: true),
            ),
          ),
          // Lineas de promedio, con el mismo espacio reservado que el
          // scatter para que coincidan exactamente con sus ejes.
          IgnorePointer(
            child: LineChart(
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
                        color: esquema.outline,
                        strokeWidth: 1.5,
                        dashArray: [5, 4]),
                  ],
                  verticalLines: [
                    VerticalLine(
                        x: promX,
                        color: esquema.outline,
                        strokeWidth: 1.5,
                        dashArray: [5, 4]),
                  ],
                ),
                titlesData: FlTitlesData(
                  leftTitles: _ejeVacio(_izq),
                  bottomTitles: _ejeVacio(_inf),
                  rightTitles: _ejeOculto,
                  topTitles: _ejeOculto,
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
              ),
            ),
          ),
          // Nombres de las zonas, dentro del area de dibujo.
          Positioned.fill(
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.only(left: _izq, bottom: _inf),
                child: Stack(
                  children: [
                    etiqueta('Ganancias rapidas', Alignment.topLeft,
                        esquema.primary),
                    etiqueta('Proyectos grandes', Alignment.topRight,
                        esquema.tertiary),
                    etiqueta(
                        'Relleno', Alignment.bottomLeft, esquema.secondary),
                    etiqueta('Evitar', Alignment.bottomRight, esquema.error),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 31. Linea multi-eje (3 series, 2 escalas).
/// Ventas y su promedio movil comparten el eje izquierdo (unidades);
/// la variacion porcentual mensual usa el eje derecho (%).
class FlLineaMultiEje extends StatelessWidget {
  const FlLineaMultiEje({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final esquema = Theme.of(context).colorScheme;
    final n = datos.length;
    final cats = datos.map((e) => e.categoria).toList();
 
    // Series derivadas de las ventas (desde el segundo periodo).
    final promMovil = [
      for (int i = 1; i < n; i++)
        FlSpot(i.toDouble(), (datos[i - 1].valor + datos[i].valor) / 2),
    ];
    final variacion = [
      for (int i = 1; i < n; i++)
        FlSpot(
            i.toDouble(),
            (datos[i].valor - datos[i - 1].valor) /
                datos[i - 1].valor *
                100),
    ];
    // Rango del eje derecho, redondeado a multiplos de 50.
    final vMin = variacion.map((s) => s.y).reduce(math.min);
    final vMax = variacion.map((s) => s.y).reduce(math.max);
    final minR = (vMin / 50).floor() * 50.0;
    final maxR = (vMax / 50).ceil() * 50.0;
 
    return LienzoDescrito(
      titulo: 'fl_chart · Linea multi-eje',
      paraQue:
          'Tres lineas en el mismo grafico con dos escalas: las ventas y su '
          'promedio movil usan el eje izquierdo y la variacion porcentual '
          'usa el derecho.',
      cuando:
          'Cuando se quiere ver una magnitud junto a su cambio relativo: '
          'ingresos y crecimiento mensual, produccion y rendimiento.',
      grafica: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Eje izquierdo: ventas y promedio movil (0-80).
                LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: (n - 1).toDouble(),
                    minY: 0,
                    maxY: 80,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          for (int i = 0; i < n; i++)
                            FlSpot(i.toDouble(), datos[i].valor),
                        ],
                        color: esquema.primary,
                        barWidth: 3,
                        dotData: const FlDotData(show: true),
                      ),
                      LineChartBarData(
                        spots: promMovil,
                        color: esquema.primary.withValues(alpha: 0.6),
                        barWidth: 2,
                        dashArray: [6, 4],
                        dotData: const FlDotData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true, reservedSize: _izq)),
                      rightTitles: _ejeVacio(_der),
                      topTitles: _ejeOculto,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: _inf,
                          getTitlesWidget: (v, _) => _etiquetaX(cats, v),
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                  ),
                ),
                // Eje derecho: variacion porcentual.
                IgnorePointer(
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: (n - 1).toDouble(),
                      minY: minR,
                      maxY: maxR,
                      lineBarsData: [
                        LineChartBarData(
                          spots: variacion,
                          color: esquema.error,
                          barWidth: 3,
                          dotData: const FlDotData(show: true),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: _ejeVacio(_izq),
                        bottomTitles: _ejeVacio(_inf),
                        topTitles: _ejeOculto,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: _der,
                            getTitlesWidget: (v, _) => Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text('${v.toInt()}%',
                                  style: TextStyle(
                                      fontSize: 9, color: esquema.error)),
                            ),
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                      lineTouchData: const LineTouchData(enabled: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            children: [
              _ItemLeyenda(esquema.primary, 'Ventas (izq.)'),
              _ItemLeyenda(esquema.primary.withValues(alpha: 0.6),
                  'Promedio movil (izq.)'),
              _ItemLeyenda(esquema.error, 'Variacion % (der.)'),
            ],
          ),
        ],
      ),
    );
  }
}
 
/// 32. Cascada con conectores.
/// La cascada de siempre, con lineas punteadas que unen el final de cada
/// barra con el inicio de la siguiente.
class FlCascadaConectores extends StatelessWidget {
  const FlCascadaConectores({super.key});
  @override
  Widget build(BuildContext context) {
    final pasos = DatosMock.cascada; // valores con signo
    final esquema = Theme.of(context).colorScheme;
    final grupos = <BarChartGroupData>[];
    final niveles = <double>[]; // acumulado al terminar cada paso
    final etiquetas = <String>[];
    double acum = 0;
    for (int i = 0; i < pasos.length; i++) {
      final desde = acum;
      acum += pasos[i].valor;
      niveles.add(acum);
      grupos.add(BarChartGroupData(x: i, barRods: [
        BarChartRodData(
          fromY: desde,
          toY: acum,
          color: pasos[i].valor >= 0 ? esquema.primary : esquema.error,
          width: 24,
        ),
      ]));
      final signo = pasos[i].valor >= 0 ? '+' : '';
      etiquetas.add('${pasos[i].categoria}\n$signo${pasos[i].valor.toInt()}');
    }
    // Barra final: total acumulado, desde 0.
    grupos.add(BarChartGroupData(x: pasos.length, barRods: [
      BarChartRodData(fromY: 0, toY: acum, color: esquema.tertiary, width: 24),
    ]));
    etiquetas.add('Total\n${acum.toInt()}');
    final n = grupos.length;
 
    return LienzoDescrito(
      titulo: 'fl_chart · Cascada con conectores',
      paraQue:
          'Barras flotantes encadenadas, unidas por lineas punteadas que '
          'llevan el nivel acumulado de una barra a la siguiente, hasta el '
          'total.',
      cuando:
          'Para explicar como se llega a un resultado paso a paso: de '
          'ingreso bruto a utilidad neta, de saldo inicial a final.',
      grafica: Stack(
        children: [
          BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              minY: 0,
              maxY: 140,
              barGroups: grupos,
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                    sideTitles:
                        SideTitles(showTitles: true, reservedSize: _izq)),
                rightTitles: _ejeOculto,
                topTitles: _ejeOculto,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 34,
                    getTitlesWidget: (v, _) {
                      final i = v.toInt();
                      if (i < 0 || i >= etiquetas.length) {
                        return const SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(etiquetas[i],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 9)),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData:
                  const FlGridData(show: true, drawVerticalLine: false),
            ),
          ),
          // Conectores: del centro de la barra i al centro de la i+1, al
          // nivel acumulado tras el paso i (coincide con el borde de la
          // barra).
          IgnorePointer(
            child: LineChart(
              LineChartData(
                minX: -0.5,
                maxX: n - 0.5,
                minY: 0,
                maxY: 140,
                lineBarsData: [
                  for (int i = 0; i < pasos.length; i++)
                    LineChartBarData(
                      spots: [
                        FlSpot(i.toDouble(), niveles[i]),
                        FlSpot(i + 1.0, niveles[i]),
                      ],
                      color: esquema.onSurface.withValues(alpha: 0.55),
                      barWidth: 1.5,
                      dashArray: [4, 3],
                      dotData: const FlDotData(show: false),
                    ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: _ejeVacio(_izq),
                  bottomTitles: _ejeVacio(34),
                  rightTitles: _ejeOculto,
                  topTitles: _ejeOculto,
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 