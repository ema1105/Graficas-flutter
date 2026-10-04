import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../core/lienzo_descrito.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart' as spark;

import '../../mock/datos_mock.dart';

// ============================================================
// Syncfusion — 10 GRAFICAS BASICAS
// Libreria comercial (gratis en su edicion Community). Modelo
// declarativo: se pasa la lista de datos y funciones mapeadoras que
// indican de donde salen X e Y. Ningun tipo se repite con las otras
// librerias del taller.
// ============================================================

/// 1. Columnas.
class SfColumnas extends StatelessWidget {
  const SfColumnas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Columnas',
      paraQue:
          'Compara cantidades entre categorias con columnas verticales. El '
          'tipo mas directo de la libreria, con tooltip incluido.',
      cuando:
          'Para comparar valores de categorias independientes: ventas por '
          'mes, cantidades por grupo.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 2. Spline (linea curva).
class SfSpline extends StatelessWidget {
  const SfSpline({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Spline',
      paraQue:
          'Una linea suavizada por curvas (spline) que conecta los puntos de '
          'forma fluida, en vez de con segmentos rectos.',
      cuando:
          'Para tendencias donde se busca una lectura estetica y continua: '
          'evoluciones suaves sin cambios bruscos.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          SplineSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            markerSettings: const MarkerSettings(isVisible: true),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 3. Area escalonada (step area).
class SfStepArea extends StatelessWidget {
  const SfStepArea({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Step area',
      paraQue:
          'Un area que avanza en escalones: el valor se mantiene constante '
          'hasta el siguiente punto, donde salta.',
      cuando:
          'Para valores que cambian en saltos discretos y se quiere resaltar '
          'el volumen bajo cada nivel: tarifas, inventarios por tramos.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<PuntoCategoria, String>>[
          StepAreaSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            opacity: 0.6,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 4. Columnas apiladas 100%.
class SfApiladas100 extends StatelessWidget {
  const SfApiladas100({super.key});
  @override
  Widget build(BuildContext context) {
    final series = DatosMock.seriesMultiples;
    return LienzoDescrito(
      titulo: 'Syncfusion · Apiladas 100%',
      paraQue:
          'Cada columna llega al 100% y se divide segun el peso relativo de '
          'cada serie, mostrando la composicion porcentual.',
      cuando:
          'Cuando interesa como se reparte el total internamente y como '
          'cambia ese reparto entre periodos, no el tamano absoluto.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries<PuntoCategoria, String>>[
          for (final s in series)
            StackedColumn100Series<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
            ),
        ],
      ),
    );
  }
}

/// 5. Barra de rango (range column).
class SfRangeColumn extends StatelessWidget {
  const SfRangeColumn({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    return LienzoDescrito(
      titulo: 'Syncfusion · Range column',
      paraQue:
          'Cada columna va de un valor minimo a uno maximo, mostrando el '
          'rango de variacion en lugar de un unico valor.',
      cuando:
          'Para datos con minimo y maximo por periodo: temperaturas del dia, '
          'rango de precios, margenes de medicion.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          RangeColumnSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            lowValueMapper: (p, _) => (p.valor - 15).clamp(0, 100),
            highValueMapper: (p, _) => (p.valor + 15).clamp(0, 100),
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}

/// 6. Spline area.
class SfSplineArea extends StatelessWidget {
  const SfSplineArea({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Spline area',
      paraQue:
          'Un area con el borde superior suavizado por curvas, uniendo el '
          'volumen de un area con la suavidad de un spline.',
      cuando:
          'Cuando se quiere la lectura de volumen de un area pero con un '
          'contorno mas elegante y continuo.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<PuntoCategoria, String>>[
          SplineAreaSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            opacity: 0.5,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 7. Linea rapida (fast line).
class SfFastLine extends StatelessWidget {
  const SfFastLine({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Fast line',
      paraQue:
          'Una linea optimizada para dibujar muchisimos puntos sin perder '
          'rendimiento, sacrificando algunos adornos.',
      cuando:
          'Para series muy largas: miles de lecturas de un sensor, datos de '
          'alta frecuencia, historicos extensos.',
      grafica: SfCartesianChart(
        primaryXAxis: const DateTimeAxis(),
        series: <CartesianSeries<PuntoTemporal, DateTime>>[
          FastLineSeries<PuntoTemporal, DateTime>(
            dataSource: DatosMock.serieTemporal,
            xValueMapper: (p, _) => p.fecha,
            yValueMapper: (p, _) => p.valor,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 8. Barras horizontales (BarSeries).
class SfColumnasDegradado extends StatelessWidget {
  const SfColumnasDegradado({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Barras horizontales',
      paraQue:
          'Barras tumbadas de izquierda a derecha. Syncfusion las ofrece como '
          'un tipo propio (BarSeries), distinto de las columnas verticales.',
      cuando:
          'Cuando los nombres de categoria son largos o hay muchas '
          'categorias, situacion en que las columnas verticales se aprietan.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          BarSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 9. Area con marcadores.
class SfAreaMarcadores extends StatelessWidget {
  const SfAreaMarcadores({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Area con marcadores',
      paraQue:
          'Un area rellena con un punto marcado sobre cada dato, uniendo la '
          'lectura de volumen con la ubicacion exacta de cada valor.',
      cuando:
          'Cuando el area transmite magnitud pero tambien se quiere senalar '
          'cada medicion concreta.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<PuntoCategoria, String>>[
          AreaSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            opacity: 0.5,
            markerSettings: const MarkerSettings(isVisible: true),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}

/// 10. Linea con etiquetas de dato.
class SfLineaEtiquetas extends StatelessWidget {
  const SfLineaEtiquetas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Linea con etiquetas',
      paraQue:
          'Una linea con el valor numerico impreso sobre cada punto, uniendo '
          'la tendencia con la cifra exacta.',
      cuando:
          'Cuando el valor preciso de cada punto importa ademas de la '
          'tendencia: informes, pocos puntos.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<PuntoCategoria, String>>[
          LineSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            markerSettings: const MarkerSettings(isVisible: true),
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
/// 11. Columna + linea (dos series en un mismo chart).
class SfColumnaLinea extends StatelessWidget {
  const SfColumnaLinea({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final a = DatosMock.seriesMultiples[0];
    final b = DatosMock.seriesMultiples[1];
    return LienzoDescrito(
      titulo: 'Syncfusion · Columna + linea',
      paraQue:
          'Una serie como columnas y otra como linea en el mismo eje, la '
          'combinacion mas comun de los reportes empresariales.',
      cuando:
          'Cuando dos medidas relacionadas se leen mejor distinto: ventas '
          '(columnas) y una meta o tendencia (linea).',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries>[
          ColumnSeries<PuntoCategoria, String>(
            name: 'Ventas',
            dataSource: a.puntos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            color: esquema.primary,
          ),
          LineSeries<PuntoCategoria, String>(
            name: 'Tendencia',
            dataSource: b.puntos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            markerSettings: const MarkerSettings(isVisible: true),
            color: esquema.error,
          ),
        ],
      ),
    );
  }
}

/// 12. Columnas apiladas (normales, no 100%).
class SfApiladas extends StatelessWidget {
  const SfApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Columnas apiladas',
      paraQue:
          'Apila las series una sobre otra, mostrando el total de cada '
          'periodo y el aporte absoluto de cada parte.',
      cuando:
          'Cuando interesan el total por periodo y la contribucion de cada '
          'serie en valores reales, no en porcentaje.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries<PuntoCategoria, String>>[
          for (final s in DatosMock.seriesMultiples)
            StackedColumnSeries<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
            ),
        ],
      ),
    );
  }
}

/// 13. Area apilada (StackedAreaSeries).
class SfAreaBorde extends StatelessWidget {
  const SfAreaBorde({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Area apilada',
      paraQue:
          'Apila el area de varias series una sobre otra, mostrando el '
          'volumen total y el aporte de cada serie a ese total.',
      cuando:
          'Cuando interesa el volumen total a lo largo del eje y como se '
          'compone: trafico por fuente, ventas por canal acumuladas.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries<PuntoCategoria, String>>[
          for (final s in DatosMock.seriesMultiples)
            StackedAreaSeries<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
              opacity: 0.6,
            ),
        ],
      ),
    );
  }
}

/// 14. Columna + spline suave.
class SfColumnaSpline extends StatelessWidget {
  const SfColumnaSpline({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Columna + spline',
      paraQue:
          'Columnas con una curva spline suave superpuesta, para ver el '
          'valor exacto y una tendencia redondeada a la vez.',
      cuando:
          'Cuando la tendencia se entiende mejor como curva suave que como '
          'linea recta sobre las columnas.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            color: esquema.primary.withValues(alpha: 0.5),
          ),
          SplineSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            width: 3,
            color: esquema.error,
          ),
        ],
      ),
    );
  }
}

/// 15. Dos lineas (comparacion de series).
class SfDosLineas extends StatelessWidget {
  const SfDosLineas({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final a = DatosMock.seriesMultiples[0];
    final b = DatosMock.seriesMultiples[1];
    return LienzoDescrito(
      titulo: 'Syncfusion · Dos lineas',
      paraQue:
          'Dos lineas en el mismo plano para comparar directamente la '
          'evolucion de dos series y la brecha entre ellas.',
      cuando:
          'Cuando lo importante es la diferencia entre dos series: ingresos '
          'vs gastos, real vs presupuestado.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries<PuntoCategoria, String>>[
          LineSeries<PuntoCategoria, String>(
            name: 'Serie A',
            dataSource: a.puntos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            markerSettings: const MarkerSettings(isVisible: true),
            color: esquema.primary,
          ),
          LineSeries<PuntoCategoria, String>(
            name: 'Serie B',
            dataSource: b.puntos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            markerSettings: const MarkerSettings(isVisible: true),
            color: esquema.tertiary,
          ),
        ],
      ),
    );
  }
}

/// 16. Columnas agrupadas (clustered).
class SfAgrupadas extends StatelessWidget {
  const SfAgrupadas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Columnas agrupadas',
      paraQue:
          'Varias columnas juntas por categoria, para comparar varias series '
          'dentro de cada periodo lado a lado.',
      cuando:
          'Cuando se comparan varios elementos en cada categoria: productos '
          'por trimestre, regiones por ano.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries<PuntoCategoria, String>>[
          for (final s in DatosMock.seriesMultiples)
            ColumnSeries<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
            ),
        ],
      ),
    );
  }
}

/// 17. Linea con banda de rango (RangeAreaSeries + LineSeries).
class SfLineaBanda extends StatelessWidget {
  const SfLineaBanda({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final datos = DatosMock.ventasMensuales;
    return LienzoDescrito(
      titulo: 'Syncfusion · Linea con banda',
      paraQue:
          'Una banda de rango (minimo-maximo) sombreada con la linea del '
          'valor central encima, delimitando el rango esperado.',
      cuando:
          'Para valores con margen: pronosticos con intervalo, mediciones '
          'con tolerancia, rangos de operacion normal.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <CartesianSeries<PuntoCategoria, String>>[
          RangeAreaSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            lowValueMapper: (p, _) => (p.valor - 12).clamp(0, 100),
            highValueMapper: (p, _) => (p.valor + 12).clamp(0, 100),
            opacity: 0.3,
            color: esquema.primary,
          ),
          LineSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            width: 3,
            color: esquema.primary,
          ),
        ],
      ),
    );
  }
}

/// 18. Columnas + banda de referencia (PlotBand).
class SfColumnasPlotBand extends StatelessWidget {
  const SfColumnasPlotBand({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final datos = DatosMock.ventasMensuales;
    final promedio =
        datos.map((p) => p.valor).reduce((a, b) => a + b) / datos.length;
    return LienzoDescrito(
      titulo: 'Syncfusion · Columnas + referencia',
      paraQue:
          'Columnas sobre una banda de trazado (PlotBand) que marca una linea '
          'de referencia en el eje, para ver quien la supera.',
      cuando:
          'Cuando los valores se evaluan contra un umbral: ventas frente al '
          'promedio, metricas frente a una meta.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: NumericAxis(
          plotBands: <PlotBand>[
            PlotBand(
              isVisible: true,
              start: promedio,
              end: promedio,
              borderWidth: 2,
              borderColor: esquema.error,
              dashArray: const [6, 4],
              text: 'Promedio ${promedio.toStringAsFixed(0)}',
              textStyle: TextStyle(color: esquema.error, fontSize: 10),
            ),
          ],
        ),
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            color: esquema.primary,
          ),
        ],
      ),
    );
  }
}

/// 19. Dispersion (scatter).
class SfScatter extends StatelessWidget {
  const SfScatter({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Dispersion',
      paraQue:
          'Ubica cada dato como un punto segun dos variables numericas, para '
          'ver la relacion entre ellas. Es el ScatterSeries.',
      cuando:
          'Para analizar correlacion entre dos medidas: dos indicadores, '
          'mediciones de dos sensores.',
      grafica: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        series: <CartesianSeries<PuntoXY, num>>[
          ScatterSeries<PuntoXY, num>(
            dataSource: DatosMock.dispersion,
            xValueMapper: (p, _) => p.x,
            yValueMapper: (p, _) => p.y,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

/// 20. Burbuja (bubble).
class SfBurbuja extends StatelessWidget {
  const SfBurbuja({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Burbuja',
      paraQue:
          'Como una dispersion, pero el tamano de cada punto codifica una '
          'tercera variable mediante sizeValueMapper.',
      cuando:
          'Cuando hay tres dimensiones numericas que relacionar: dos ejes y '
          'un peso (ingreso, gasto y tamano, por ejemplo).',
      grafica: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        series: <CartesianSeries<PuntoXY, num>>[
          BubbleSeries<PuntoXY, num>(
            dataSource: DatosMock.dispersion,
            xValueMapper: (p, _) => p.x,
            yValueMapper: (p, _) => p.y,
            sizeValueMapper: (p, _) => p.tamano,
            color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}

/// 21. Step line con dos series.
/// A diferencia del Step area, aqui solo se dibuja el borde escalonado.
/// La segunda serie va punteada para distinguirla de la primera.
class SfStepLinea extends StatelessWidget {
  const SfStepLinea({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final a = DatosMock.seriesMultiples[0];
    final b = DatosMock.seriesMultiples[1];
    return LienzoDescrito(
      titulo: 'Syncfusion · Step line',
      paraQue:
          'Lineas que avanzan en escalones rectos: el valor se mantiene '
          'constante hasta que cambia de golpe. Aqui, dos series, una de '
          'ellas punteada.',
      cuando:
          'Para magnitudes que cambian por saltos y se sostienen entre '
          'cambios: tarifas por tramos, niveles de inventario, estados.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          StepLineSeries<PuntoCategoria, String>(
            name: a.nombre,
            dataSource: a.puntos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            markerSettings: const MarkerSettings(isVisible: true),
            color: esquema.primary,
          ),
          StepLineSeries<PuntoCategoria, String>(
            name: b.nombre,
            dataSource: b.puntos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            dashArray: const <double>[6, 4],
            markerSettings: const MarkerSettings(isVisible: true),
            color: esquema.tertiary,
          ),
        ],
      ),
    );
  }
}
 
/// 22. Lineas apiladas.
/// StackedLineSeries acumula las series: cada linea se dibuja sobre la
/// anterior, de modo que la ultima es el total.
class SfLineasApiladas extends StatelessWidget {
  const SfLineasApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Lineas apiladas',
      paraQue:
          'Lineas acumuladas una sobre otra: la altura de cada una es la '
          'suma de ella y de las anteriores, y la ultima recorre el total.',
      cuando:
          'Cuando interesa ver como se acumula un total entre varias '
          'series sin el relleno de un area: ingresos por linea de negocio.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          for (final s in DatosMock.seriesMultiples)
            StackedLineSeries<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
              markerSettings: const MarkerSettings(isVisible: true),
            ),
        ],
      ),
    );
  }
}
 
/// 23. Barras horizontales apiladas.
/// Combina la orientacion de BarSeries con el apilado.
class SfBarrasApiladasHoriz extends StatelessWidget {
  const SfBarrasApiladasHoriz({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Barras horizontales apiladas',
      paraQue:
          'Barras tumbadas donde cada una se compone de segmentos apilados: '
          'muestra el total por categoria y su desglose por serie.',
      cuando:
          'Cuando hay etiquetas largas o muchas categorias y ademas importa '
          'la composicion: ventas por canal en cada region.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          for (final s in DatosMock.seriesMultiples)
            StackedBarSeries<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
              borderRadius: BorderRadius.circular(3),
            ),
        ],
      ),
    );
  }
}
 
/// 24. Area apilada al 100 %.
/// Las areas llenan siempre toda la altura: se lee el peso relativo de
/// cada serie, no el volumen.
class SfArea100 extends StatelessWidget {
  const SfArea100({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Area al 100 %',
      paraQue:
          'Areas apiladas que siempre ocupan el 100 % del alto: lo que se '
          've es como cambia el peso relativo de cada serie en el tiempo.',
      cuando:
          'Para seguir la composicion aunque el total cambie: participacion '
          'de cada producto o canal en cada periodo.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          for (final s in DatosMock.seriesMultiples)
            StackedArea100Series<PuntoCategoria, String>(
              name: s.nombre,
              dataSource: s.puntos,
              xValueMapper: (p, _) => p.categoria,
              yValueMapper: (p, _) => p.valor,
              opacity: 0.7,
              borderDrawMode: BorderDrawMode.top,
              borderWidth: 2,
            ),
        ],
      ),
    );
  }
}
 
/// 25. Histograma.
/// HistogramSeries agrupa los 30 valores en intervalos de ancho fijo y
/// cuenta cuantos caen en cada uno; opcionalmente traza la curva normal.
class SfHistograma extends StatelessWidget {
  const SfHistograma({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Histograma',
      paraQue:
          'Muestra como se distribuyen los valores: se agrupan en '
          'intervalos iguales (binInterval) y cada columna cuenta cuantos '
          'datos caen en el. La curva roja es la normal equivalente.',
      cuando:
          'Para conocer la forma de unos datos antes de resumirlos: si se '
          'concentran, si son simetricos o si hay valores extremos.',
      grafica: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<double, double>>[
          HistogramSeries<double, double>(
            dataSource: DatosMock.distribucion,
            yValueMapper: (v, _) => v,
            binInterval: 10,
            showNormalDistributionCurve: true,
            curveColor: esquema.error,
            curveWidth: 2.5,
            color: esquema.primary.withValues(alpha: 0.7),
            borderColor: esquema.primary,
            borderWidth: 1,
          ),
        ],
      ),
    );
  }
}
 
/// 26. Pastel con porcion explotada.
/// PieSeries (el catalogo solo tenia dona, radial y piramide). La
/// porcion mayor se separa del centro y, al tocar otra, tambien.
class SfPastelExplotado extends StatelessWidget {
  const SfPastelExplotado({super.key});
  @override
  Widget build(BuildContext context) {
    return LienzoDescrito(
      titulo: 'Syncfusion · Pastel con porcion separada',
      paraQue:
          'Un pastel donde una porcion se separa del centro para llamar la '
          'atencion: la mayor arranca separada y al tocar otra, esa se '
          'separa tambien.',
      cuando:
          'Cuando hay una categoria clave que resaltar frente al resto: la '
          'region lider, el producto estrella, el mayor gasto.',
      grafica: SfCircularChart(
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries<PuntoCategoria, String>>[
          PieSeries<PuntoCategoria, String>(
            dataSource: DatosMock.cuotaMercado,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            dataLabelMapper: (p, _) =>
                '${p.categoria}\n${p.valor.toStringAsFixed(0)}%',
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
            ),
            explode: true,
            explodeIndex: 0,
            explodeOffset: '12%',
            explodeGesture: ActivationMode.singleTap,
          ),
        ],
      ),
    );
  }
}
 
/// 27. Dona con total al centro.
/// La dona de siempre con una anotacion circular (CircularChartAnnotation)
/// en su hueco, que muestra el total.
class SfDonaTotalCentro extends StatelessWidget {
  const SfDonaTotalCentro({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cuotaMercado;
    final total = datos.fold<double>(0, (s, p) => s + p.valor);
    final texto = Theme.of(context).textTheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Dona con total al centro',
      paraQue:
          'Una dona con una anotacion en su hueco central que muestra el '
          'total, aprovechando el espacio libre como indicador.',
      cuando:
          'En tableros donde el total o un KPI acompanan al reparto: '
          'participacion de mercado, presupuesto por rubro.',
      grafica: SfCircularChart(
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total', style: texto.labelMedium),
                Text('${total.toStringAsFixed(0)} %',
                    style: texto.headlineSmall),
              ],
            ),
          ),
        ],
        series: <CircularSeries<PuntoCategoria, String>>[
          DoughnutSeries<PuntoCategoria, String>(
            dataSource: datos,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            innerRadius: '62%',
            radius: '85%',
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
 
/// 28. Columnas con pista (track).
/// Cada columna se dibuja sobre una pista gris que llega al maximo del
/// eje: se lee cada valor como proporcion de ese tope.
class SfColumnasPista extends StatelessWidget {
  const SfColumnasPista({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Columnas con pista',
      paraQue:
          'Columnas que se dibujan sobre una pista de fondo que llega al '
          'maximo del eje, para leer cada valor como porcentaje de ese '
          'tope, con su cifra impresa.',
      cuando:
          'Cuando cada columna se interpreta contra un maximo comun: '
          'capacidad usada, avance sobre una meta fija.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(minimum: 0, maximum: 80),
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            isTrackVisible: true,
            trackColor: esquema.surfaceContainerHighest,
            trackPadding: 2,
            borderRadius: BorderRadius.circular(6),
            width: 0.5,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            color: esquema.primary,
          ),
        ],
      ),
    );
  }
}
 
/// 29. Columnas con degradado.
/// Degradado vertical en cada columna y esquinas redondeadas. (La clase
/// existente SfColumnasDegradado dibuja barras horizontales, por eso esta
/// lleva otro nombre.)
class SfColumnasGradiente extends StatelessWidget {
  const SfColumnasGradiente({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    return LienzoDescrito(
      titulo: 'Syncfusion · Columnas con degradado',
      paraQue:
          'Columnas rellenas con un degradado vertical entre dos colores y '
          'esquinas redondeadas, para un acabado mas cuidado.',
      cuando:
          'En tableros y pantallas destacadas donde la estetica pesa tanto '
          'como la lectura de los valores.',
      grafica: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoCategoria, String>>[
          ColumnSeries<PuntoCategoria, String>(
            dataSource: DatosMock.ventasMensuales,
            xValueMapper: (p, _) => p.categoria,
            yValueMapper: (p, _) => p.valor,
            width: 0.55,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [esquema.tertiary, esquema.primary],
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 30. Dispersion por grupos con marcadores distintos.
/// Dos series de ScatterSeries, cada una con su forma (rombo y cuadrado)
/// ademas del color.
class SfDispersionGrupos extends StatelessWidget {
  const SfDispersionGrupos({super.key});
  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final altos = DatosMock.dispersion.where((p) => p.y > 50).toList();
    final bajos = DatosMock.dispersion.where((p) => p.y <= 50).toList();
    return LienzoDescrito(
      titulo: 'Syncfusion · Dispersion por grupos',
      paraQue:
          'Una nube de puntos dividida en dos grupos que se distinguen por '
          'su forma (rombo y cuadrado) y por su color.',
      cuando:
          'Cuando la grafica puede verse en blanco y negro o la leen '
          'personas con daltonismo: la forma refuerza al color.',
      grafica: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<PuntoXY, num>>[
          ScatterSeries<PuntoXY, num>(
            name: 'Y alto (> 50)',
            dataSource: altos,
            xValueMapper: (p, _) => p.x,
            yValueMapper: (p, _) => p.y,
            color: esquema.primary,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
              width: 11,
              height: 11,
            ),
          ),
          ScatterSeries<PuntoXY, num>(
            name: 'Y bajo (<= 50)',
            dataSource: bajos,
            xValueMapper: (p, _) => p.x,
            yValueMapper: (p, _) => p.y,
            color: esquema.error,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.rectangle,
              width: 9,
              height: 9,
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 31. Sparklines (widgets Spark reales).
/// Syncfusion incluye widgets Spark propios, distintos del "Spark" que
/// ya existe (que es un SfCartesianChart sin ejes): son mucho mas
/// livianos y traen marcadores de maximo y minimo.
class SfSparklines extends StatelessWidget {
  const SfSparklines({super.key});
 
  Widget _tarjeta(BuildContext context, String titulo, List<num> datos,
      {required bool area}) {
    final esquema = Theme.of(context).colorScheme;
    final ultimo = datos.last;
    final delta = ultimo - datos.first;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 4),
                  Text(ultimo.toStringAsFixed(0),
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text(
                    '${delta >= 0 ? '+' : ''}${delta.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: delta >= 0 ? Colors.green : esquema.error,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: area
                  ? spark.SfSparkAreaChart(
                      data: datos,
                      color: esquema.primary.withValues(alpha: 0.35),
                      borderColor: esquema.primary,
                      borderWidth: 2,
                      highPointColor: Colors.green,
                      lowPointColor: Colors.red,
                      marker: const spark.SparkChartMarker(
                        displayMode: spark.SparkChartMarkerDisplayMode.all,
                        size: 6,
                      ),
                    )
                  : spark.SfSparkLineChart(
                      data: datos,
                      color: esquema.tertiary,
                      width: 2,
                      highPointColor: Colors.green,
                      lowPointColor: Colors.red,
                      marker: const spark.SparkChartMarker(
                        displayMode: spark.SparkChartMarkerDisplayMode.all,
                        size: 6,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final v = DatosMock.serieTemporal.map((p) => p.valor).toList();
    return LienzoDescrito(
      titulo: 'Syncfusion · Sparklines',
      paraQue:
          'Mini-graficas sin ejes que resumen la tendencia de un tramo en '
          'muy poco espacio, con el maximo en verde y el minimo en rojo, '
          'junto a su valor final y variacion.',
      cuando:
          'En tableros y listas donde se comparan muchas series a la vez y '
          'solo importa la forma: KPIs, monitores, celdas de tabla.',
      grafica: Column(
        children: [
          Expanded(
              child: _tarjeta(context, 'Dias 1-10', v.sublist(0, 10),
                  area: false)),
          Expanded(
              child: _tarjeta(context, 'Dias 11-20', v.sublist(10, 20),
                  area: true)),
          Expanded(
              child: _tarjeta(context, 'Dias 21-30', v.sublist(20, 30),
                  area: false)),
        ],
      ),
    );
  }
}