import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' hide CornerStyle;
import '../../core/lienzo_descrito.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart' as spark;

import '../../mock/datos_mock.dart';

/// 1. Velas japonesas (candlestick).
class SfVelas extends StatelessWidget {
  const SfVelas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Velas',
      paraQue:
          'Cada vela resume cuatro datos de un periodo: maximo, minimo, '
          'apertura y cierre, con color segun subio o bajo.',
      cuando:
          'Para datos bursatiles donde importan los cuatro valores del '
          'periodo y la direccion del cierre.',
      grafica: SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CandleSeries<Vela, DateTime>>[
          CandleSeries<Vela, DateTime>(
            dataSource: DatosMock.velas,
            xValueMapper: (v, _) => v.fecha,
            lowValueMapper: (v, _) => v.bajo,
            highValueMapper: (v, _) => v.alto,
            openValueMapper: (v, _) => v.apertura,
            closeValueMapper: (v, _) => v.cierre,
          ),
        ],
      ),
    );
  }
}

/// 2. OHLC (hilo).
class SfOhlc extends StatelessWidget {
  const SfOhlc({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · OHLC (hilo)',
      paraQue:
          'Variante de las velas que representa los cuatro valores con lineas '
          'finas en vez de cuerpos rellenos.',
      cuando:
          'Para analisis tecnico bursatil cuando se prefiere la notacion '
          'clasica de barras OHLC sobre las velas.',
      grafica: SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <HiloOpenCloseSeries<Vela, DateTime>>[
          HiloOpenCloseSeries<Vela, DateTime>(
            dataSource: DatosMock.velas,
            xValueMapper: (v, _) => v.fecha,
            lowValueMapper: (v, _) => v.bajo,
            highValueMapper: (v, _) => v.alto,
            openValueMapper: (v, _) => v.apertura,
            closeValueMapper: (v, _) => v.cierre,
          ),
        ],
      ),
    );
  }
}

/// 3. Piramide.
class SfPiramide extends StatelessWidget {
  const SfPiramide({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Piramide',
      paraQue:
          'Divide un total en niveles apilados de ancho decreciente, '
          'mostrando una jerarquia de magnitudes.',
      cuando:
          'Para jerarquias o etapas de tamano decreciente: niveles '
          'organizativos, segmentos de poblacion.',
      grafica: SfPyramidChart(
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: PyramidSeries<PuntoCategoria, String>(
          dataSource: DatosMock.cuotaMercado,
          xValueMapper: (p, _) => p.categoria,
          yValueMapper: (p, _) => p.valor,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ),
    );
  }
}

/// 4. Embudo.
class SfEmbudo extends StatelessWidget {
  const SfEmbudo({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Embudo',
      paraQue:
          'Muestra como se reduce una cantidad al pasar por etapas '
          'sucesivas, con cada nivel mas angosto que el anterior.',
      cuando:
          'Para procesos con abandono entre fases: embudo de ventas, '
          'conversion de un sitio, pasos de un registro.',
      grafica: SfFunnelChart(
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: FunnelSeries<PuntoCategoria, String>(
          dataSource: DatosMock.cuotaMercado,
          xValueMapper: (p, _) => p.categoria,
          yValueMapper: (p, _) => p.valor,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ),
    );
  }
}

/// 5. Cascada (waterfall).
class SfCascada extends StatelessWidget {
  const SfCascada({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Cascada',
      paraQue:
          'Barras encadenadas donde cada una parte donde termino la anterior, '
          'mostrando el efecto acumulado de sumas y restas.',
      cuando:
          'Para descomponer como se llega a un resultado: de ingreso bruto a '
          'neto, de saldo inicial a final paso por paso.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <WaterfallSeries<PuntoCategoria, String>>[
          WaterfallSeries<PuntoCategoria, String>(
            dataSource: DatosMock.cascada,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            negativePointsColor: Theme.of(context).colorScheme.error,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

/// 6. Medidor radial (gauge).
class SfMedidor extends StatelessWidget {
  const SfMedidor({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Medidor',
      paraQue:
          'Un medidor radial con zonas de color y una aguja que senala el '
          'valor sobre una escala, como un velocimetro.',
      cuando:
          'Para un indicador unico sobre un rango: uso, cumplimiento, nivel '
          'de un recurso con zonas buena/media/mala.',
      grafica: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: DatosMock.rangoMedidor,
            ranges: <GaugeRange>[
              GaugeRange(startValue: 0, endValue: 40, color: Colors.green),
              GaugeRange(startValue: 40, endValue: 75, color: Colors.orange),
              GaugeRange(startValue: 75, endValue: 100, color: Colors.red),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(value: DatosMock.valorMedidor),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  '${DatosMock.valorMedidor.toInt()}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: esquema.onSurface),
                ),
                positionFactor: 0.6,
                angle: 90,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 7. Spark (micro-grafico de tendencia).
class SfSpark extends StatelessWidget {
  const SfSpark({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Spark',
      paraQue:
          'Una micro-grafica de tendencia sin ejes ni adornos, que resume '
          'una serie en muy poco espacio.',
      cuando:
          'Para incrustar junto a un numero o en una celda de tabla, dando '
          'contexto de evolucion sin ocupar una grafica completa.',
      grafica: Center(
        child: SizedBox(
          height: 120,
          child: SfCartesianChart(
            primaryXAxis: const DateTimeAxis(isVisible: false),
            primaryYAxis: const NumericAxis(isVisible: false),
            plotAreaBorderWidth: 0,
            series: <CartesianSeries<PuntoTemporal, DateTime>>[
              SplineAreaSeries<PuntoTemporal, DateTime>(
                dataSource: DatosMock.serieTemporal,
                xValueMapper: (p, _) => p.fecha,
                yValueMapper: (p, _) => p.valor,
                opacity: 0.4,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 8. Rango de area (range area).
class SfRangeArea extends StatelessWidget {
  const SfRangeArea({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    return LienzoDescrito(
      titulo: 'Syncfusion · Range area',
      paraQue:
          'Un area que ocupa el espacio entre un valor minimo y uno maximo '
          'por categoria, mostrando una banda de variacion.',
      cuando:
          'Para rangos continuos: temperaturas minima y maxima por dia, '
          'bandas de precio, margenes a lo largo del tiempo.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<PuntoCategoria, String>>[
          RangeAreaSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            lowValueMapper: (p, _) => (p.valor - 15).clamp(0, 100),
            highValueMapper: (p, _) => (p.valor + 15).clamp(0, 100),
            opacity: 0.5,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}

/// 9. Caja y bigotes (box and whisker).
class SfBoxplot extends StatelessWidget {
  const SfBoxplot({super.key});
  @override
  Widget build(BuildContext context) {
    final muestra = DatosMock.distribucion;
    final grupos = <_GrupoCaja>[
      _GrupoCaja('Grupo A', muestra.take(15).toList()),
      _GrupoCaja('Grupo B', muestra.skip(15).toList()),
    ];
    return LienzoDescrito(
      titulo: 'Syncfusion · Box and whisker',
      paraQue:
          'Resume la distribucion de cada grupo con su mediana, cuartiles y '
          'valores atipicos en una caja con bigotes.',
      cuando:
          'Para comparar la dispersion y el centro de varios grupos de '
          'datos: notas por curso, tiempos por metodo.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<_GrupoCaja, String>>[
          BoxAndWhiskerSeries<_GrupoCaja, String>(
            dataSource: grupos,
            xValueMapper: (g, _) => g.nombre,
            yValueMapper: (g, _) => g.valores,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class _GrupoCaja {
  final String nombre;
  final List<double> valores;
  const _GrupoCaja(this.nombre, this.valores);
}

/// 10. Radial de barras (circular).
class SfPolar extends StatelessWidget {
  const SfPolar({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Radial de barras',
      paraQue:
          'Barras dispuestas en forma de anillos concentricos, cada una con '
          'su longitud segun el valor. Es el RadialBarSeries.',
      cuando:
          'Para comparar pocas categorias de forma llamativa y circular: '
          'progreso de varias metas, indicadores de perfil.',
      grafica: SfCircularChart(
        series: <CircularSeries<PuntoCategoria, String>>[
          RadialBarSeries<PuntoCategoria, String>(
            dataSource: DatosMock.perfilRadar
                .map((e) => PuntoCategoria(e.eje, e.valor))
                .toList(),
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            maximumValue: 100,
            cornerStyle: CornerStyle.bothCurve,
            gap: '8%',
          ),
        ],
      ),
    );
  }
}
/// 11. Velas + media movil.
class SfVelasMedia extends StatelessWidget {
  const SfVelasMedia({super.key});
  @override
  Widget build(BuildContext context) {
    final velas = DatosMock.velas;
    // Media movil de cierre, ventana 3.
    final media = <Vela>[];
    for (int i = 0; i < velas.length; i++) {
      final desde = (i - 2).clamp(0, velas.length - 1);
      final v = velas.sublist(desde, i + 1);
      final m = v.map((e) => e.cierre).reduce((a, b) => a + b) / v.length;
      media.add(Vela(velas[i].fecha, m, m, m, m));
    }
    return LienzoDescrito(
      titulo: 'Syncfusion · Velas + media movil',
      paraQue:
          'Velas japonesas con una linea de media movil del cierre encima, '
          'que suaviza el ruido y marca la tendencia de fondo.',
      cuando:
          'En analisis bursatil, para ver el detalle de cada periodo y la '
          'direccion general a la vez.',
      grafica: SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          CandleSeries<Vela, DateTime>(
            dataSource: velas,
            xValueMapper: (v, _) => v.fecha,
            lowValueMapper: (v, _) => v.bajo,
            highValueMapper: (v, _) => v.alto,
            openValueMapper: (v, _) => v.apertura,
            closeValueMapper: (v, _) => v.cierre,
          ),
          LineSeries<Vela, DateTime>(
            name: 'Media movil',
            dataSource: media,
            xValueMapper: (v, _) => v.fecha,
            yValueMapper: (v, _) => v.cierre,
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 12. Embudo tipo piramide (pyramid funnel).
class SfEmbudoPiramide extends StatelessWidget {
  const SfEmbudoPiramide({super.key});
  @override
  Widget build(BuildContext context) {
    final etapas = const [
      PuntoCategoria('Visitas', 100),
      PuntoCategoria('Registros', 64),
      PuntoCategoria('Pruebas', 38),
      PuntoCategoria('Compras', 20),
    ];
    return LienzoDescrito(
      titulo: 'Syncfusion · Embudo piramidal',
      paraQue:
          'Un embudo que termina en punta (sin cuello), enfatizando la '
          'reduccion progresiva hasta un unico resultado final.',
      cuando:
          'Para procesos de conversion donde se quiere resaltar cuanto se '
          'pierde hasta llegar al final del embudo.',
      grafica: SfFunnelChart(
        series: FunnelSeries<PuntoCategoria, String>(
          dataSource: etapas,
          xValueMapper: (p, _) => p.categoria,
          yValueMapper: (p, _) => p.valor,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
          ),
          neckWidth: '0%',
          neckHeight: '0%',
        ),
      ),
    );
  }
}

/// 13. Medidor lineal (SfLinearGauge, paquete gauges).
class SfMedidorLineal extends StatelessWidget {
  const SfMedidorLineal({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Medidor lineal',
      paraQue:
          'Una barra graduada con zonas de color y un marcador en el valor '
          'actual, como un termometro horizontal.',
      cuando:
          'Para un indicador sobre un rango cuando se prefiere una barra a un '
          'medidor circular: nivel, progreso, temperatura.',
      grafica: Center(
        child: SfLinearGauge(
          minimum: 0,
          maximum: 100,
          ranges: const <LinearGaugeRange>[
            LinearGaugeRange(startValue: 0, endValue: 40, color: Colors.green),
            LinearGaugeRange(
                startValue: 40, endValue: 75, color: Colors.orange),
            LinearGaugeRange(startValue: 75, endValue: 100, color: Colors.red),
          ],
          markerPointers: <LinearMarkerPointer>[
            LinearShapePointer(
              value: DatosMock.valorMedidor,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}

/// 14. Hilo simple (solo rango alto-bajo).
class SfHilo extends StatelessWidget {
  const SfHilo({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Hilo (alto-bajo)',
      paraQue:
          'Lineas verticales que van del minimo al maximo de cada periodo, '
          'sin apertura ni cierre. Es el HiloSeries.',
      cuando:
          'Cuando solo importan el rango de variacion por periodo: '
          'temperaturas min-max, rango de precios diario.',
      grafica: SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <HiloSeries<Vela, DateTime>>[
          HiloSeries<Vela, DateTime>(
            dataSource: DatosMock.velas,
            xValueMapper: (v, _) => v.fecha,
            lowValueMapper: (v, _) => v.bajo,
            highValueMapper: (v, _) => v.alto,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 15. Dona semicircular (half doughnut).
class SfDonaSemi extends StatelessWidget {
  const SfDonaSemi({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Dona semicircular',
      paraQue:
          'Una dona dibujada solo en media vuelta (startAngle/endAngle), que '
          'ocupa menos alto y centra la atencion.',
      cuando:
          'Para mostrar un reparto en tableros donde el espacio vertical es '
          'limitado, o para un estilo de medidor por porciones.',
      grafica: SfCircularChart(
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CircularSeries<PuntoCategoria, String>>[
          DoughnutSeries<PuntoCategoria, String>(
            dataSource: DatosMock.cuotaMercado,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            startAngle: 270,
            endAngle: 90,
            innerRadius: '55%',
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

/// 16. Columnas con banda de error (columna + range).
class SfColumnasError extends StatelessWidget {
  const SfColumnasError({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final datos = DatosMock.ventasMensuales;
    return LienzoDescrito(
      titulo: 'Syncfusion · Columnas con error',
      paraQue:
          'Columnas con el valor central y una banda de rango superpuesta que '
          'representa el margen de error de cada medicion.',
      cuando:
          'Para datos experimentales o estimaciones donde cada valor tiene '
          'una incertidumbre asociada.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            color: esquema.primary.withValues(alpha: 0.6),
            width: 0.6,
          ),
          RangeColumnSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            lowValueMapper: (p, _) => (p.valor - 8).clamp(0, 100),
            highValueMapper: (p, _) => (p.valor + 8).clamp(0, 100),
            width: 0.15,
            color: esquema.error,
          ),
        ],
      ),
    );
  }
}

/// 17. Multi-eje (dos ejes Y independientes).
class SfMultiEje extends StatelessWidget {
  const SfMultiEje({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final datos = DatosMock.ventasMensuales;
    return LienzoDescrito(
      titulo: 'Syncfusion · Multi-eje',
      paraQue:
          'Dos series con escalas muy distintas, cada una referida a su '
          'propio eje Y (izquierdo y derecho), en un mismo grafico.',
      cuando:
          'Cuando se relacionan dos metricas de unidades diferentes: ingresos '
          '(miles) y numero de clientes (decenas), temperatura y lluvia.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        axes: <ChartAxis>[
          NumericAxis(
            name: 'ejeDerecho',
            opposedPosition: true,
            maximum: 10,
            majorGridLines: const MajorGridLines(width: 0),
          ),
        ],
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            name: 'Ventas',
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            color: esquema.primary,
          ),
          LineSeries<PuntoCategoria, String>(
            name: 'Indice',
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor / 10,
            yAxisName: 'ejeDerecho',
            width: 3,
            markerSettings: const MarkerSettings(isVisible: true),
            color: esquema.error,
          ),
        ],
      ),
    );
  }
}

/// 18. Columnas con seleccion interactiva.
class SfColumnasSeleccion extends StatelessWidget {
  const SfColumnasSeleccion({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Columnas con seleccion',
      paraQue:
          'Columnas donde al tocar una se resalta y las demas se atenuan, '
          'mediante el comportamiento de seleccion de la libreria.',
      cuando:
          'En tableros interactivos donde el usuario explora categorias una '
          'a una tocando la que le interesa.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        selectionType: SelectionType.point,
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            color: Theme.of(context).colorScheme.primary,
            selectionBehavior: SelectionBehavior(
              enable: true,
              unselectedOpacity: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// 19. Spline con zonas de rango (plotBands multiples).
class SfSplineZonas extends StatelessWidget {
  const SfSplineZonas({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Spline con zonas',
      paraQue:
          'Una curva spline sobre varias bandas de color de fondo que '
          'dividen el eje en zonas (bajo, medio, alto).',
      cuando:
          'Cuando los valores se interpretan contra rangos: niveles '
          'saludables, zonas de rendimiento, umbrales de alerta.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: NumericAxis(
          plotBands: <PlotBand>[
            PlotBand(
                isVisible: true,
                start: 0,
                end: 35,
                color: esquema.error.withValues(alpha: 0.08)),
            PlotBand(
                isVisible: true,
                start: 35,
                end: 60,
                color: esquema.tertiary.withValues(alpha: 0.08)),
            PlotBand(
                isVisible: true,
                start: 60,
                end: 100,
                color: esquema.primary.withValues(alpha: 0.08)),
          ],
        ),
        series: <CartesianSeries<PuntoCategoria, String>>[
          SplineSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            width: 3,
            markerSettings: const MarkerSettings(isVisible: true),
            color: esquema.onSurface,
          ),
        ],
      ),
    );
  }
}

/// 20. Columnas apiladas + linea de total (combo).
class SfApiladasTotal extends StatelessWidget {
  const SfApiladasTotal({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final m = DatosMock.seriesMultiples;
    final cats = m.first.puntos;
    final totales = <PuntoCategoria>[
      for (int i = 0; i < cats.length; i++)
        PuntoCategoria(
          cats[i].categoria,
          m.fold<double>(0, (s, se) => s + se.puntos[i].valor),
        ),
    ];
    return LienzoDescrito(
      titulo: 'Syncfusion · Apiladas + total',
      paraQue:
          'Columnas apiladas por componente con una linea que recorre el '
          'total de cada periodo, uniendo composicion y evolucion del total.',
      cuando:
          'Cuando importa como crece el total y que parte lo impulsa: '
          'ingresos por linea de negocio y su tendencia global.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries>[
          for (final s in m)
            StackedColumnSeries<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
            ),
          LineSeries<PuntoCategoria, String>(
            name: 'Total',
            dataSource: totales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            width: 3,
            markerSettings: const MarkerSettings(isVisible: true),
            color: esquema.error,
          ),
        ],
      ),
    );
  }
}

/// Punto de una serie con valor opcional (para datos faltantes).
class _PuntoNulo {
  final DateTime fecha;
  final double? valor;
  const _PuntoNulo(this.fecha, this.valor);
}
 
/// 21. Dispersion con lineas de tendencia.
/// Trendline calcula y dibuja el ajuste sobre la propia serie: aqui uno
/// lineal y otro polinomico de grado 2.
class SfTendencias extends StatelessWidget {
  const SfTendencias({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Tendencias',
      paraQue:
          'Sobre la nube de puntos se dibujan dos ajustes calculados por la '
          'libreria: uno lineal (continuo) y otro polinomico de grado 2 '
          '(punteado), sin calcular nada a mano.',
      cuando:
          'Para comparar que modelo describe mejor unos datos: si la '
          'relacion es una recta o tiene curvatura.',
      grafica: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoXY, num>>[
          ScatterSeries<PuntoXY, num>(
            name: 'Datos',
            dataSource: DatosMock.dispersion,
            xValueMapper: (p, _) => p.x,
            yValueMapper: (p, _) => p.y,
            color: esquema.primary.withValues(alpha: 0.6),
            trendlines: <Trendline>[
              Trendline(
                name: 'Lineal',
                type: TrendlineType.linear,
                color: esquema.error,
                width: 2.5,
              ),
              Trendline(
                name: 'Polinomica (2)',
                type: TrendlineType.polynomial,
                polynomialOrder: 2,
                color: esquema.tertiary,
                width: 2.5,
                dashArray: const <double>[6, 4],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 
/// 22. Velas con bandas de Bollinger y media exponencial.
/// Los indicadores tecnicos se enlazan por nombre a la serie de velas y
/// la libreria calcula las bandas y la media por su cuenta.
class SfVelasBollinger extends StatelessWidget {
  const SfVelasBollinger({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Velas + Bollinger',
      paraQue:
          'Velas japonesas con dos indicadores tecnicos calculados por la '
          'libreria: las bandas de Bollinger (media de 5 periodos mas/menos '
          '2 desviaciones) y una media movil exponencial.',
      cuando:
          'En analisis bursatil, para ver si el precio esta en una zona '
          'extrema respecto de su volatilidad reciente.',
      grafica: SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<Vela, DateTime>>[
          CandleSeries<Vela, DateTime>(
            name: 'Velas',
            dataSource: DatosMock.velas,
            xValueMapper: (v, _) => v.fecha,
            lowValueMapper: (v, _) => v.bajo,
            highValueMapper: (v, _) => v.alto,
            openValueMapper: (v, _) => v.apertura,
            closeValueMapper: (v, _) => v.cierre,
          ),
        ],
        indicators: <TechnicalIndicator<Vela, DateTime>>[
          BollingerBandIndicator<Vela, DateTime>(
            seriesName: 'Velas',
            name: 'Bollinger',
            period: 5,
            standardDeviation: 2,
            upperLineColor: esquema.error,
            lowerLineColor: esquema.tertiary,
            bandColor: esquema.primary.withValues(alpha: 0.12),
            signalLineColor: esquema.primary,
          ),
          EmaIndicator<Vela, DateTime>(
            seriesName: 'Velas',
            name: 'EMA 5',
            period: 5,
            valueField: 'close',
            signalLineColor: Colors.orange,
            signalLineWidth: 2,
          ),
        ],
      ),
    );
  }
}
 
/// 23. Zoom y paneo.
/// ZoomPanBehavior permite acercar con dos dedos, doble toque y arrastrar;
/// los botones usan los metodos del propio comportamiento.
class SfZoomPan extends StatefulWidget {
  const SfZoomPan({super.key});
  @override
  State<SfZoomPan> createState() => _SfZoomPanState();
}
 
class _SfZoomPanState extends State<SfZoomPan> {
  late final ZoomPanBehavior _zoom = ZoomPanBehavior(
    enablePinching: true,
    enablePanning: true,
    enableDoubleTapZooming: true,
    zoomMode: ZoomMode.x,
  );
 
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Zoom y paneo',
      paraQue:
          'Se puede acercar con dos dedos o con doble toque y desplazar la '
          'grafica arrastrando; los botones hacen lo mismo por codigo y '
          'devuelven la vista original.',
      cuando:
          'Para historicos extensos donde la vista completa oculta el '
          'detalle: meses de datos diarios, registros de sensores.',
      grafica: Column(
        children: [
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: const DateTimeAxis(),
              zoomPanBehavior: _zoom,
              series: <CartesianSeries<PuntoTemporal, DateTime>>[
                LineSeries<PuntoTemporal, DateTime>(
                  dataSource: DatosMock.serieTemporal,
                  xValueMapper: (p, _) => p.fecha,
                  yValueMapper: (p, _) => p.valor,
                  width: 2,
                  markerSettings: const MarkerSettings(isVisible: true),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: _zoom.zoomIn,
                icon: const Icon(Icons.zoom_in),
                label: const Text('Acercar'),
              ),
              OutlinedButton.icon(
                onPressed: _zoom.zoomOut,
                icon: const Icon(Icons.zoom_out),
                label: const Text('Alejar'),
              ),
              OutlinedButton.icon(
                onPressed: _zoom.reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Restablecer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 
/// 24. Trackball con globo de varias series.
/// Al tocar, una linea vertical recorre la grafica y un globo agrupa el
/// valor de todas las series en ese punto.
class SfTrackball extends StatefulWidget {
  const SfTrackball({super.key});
  @override
  State<SfTrackball> createState() => _SfTrackballState();
}
 
class _SfTrackballState extends State<SfTrackball> {
  late final TrackballBehavior _trackball = TrackballBehavior(
    enable: true,
    activationMode: ActivationMode.singleTap,
    tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    shouldAlwaysShow: true,
    lineDashArray: const <double>[5, 4],
  );
 
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Trackball',
      paraQue:
          'Al tocar o arrastrar aparece una linea guia vertical y un globo '
          'que agrupa el valor de cada serie en ese punto, sin llenar la '
          'grafica de etiquetas.',
      cuando:
          'Cuando hay varias series y se quiere leer sus valores a la vez '
          'en un mismo instante: comparar productos periodo a periodo.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        trackballBehavior: _trackball,
        series: <CartesianSeries<PuntoCategoria, String>>[
          for (final s in DatosMock.seriesMultiples)
            LineSeries<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
              width: 3,
              markerSettings: const MarkerSettings(isVisible: true),
            ),
        ],
      ),
    );
  }
}
 
/// 25. Serie con anotaciones y periodo destacado.
/// Combina tres elementos que no usa ninguna otra grafica del catalogo:
/// anillos y etiquetas (CartesianChartAnnotation) sobre el maximo y el
/// minimo, y una banda vertical (PlotBand en el eje de fechas).
class SfAnotaciones extends StatelessWidget {
  const SfAnotaciones({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final datos = DatosMock.serieTemporal;
    var iMax = 0;
    var iMin = 0;
    for (int i = 1; i < datos.length; i++) {
      if (datos[i].valor > datos[iMax].valor) iMax = i;
      if (datos[i].valor < datos[iMin].valor) iMin = i;
    }
    final pMax = datos[iMax];
    final pMin = datos[iMin];
 
    Widget anillo(Color c) => Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: c, width: 2.5),
          ),
        );
    Widget etiqueta(String t, Color c) => Text(
          t,
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.bold, color: c),
        );
 
    return LienzoDescrito(
      titulo: 'Syncfusion · Anotaciones',
      paraQue:
          'Sobre la serie se senalan el maximo y el minimo con un anillo y '
          'una etiqueta, y una banda vertical marca un periodo destacado '
          '(dias 9 a 17). Todo calculado desde los propios datos.',
      cuando:
          'Para contar la historia de una serie: marcar picos, valles y '
          'periodos especiales (una campana, una crisis, un mantenimiento).',
      grafica: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          plotBands: <PlotBand>[
            PlotBand(
              isVisible: true,
              start: datos[8].fecha,
              end: datos[16].fecha,
              color: Colors.amber.withValues(alpha: 0.2),
              text: 'Periodo destacado',
              textStyle: const TextStyle(fontSize: 10),
              verticalTextAlignment: TextAnchor.start,
            ),
          ],
        ),
        primaryYAxis: const NumericAxis(minimum: 0, maximum: 100),
        annotations: <CartesianChartAnnotation>[
          CartesianChartAnnotation(
            widget: anillo(Colors.green),
            coordinateUnit: CoordinateUnit.point,
            x: pMax.fecha,
            y: pMax.valor,
          ),
          CartesianChartAnnotation(
            widget: etiqueta('Max ${pMax.valor.toStringAsFixed(0)}',
                Colors.green),
            coordinateUnit: CoordinateUnit.point,
            x: pMax.fecha,
            y: pMax.valor + 7,
          ),
          CartesianChartAnnotation(
            widget: anillo(esquema.error),
            coordinateUnit: CoordinateUnit.point,
            x: pMin.fecha,
            y: pMin.valor,
          ),
          CartesianChartAnnotation(
            widget: etiqueta('Min ${pMin.valor.toStringAsFixed(0)}',
                esquema.error),
            coordinateUnit: CoordinateUnit.point,
            x: pMin.fecha,
            y: pMin.valor - 7,
          ),
        ],
        series: <CartesianSeries<PuntoTemporal, DateTime>>[
          SplineSeries<PuntoTemporal, DateTime>(
            dataSource: datos,
            xValueMapper: (p, _) => p.fecha,
            yValueMapper: (p, _) => p.valor,
            width: 2.5,
            color: esquema.primary,
          ),
        ],
      ),
    );
  }
}
 
/// 26. Eje lineal frente a eje logaritmico.
/// La misma serie en dos graficas: con escala lineal las categorias
/// pequenas casi no se ven; con LogarithmicAxis todas se leen.
class SfEjeLogaritmico extends StatelessWidget {
  const SfEjeLogaritmico({super.key});
 
  Widget _grafica(BuildContext context, String titulo, ChartAxis ejeY) {
    return SfCartesianChart(
      title: ChartTitle(
          text: titulo, textStyle: const TextStyle(fontSize: 12)),
      primaryXAxis: const CategoryAxis(),
      primaryYAxis: ejeY,
      series: <CartesianSeries<PuntoCategoria, String>>[
        ColumnSeries<PuntoCategoria, String>(
          dataSource: DatosMock.cuotaMercado,
          xValueMapper: (p, _) => p.categoria,
          yValueMapper: (p, _) => p.valor,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Eje logaritmico',
      paraQue:
          'La misma serie con escala lineal (arriba) y logaritmica base 10 '
          '(abajo): cada marca del eje logaritmico multiplica por 10, de '
          'modo que valores de magnitud muy distinta se leen a la vez.',
      cuando:
          'Cuando los datos abarcan varios ordenes de magnitud: poblaciones, '
          'ingresos, frecuencias, crecimiento exponencial.',
      grafica: Column(
        children: [
          Expanded(
              child: _grafica(
                  context, 'Escala lineal', const NumericAxis(minimum: 0))),
          Expanded(
              child: _grafica(
                  context,
                  'Escala logaritmica (base 10)',
                  const LogarithmicAxis(minimum: 1, maximum: 100))),
        ],
      ),
    );
  }
}
 
/// 27. Columnas con barras de error reales.
/// ErrorBarSeries dibuja el margen de incertidumbre (aqui, +/- 12 %) con
/// su tapa, sobre las columnas. Reemplaza el truco de usar columnas de
/// rango delgadas.
class SfBarrasError extends StatelessWidget {
  const SfBarrasError({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final datos = DatosMock.ventasMensuales;
    return LienzoDescrito(
      titulo: 'Syncfusion · Barras de error',
      paraQue:
          'Columnas con una barra de error sobre cada una: una linea '
          'vertical con tapas que marca el margen de incertidumbre (+/- 12 % '
          'del valor).',
      cuando:
          'Para datos experimentales o estimaciones donde cada valor tiene '
          'una incertidumbre asociada: encuestas, mediciones, pronosticos.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            color: esquema.primary.withValues(alpha: 0.65),
            width: 0.55,
          ),
          ErrorBarSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            type: ErrorBarType.percentage,
            verticalErrorValue: 12,
            direction: Direction.both,
            mode: RenderingMode.vertical,
            capLength: 14,
            width: 2,
            color: esquema.error,
          ),
        ],
      ),
    );
  }
}
 
/// 28. Medidor de progreso circular (RangePointer).
/// Un anillo que se llena en 360 grados hasta el valor, con el porcentaje
/// en el centro. Distinto del medidor de aguja y de los semicirculos.
class SfProgresoCircular extends StatelessWidget {
  const SfProgresoCircular({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    const valor = DatosMock.valorMedidor;
    const rango = DatosMock.rangoMedidor;
    return LienzoDescrito(
      titulo: 'Syncfusion · Progreso circular',
      paraQue:
          'Un anillo completo que se va llenando hasta el valor actual '
          '(RangePointer) sobre una pista de fondo, con el porcentaje '
          'escrito en el centro.',
      cuando:
          'Para un indicador unico de avance: cumplimiento de una meta, '
          'carga, espacio usado, progreso de una tarea.',
      grafica: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: rango,
            startAngle: 270,
            endAngle: 270,
            showLabels: false,
            showTicks: false,
            radiusFactor: 0.8,
            axisLineStyle: AxisLineStyle(
              thickness: 0.16,
              thicknessUnit: GaugeSizeUnit.factor,
              color: esquema.surfaceContainerHighest,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: valor,
                width: 0.16,
                sizeUnit: GaugeSizeUnit.factor,
                color: esquema.primary,
                enableAnimation: true,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(valor / rango * 100).toStringAsFixed(0)} %',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text('${valor.toStringAsFixed(0)} de '
                        '${rango.toStringAsFixed(0)}'),
                  ],
                ),
                positionFactor: 0.1,
                angle: 90,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 
/// 29. Medidores lineales de progreso (LinearBarPointer).
/// Tres barras de progreso, una por producto, con el valor del ultimo
/// trimestre sobre un maximo de 60.
class SfMedidoresLineales extends StatelessWidget {
  const SfMedidoresLineales({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final colores = [esquema.primary, esquema.tertiary, esquema.secondary];
    const maximo = 60.0;
    return LienzoDescrito(
      titulo: 'Syncfusion · Medidores lineales',
      paraQue:
          'Barras de progreso con extremos redondeados (LinearBarPointer) '
          'sobre una pista, una por producto, para comparar cuanto del '
          'maximo ha alcanzado cada uno.',
      cuando:
          'Para comparar avances o cumplimientos de varios elementos en '
          'poco espacio: metas por area, uso por recurso.',
      grafica: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          for (int i = 0; i < DatosMock.seriesMultiples.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DatosMock.seriesMultiples[i].nombre),
                      Text(
                        '${DatosMock.seriesMultiples[i].puntos.last.valor.toStringAsFixed(0)}'
                        ' / ${maximo.toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                  SfLinearGauge(
                    minimum: 0,
                    maximum: maximo,
                    showLabels: false,
                    showTicks: false,
                    axisTrackStyle: LinearAxisTrackStyle(
                      thickness: 16,
                      edgeStyle: LinearEdgeStyle.bothCurve,
                      color: esquema.surfaceContainerHighest,
                    ),
                    barPointers: <LinearBarPointer>[
                      LinearBarPointer(
                        value: DatosMock.seriesMultiples[i].puntos.last.valor,
                        thickness: 16,
                        edgeStyle: LinearEdgeStyle.bothCurve,
                        color: colores[i % colores.length],
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
 
/// 30. Sparks de barras y de ganar/perder.
/// Los otros dos widgets Spark de Syncfusion: SfSparkBarChart (con
/// maximo y minimo coloreados) y SfSparkWinLossChart (solo importa si
/// cada valor es positivo o negativo).
class SfSparkBarWinLoss extends StatelessWidget {
  const SfSparkBarWinLoss({super.key});
 
  Widget _tarjeta(BuildContext context, String titulo, String detalle,
      Widget spark) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 2),
                  Text(detalle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Expanded(child: spark),
          ],
        ),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final ventas = DatosMock.ventasMensuales.map((p) => p.valor).toList();
    final cascada = DatosMock.cascada.map((p) => p.valor).toList();
    return LienzoDescrito(
      titulo: 'Syncfusion · Sparks de barras y win/loss',
      paraQue:
          'Dos micro-graficas distintas: barras con el maximo en verde y el '
          'minimo en rojo, y una de ganar/perder donde solo importa el '
          'signo de cada valor.',
      cuando:
          'En tablas y tarjetas de resumen: evolucion mensual compacta '
          '(barras) o racha de resultados positivos y negativos (win/loss).',
      grafica: Column(
        children: [
          Expanded(
            child: _tarjeta(
              context,
              'Ventas',
              'Barras, maximo y minimo resaltados',
              spark.SfSparkBarChart(
                data: ventas,
                color: esquema.primary.withValues(alpha: 0.5),
                highPointColor: Colors.green,
                lowPointColor: Colors.red,
                labelDisplayMode: spark.SparkChartLabelDisplayMode.all,
              ),
            ),
          ),
          Expanded(
            child: _tarjeta(
              context,
              'Variaciones',
              'Barras con valores negativos',
              spark.SfSparkBarChart(
                data: cascada,
                color: esquema.primary,
                negativePointColor: esquema.error,
                labelDisplayMode: spark.SparkChartLabelDisplayMode.all,
              ),
            ),
          ),
          Expanded(
            child: _tarjeta(
              context,
              'Ganar / perder',
              'Solo el signo de cada paso',
              spark.SfSparkWinLossChart(
                data: cascada,
                color: Colors.green,
                negativePointColor: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 31. Datos faltantes: tres formas de tratar un hueco.
/// La misma serie con tres valores ausentes, tratados con
/// EmptyPointMode.gap (corte), average (interpolacion) y zero (cero).
class SfDatosFaltantes extends StatelessWidget {
  const SfDatosFaltantes({super.key});
 
  Widget _grafica(BuildContext context, String titulo, EmptyPointMode modo,
      List<_PuntoNulo> datos) {
    return SfCartesianChart(
      title: ChartTitle(
          text: titulo, textStyle: const TextStyle(fontSize: 12)),
      primaryXAxis: const DateTimeAxis(),
      primaryYAxis: const NumericAxis(minimum: 0, maximum: 100),
      series: <CartesianSeries<_PuntoNulo, DateTime>>[
        LineSeries<_PuntoNulo, DateTime>(
          dataSource: datos,
          xValueMapper: (p, _) => p.fecha,
          yValueMapper: (p, _) => p.valor,
          width: 2,
          markerSettings: const MarkerSettings(isVisible: true),
          emptyPointSettings: EmptyPointSettings(
            mode: modo,
            color: Theme.of(context).colorScheme.error,
            borderColor: Theme.of(context).colorScheme.error,
            borderWidth: 2,
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
 
  @override
  Widget build(BuildContext context) {
    // Los primeros 15 dias de la serie, con los dias 5, 6 y 10 ausentes
    // para simular lecturas perdidas.
    const ausentes = {4, 5, 9};
    final datos = <_PuntoNulo>[
      for (int i = 0; i < 15; i++)
        _PuntoNulo(
          DatosMock.serieTemporal[i].fecha,
          ausentes.contains(i) ? null : DatosMock.serieTemporal[i].valor,
        ),
    ];
    return LienzoDescrito(
      titulo: 'Syncfusion · Datos faltantes',
      paraQue:
          'La misma serie con tres lecturas ausentes, tratada de tres '
          'maneras: dejar un corte (gap), interpolar con el promedio de los '
          'vecinos (average) o tomarlas como cero (zero).',
      cuando:
          'Cuando los datos reales traen huecos (sensores caidos, dias sin '
          'registro) y hay que decidir si mostrarlos, rellenarlos o '
          'tratarlos como cero.',
      grafica: Column(
        children: [
          Expanded(
              child: _grafica(
                  context, 'gap (corte)', EmptyPointMode.gap, datos)),
          Expanded(
              child: _grafica(context, 'average (interpolar)',
                  EmptyPointMode.average, datos)),
          Expanded(
              child: _grafica(
                  context, 'zero (tomar como cero)', EmptyPointMode.zero, datos)),
        ],
      ),
    );
  }
}
 
/// 32. Columnas con etiquetas de eje multinivel.
/// El eje agrupa los meses bajo una segunda fila de etiquetas
/// (trimestres), con su llave.
class SfMultinivel extends StatelessWidget {
  const SfMultinivel({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Etiquetas multinivel',
      paraQue:
          'El eje de categorias muestra una segunda fila de etiquetas que '
          'agrupa varias categorias bajo un mismo nombre: aqui, los meses '
          'agrupados en trimestres.',
      cuando:
          'Cuando las categorias tienen jerarquia: meses y trimestres, '
          'ciudades y paises, productos y familias.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          multiLevelLabels: <CategoricalMultiLevelLabel>[
            CategoricalMultiLevelLabel(start: 'Ene', end: 'Mar', text: 'T1'),
            CategoricalMultiLevelLabel(start: 'Abr', end: 'Jun', text: 'T2'),
          ],
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            pointColorMapper: (p, i) => i < 3 ? esquema.primary : esquema.tertiary,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}