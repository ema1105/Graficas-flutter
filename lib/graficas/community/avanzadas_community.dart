import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../../core/lienzo_descrito.dart';

import '../../mock/datos_mock.dart';
 import 'dart:math' as math;

// ============================================================
// community_charts — 10 GRAFICAS AVANZADAS
// El diferenciador de esta libreria frente a las otras tres del taller:
// combos (dos renderers en una grafica), comportamientos interactivos
// (seleccion, slider, zoom) y anotaciones de rango. Ninguna se repite.
// ============================================================

charts.Color _color(int i) {
  final paleta = <charts.Color>[
    charts.MaterialPalette.blue.shadeDefault,
    charts.MaterialPalette.deepOrange.shadeDefault,
    charts.MaterialPalette.green.shadeDefault,
    charts.MaterialPalette.purple.shadeDefault,
    charts.MaterialPalette.cyan.shadeDefault,
  ];
  return paleta[i % paleta.length];
}

// ============================================================
// PARTE 1 — LAS 10 AVANZADAS ORIGINALES (ahora con descripcion)
// ============================================================

/// 1. Barras con seleccion interactiva.
class CcBarrasSeleccion extends StatelessWidget {
  const CcBarrasSeleccion({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Ventas',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: DatosMock.ventasMensuales,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras con seleccion',
      paraQue:
          'Al tocar una barra, la grafica la selecciona y resalta su '
          'categoria, atenuando el resto para centrar la atencion.',
      cuando:
          'En tableros interactivos donde el usuario explora categorias una '
          'a una y necesita aislar la que esta revisando.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
      ),
    );
  }
}

/// 2. Combo linea + barra.
class CcComboLineaBarra extends StatelessWidget {
  const CcComboLineaBarra({super.key});
  @override
  Widget build(BuildContext context) {
    final barras = DatosMock.seriesMultiples[0];
    final linea = DatosMock.seriesMultiples[1];
    final series = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Barras',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: barras.puntos,
      ),
      charts.Series<PuntoCategoria, String>(
        id: 'Linea',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(1),
        data: linea.puntos,
      )..setAttribute(charts.rendererIdKey, 'linea'),
    ];
    return LienzoDescrito(
      titulo: 'community · Combo linea + barra',
      paraQue:
          'Dibuja una serie como barras y otra como linea en el mismo eje, '
          'para comparar dos medidas relacionadas con lecturas distintas.',
      cuando:
          'Cuando dos series merecen formas diferentes: ventas (barras) '
          'frente a otra metrica que se lee mejor como tendencia (linea).',
      grafica: charts.OrdinalComboChart(
        series,
        animate: true,
        defaultRenderer: charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.grouped),
        customSeriesRenderers: [
          charts.LineRendererConfig(customRendererId: 'linea'),
        ],
      ),
    );
  }
}

/// 3. Combo dispersion + linea.
class CcComboDispersionLinea extends StatelessWidget {
  const CcComboDispersionLinea({super.key});
  @override
  Widget build(BuildContext context) {
    final puntos = DatosMock.dispersion.take(20).toList()
      ..sort((a, b) => a.x.compareTo(b.x));
    final series = <charts.Series<dynamic, num>>[
      charts.Series<PuntoXY, num>(
        id: 'Puntos',
        domainFn: (p, _) => p.x,
        measureFn: (p, _) => p.y,
        colorFn: (_, __) => _color(3),
        data: puntos,
      ),
      charts.Series<PuntoXY, num>(
        id: 'Tendencia',
        domainFn: (p, _) => p.x,
        measureFn: (p, _) => p.x * 0.6,
        colorFn: (_, __) => _color(1),
        data: puntos,
      )..setAttribute(charts.rendererIdKey, 'linea'),
    ];
    return LienzoDescrito(
      titulo: 'community · Combo dispersion + linea',
      paraQue:
          'Una nube de puntos con una linea de tendencia superpuesta, para '
          'ver los datos crudos y su comportamiento esperado juntos.',
      cuando:
          'Cuando se compara lo observado contra un modelo o expectativa: '
          'mediciones reales frente a una tendencia teorica.',
      grafica: charts.NumericComboChart(
        series,
        animate: true,
        defaultRenderer: charts.PointRendererConfig(),
        customSeriesRenderers: [
          charts.LineRendererConfig(customRendererId: 'linea'),
        ],
      ),
    );
  }
}

/// 4. Lineas con leyenda de series.
class CcLineasLeyenda extends StatelessWidget {
  const CcLineasLeyenda({super.key});
  @override
  Widget build(BuildContext context) {
    final series = <charts.Series<dynamic, num>>[];
    for (int s = 0; s < DatosMock.seriesMultiples.length; s++) {
      final sn = DatosMock.seriesMultiples[s];
      series.add(charts.Series<PuntoCategoria, num>(
        id: sn.nombre,
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(s),
        data: sn.puntos,
      ));
    }
    return LienzoDescrito(
      titulo: 'community · Lineas con leyenda',
      paraQue:
          'Varias lineas acompanadas de una leyenda que identifica cada '
          'serie por nombre y color.',
      cuando:
          'Cuando hay varias series y el lector necesita saber cual es '
          'cual sin depender solo del color.',
      grafica: charts.LineChart(
        series,
        animate: true,
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}

/// 5. Barras con resaltado de seguimiento.
class CcBarrasSlider extends StatelessWidget {
  const CcBarrasSlider({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Ventas',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(2),
        data: DatosMock.ventasMensuales,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras con resaltado',
      paraQue:
          'Al tocar, dibuja lineas guia horizontal y vertical hacia el punto '
          'mas cercano, ayudando a leer su valor contra los ejes.',
      cuando:
          'Cuando el usuario necesita ubicar con precision el valor de una '
          'barra respecto al eje sin etiquetas permanentes.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        behaviors: [
          charts.LinePointHighlighter(
            showHorizontalFollowLine:
                charts.LinePointHighlighterFollowLineType.nearest,
            showVerticalFollowLine:
                charts.LinePointHighlighterFollowLineType.nearest,
          ),
        ],
      ),
    );
  }
}

/// 6. Serie de tiempo con banda de rango.
class CcBandaConfianza extends StatelessWidget {
  const CcBandaConfianza({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, DateTime>>[
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Indicador',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: DatosMock.serieTemporal,
      ),
    ];
    final inicio = DatosMock.serieTemporal[8].fecha;
    final fin = DatosMock.serieTemporal[16].fecha;
    return LienzoDescrito(
      titulo: 'community · Serie con banda',
      paraQue:
          'Una serie temporal con un periodo sombreado de fondo, que destaca '
          'un intervalo de fechas concreto dentro de la serie.',
      cuando:
          'Para marcar periodos especiales: una campana, una crisis, una '
          'temporada alta, un mantenimiento.',
      grafica: charts.TimeSeriesChart(
        serie,
        animate: true,
        behaviors: [
          charts.RangeAnnotation([
            charts.RangeAnnotationSegment(
              inicio,
              fin,
              charts.RangeAnnotationAxisType.domain,
              color: charts.MaterialPalette.gray.shadeDefault.lighter,
            ),
          ]),
        ],
      ),
    );
  }
}

/// 7. Lineas con zoom y paneo.
class CcZoomPan extends StatelessWidget {
  const CcZoomPan({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, DateTime>>[
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Indicador',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(3),
        data: DatosMock.serieTemporal,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Zoom y paneo',
      paraQue:
          'Permite acercar con dos dedos y desplazar la grafica, para '
          'explorar series largas en detalle.',
      cuando:
          'Para historicos extensos donde la vista completa oculta el '
          'detalle: meses de datos diarios, registros de sensores.',
      grafica: charts.TimeSeriesChart(
        serie,
        animate: false,
        behaviors: [charts.PanAndZoomBehavior()],
      ),
    );
  }
}

/// 8. Gauge de arco.
class CcGaugeArco extends StatelessWidget {
  const CcGaugeArco({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = [
      PuntoCategoria('Uso', DatosMock.valorMedidor),
      PuntoCategoria('Resto', DatosMock.rangoMedidor - DatosMock.valorMedidor),
    ];
    final serie = <charts.Series<PuntoCategoria, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Gauge',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, i) => i == 0
            ? _color(0)
            : charts.MaterialPalette.gray.shadeDefault.lighter,
        data: datos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Gauge de arco',
      paraQue:
          'Un semicirculo que se llena segun un valor sobre su maximo, '
          'imitando un medidor.',
      cuando:
          'Para un indicador unico de avance o uso: capacidad, cumplimiento, '
          'nivel de un recurso.',
      grafica: charts.PieChart<String>(
        serie,
        animate: true,
        defaultRenderer: charts.ArcRendererConfig<String>(
          arcRatio: 0.6,
          startAngle: 3.14,
          arcLength: 3.14,
        ),
      ),
    );
  }
}

/// 9. Barras horizontales.
class CcBarrasHorizontales extends StatelessWidget {
  const CcBarrasHorizontales({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Ventas',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(1),
        data: DatosMock.ventasMensuales,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras horizontales',
      paraQue:
          'Barras tumbadas que dejan espacio para etiquetas largas en el '
          'eje de categorias.',
      cuando:
          'Cuando los nombres de categoria son largos o numerosos y las '
          'barras verticales se apretarian.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        vertical: false,
      ),
    );
  }
}

/// 10. Linea con anotacion de rango en el eje de medida.
class CcLineaAnotacion extends StatelessWidget {
  const CcLineaAnotacion({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, num>>[
      charts.Series<PuntoTemporal, num>(
        id: 'Serie',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(2),
        data: DatosMock.serieTemporal,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Linea con anotacion',
      paraQue:
          'Una linea sobre una franja horizontal sombreada que marca un '
          'rango de valores aceptables.',
      cuando:
          'Para ver cuando una serie entra o sale de un rango objetivo: '
          'temperatura normal, nivel optimo de inventario.',
      grafica: charts.LineChart(
        serie,
        animate: true,
        behaviors: [
          charts.RangeAnnotation([
            charts.RangeAnnotationSegment(
              60,
              80,
              charts.RangeAnnotationAxisType.measure,
              color: charts.MaterialPalette.green.shadeDefault.lighter,
            ),
          ]),
        ],
      ),
    );
  }
}

/// 11. Combo barras + area.
class CcComboBarrasArea extends StatelessWidget {
  const CcComboBarrasArea({super.key});
  @override
  Widget build(BuildContext context) {
    final barras = DatosMock.seriesMultiples[0];
    final area = DatosMock.seriesMultiples[2];
    final series = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Barras',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: barras.puntos,
      ),
      charts.Series<PuntoCategoria, String>(
        id: 'Volumen',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(2),
        areaColorFn: (_, __) => _color(2).lighter,
        data: area.puntos,
      )..setAttribute(charts.rendererIdKey, 'area'),
    ];
    return LienzoDescrito(
      titulo: 'community · Combo barras + area',
      paraQue:
          'Barras con el valor de cada periodo sobre un area de fondo que '
          'representa otra magnitud de contexto.',
      cuando:
          'Cuando una medida puntual se interpreta frente a un volumen '
          'general: ventas de un producto frente al total del mercado.',
      grafica: charts.OrdinalComboChart(
        series,
        animate: true,
        defaultRenderer: charts.BarRendererConfig(),
        customSeriesRenderers: [
          charts.LineRendererConfig(
              customRendererId: 'area', includeArea: true),
        ],
      ),
    );
  }
}

/// 12. Serie temporal + promedio + banda normal.
class CcTiempoPromedioBanda extends StatelessWidget {
  const CcTiempoPromedioBanda({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final promedio =
        datos.map((p) => p.valor).reduce((a, b) => a + b) / datos.length;
    final lineaProm =
        datos.map((p) => PuntoTemporal(p.fecha, promedio)).toList();
    final series = <charts.Series<dynamic, DateTime>>[
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Valor',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: datos,
      ),
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Promedio',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(1),
        dashPatternFn: (_, __) => [6, 4],
        data: lineaProm,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Tiempo + promedio + banda',
      paraQue:
          'La serie, su promedio como linea discontinua y una franja de '
          'normalidad alrededor del promedio, en una sola vista.',
      cuando:
          'Para detectar anomalias: ver de un vistazo que dias se salieron '
          'del rango normal respecto a la media.',
      grafica: charts.TimeSeriesChart(
        series,
        animate: true,
        behaviors: [
          charts.RangeAnnotation([
            charts.RangeAnnotationSegment(
              promedio - 10,
              promedio + 10,
              charts.RangeAnnotationAxisType.measure,
              color: charts.MaterialPalette.gray.shadeDefault.lighter,
            ),
          ]),
        ],
      ),
    );
  }
}

/// 13. Barras agrupadas + seleccion + leyenda.
class CcAgrupadasSeleccionLeyenda extends StatelessWidget {
  const CcAgrupadasSeleccionLeyenda({super.key});
  @override
  Widget build(BuildContext context) {
    final series = <charts.Series<dynamic, String>>[];
    for (int s = 0; s < DatosMock.seriesMultiples.length; s++) {
      final sn = DatosMock.seriesMultiples[s];
      series.add(charts.Series<PuntoCategoria, String>(
        id: sn.nombre,
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(s),
        data: sn.puntos,
      ));
    }
    return LienzoDescrito(
      titulo: 'community · Agrupadas + seleccion + leyenda',
      paraQue:
          'Barras agrupadas con leyenda para identificar cada serie y '
          'seleccion al tocar para resaltar el periodo que se revisa.',
      cuando:
          'En tableros comparativos donde el usuario explora periodo a '
          'periodo varias series a la vez.',
      grafica: charts.BarChart(
        series,
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [
          charts.SeriesLegend(),
          charts.SelectNearest(),
          charts.DomainHighlighter(),
        ],
      ),
    );
  }
}

/// 14. Dispersion + zoom + seleccion.
class CcDispersionZoom extends StatelessWidget {
  const CcDispersionZoom({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, num>>[
      charts.Series<PuntoXY, num>(
        id: 'Puntos',
        domainFn: (p, _) => p.x,
        measureFn: (p, _) => p.y,
        colorFn: (_, __) => _color(3),
        radiusPxFn: (p, _) => p.tamano / 3,
        data: DatosMock.dispersion,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Dispersion + zoom',
      paraQue:
          'Una nube de puntos que se puede acercar y desplazar con los '
          'dedos, y donde tocar un punto lo selecciona.',
      cuando:
          'Para nubes densas donde los puntos se solapan: acercarse a una '
          'zona y tocar para identificar elementos concretos.',
      grafica: charts.ScatterPlotChart(
        serie,
        animate: false,
        behaviors: [
          charts.PanAndZoomBehavior(),
          charts.SelectNearest(),
        ],
      ),
    );
  }
}

/// 15. Combo barras apiladas + linea de total.
class CcApiladasLineaTotal extends StatelessWidget {
  const CcApiladasLineaTotal({super.key});
  @override
  Widget build(BuildContext context) {
    final multiples = DatosMock.seriesMultiples;
    final cats = multiples.first.puntos;
    final totales = <PuntoCategoria>[
      for (int i = 0; i < cats.length; i++)
        PuntoCategoria(
          cats[i].categoria,
          multiples.fold<double>(0, (s, se) => s + se.puntos[i].valor),
        ),
    ];
    final series = <charts.Series<dynamic, String>>[
      for (int s = 0; s < multiples.length; s++)
        charts.Series<PuntoCategoria, String>(
          id: multiples[s].nombre,
          domainFn: (p, _) => p.categoria,
          measureFn: (p, _) => p.valor,
          colorFn: (_, __) => _color(s),
          data: multiples[s].puntos,
        ),
      charts.Series<PuntoCategoria, String>(
        id: 'Total',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => charts.MaterialPalette.black,
        data: totales,
      )..setAttribute(charts.rendererIdKey, 'total'),
    ];
    return LienzoDescrito(
      titulo: 'community · Apiladas + linea total',
      paraQue:
          'Barras apiladas por componente con una linea que recorre el '
          'total de cada periodo, para ver composicion y evolucion del total.',
      cuando:
          'Cuando importa como crece el total y que parte lo impulsa: '
          'ingresos por linea de negocio y su tendencia global.',
      grafica: charts.OrdinalComboChart(
        series,
        animate: true,
        defaultRenderer: charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.stacked),
        customSeriesRenderers: [
          charts.LineRendererConfig(
              customRendererId: 'total', includePoints: true),
        ],
      ),
    );
  }
}

/// 16. Lineas multiples + promedio general + leyenda.
class CcLineasPromedioLeyenda extends StatelessWidget {
  const CcLineasPromedioLeyenda({super.key});
  @override
  Widget build(BuildContext context) {
    final multiples = DatosMock.seriesMultiples;
    final n = multiples.first.puntos.length;
    final promedio = <PuntoCategoria>[
      for (int i = 0; i < n; i++)
        PuntoCategoria(
          multiples.first.puntos[i].categoria,
          multiples.fold<double>(0, (s, se) => s + se.puntos[i].valor) /
              multiples.length,
        ),
    ];
    final series = <charts.Series<dynamic, num>>[
      for (int s = 0; s < multiples.length; s++)
        charts.Series<PuntoCategoria, num>(
          id: multiples[s].nombre,
          domainFn: (p, i) => i ?? 0,
          measureFn: (p, _) => p.valor,
          colorFn: (_, __) => _color(s),
          data: multiples[s].puntos,
        ),
      charts.Series<PuntoCategoria, num>(
        id: 'Promedio',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => charts.MaterialPalette.black,
        dashPatternFn: (_, __) => [6, 4],
        data: promedio,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Lineas + promedio + leyenda',
      paraQue:
          'Varias series con puntos, una linea discontinua con el promedio '
          'de todas y leyenda, para ver quien esta sobre o bajo la media.',
      cuando:
          'Para comparar el desempeno de varios elementos contra el '
          'promedio del grupo: vendedores, sucursales, productos.',
      grafica: charts.LineChart(
        series,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(includePoints: true),
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}

/// 17. Gauge doble (dos arcos concentricos).
class CcGaugeDoble extends StatelessWidget {
  const CcGaugeDoble({super.key});

  List<charts.Series<PuntoCategoria, String>> _arco(
      String id, double valor, int color) {
    return [
      charts.Series<PuntoCategoria, String>(
        id: id,
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, i) => i == 0
            ? _color(color)
            : charts.MaterialPalette.gray.shadeDefault.lighter,
        data: [
          PuntoCategoria('Valor', valor),
          PuntoCategoria('Resto', 100 - valor),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const valorB = 45.0;
    return LienzoDescrito(
      titulo: 'community · Gauge doble',
      paraQue:
          'Dos medidores semicirculares concentricos, cada uno con su '
          'indicador, para comparar dos niveles en un mismo espacio.',
      cuando:
          'Para contrastar dos indicadores relacionados: uso de CPU y '
          'memoria, meta anual y meta mensual, real y planificado.',
      grafica: Stack(
        alignment: Alignment.center,
        children: [
          charts.PieChart<String>(
            _arco('Externo', DatosMock.valorMedidor, 0),
            animate: true,
            defaultRenderer: charts.ArcRendererConfig<String>(
              arcWidth: 22,
              startAngle: 3.14,
              arcLength: 3.14,
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.65,
            heightFactor: 0.65,
            child: charts.PieChart<String>(
              _arco('Interno', valorB, 1),
              animate: true,
              defaultRenderer: charts.ArcRendererConfig<String>(
                arcWidth: 18,
                startAngle: 3.14,
                arcLength: 3.14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 18. Area + linea de referencia.
class CcAreaReferencia extends StatelessWidget {
  const CcAreaReferencia({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final promedio =
        datos.map((p) => p.valor).reduce((a, b) => a + b) / datos.length;
    final serie = <charts.Series<dynamic, num>>[
      charts.Series<PuntoTemporal, num>(
        id: 'Volumen',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(4),
        data: datos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Area + referencia',
      paraQue:
          'Un area de volumen con una linea horizontal de referencia '
          'rotulada, para ver cuanto del volumen supera el umbral.',
      cuando:
          'Cuando un volumen se evalua contra un umbral: consumo frente al '
          'promedio, demanda frente a la capacidad instalada.',
      grafica: charts.LineChart(
        serie,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(includeArea: true),
        behaviors: [
          charts.RangeAnnotation([
            charts.LineAnnotationSegment(
              promedio,
              charts.RangeAnnotationAxisType.measure,
              endLabel: 'Promedio',
              color: charts.MaterialPalette.red.shadeDefault,
            ),
          ]),
        ],
      ),
    );
  }
}

/// 19. Dispersion por grupos + zonas + leyenda.
class CcDispersionZonas extends StatelessWidget {
  const CcDispersionZonas({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final grupos = <String, List<PuntoXY>>{
      'Bajo': datos.where((p) => p.x < 33).toList(),
      'Medio': datos.where((p) => p.x >= 33 && p.x < 66).toList(),
      'Alto': datos.where((p) => p.x >= 66).toList(),
    };
    final nombres = grupos.keys.toList();
    final series = <charts.Series<dynamic, num>>[
      for (int g = 0; g < nombres.length; g++)
        charts.Series<PuntoXY, num>(
          id: nombres[g],
          domainFn: (p, _) => p.x,
          measureFn: (p, _) => p.y,
          colorFn: (_, __) => _color(g),
          data: grupos[nombres[g]]!,
        ),
    ];
    return LienzoDescrito(
      titulo: 'community · Dispersion por zonas',
      paraQue:
          'Una nube de puntos dividida en tres zonas sombreadas, cada una '
          'con su color de grupo y leyenda que las identifica.',
      cuando:
          'Para segmentar elementos por rangos de una variable: clientes '
          'por nivel de gasto, productos por rango de precio.',
      grafica: charts.ScatterPlotChart(
        series,
        animate: true,
        behaviors: [
          charts.SeriesLegend(),
          charts.RangeAnnotation([
            charts.RangeAnnotationSegment(
              0,
              33,
              charts.RangeAnnotationAxisType.domain,
              color: charts.MaterialPalette.blue.shadeDefault.lighter,
            ),
            charts.RangeAnnotationSegment(
              66,
              100,
              charts.RangeAnnotationAxisType.domain,
              color: charts.MaterialPalette.green.shadeDefault.lighter,
            ),
          ]),
        ],
      ),
    );
  }
}

/// 20. Combo de tres renderers: barras + linea + puntos.
class CcComboTres extends StatelessWidget {
  const CcComboTres({super.key});
  @override
  Widget build(BuildContext context) {
    final m = DatosMock.seriesMultiples;
    final series = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: m[0].nombre,
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: m[0].puntos,
      ),
      charts.Series<PuntoCategoria, String>(
        id: m[1].nombre,
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(1),
        data: m[1].puntos,
      )..setAttribute(charts.rendererIdKey, 'linea'),
      charts.Series<PuntoCategoria, String>(
        id: m[2].nombre,
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(2),
        data: m[2].puntos,
      )..setAttribute(charts.rendererIdKey, 'puntos'),
    ];
    return LienzoDescrito(
      titulo: 'community · Combo de tres renderers',
      paraQue:
          'Tres series en la misma grafica, cada una con una forma distinta: '
          'barras, linea y puntos, para separarlas visualmente por su rol.',
      cuando:
          'Cuando se combinan tres medidas de naturaleza distinta: valor '
          'real (barras), tendencia (linea) y meta puntual (puntos).',
      grafica: charts.OrdinalComboChart(
        series,
        animate: true,
        defaultRenderer: charts.BarRendererConfig(),
        customSeriesRenderers: [
          charts.LineRendererConfig(customRendererId: 'linea'),
          charts.PointRendererConfig(customRendererId: 'puntos'),
        ],
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}

/// Barra flotante: va de [desde] a [hasta] sobre el eje de medida.
class _BarraFlotanteCc {
  final String etiqueta;
  final double desde;
  final double hasta;
  final int color;
  final String texto;
  const _BarraFlotanteCc(
      this.etiqueta, this.desde, this.hasta, this.color, this.texto);
}
 
/// Tarea de un cronograma, en semanas.
class _TareaCc {
  final String nombre;
  final int inicio;
  final int fin;
  const _TareaCc(this.nombre, this.inicio, this.fin);
}
 
/// 21. Cascada (waterfall).
/// Barras flotantes: measureOffsetFn fija donde empieza cada barra y
/// measureFn su longitud, asi cada paso arranca donde termino el anterior.
class CcCascada extends StatelessWidget {
  const CcCascada({super.key});
  @override
  Widget build(BuildContext context) {
    final pasos = DatosMock.cascada; // valores con signo
    final filas = <_BarraFlotanteCc>[];
    double acum = 0;
    for (final p in pasos) {
      final desde = acum;
      acum += p.valor;
      filas.add(_BarraFlotanteCc(
        p.categoria,
        math.min(desde, acum),
        math.max(desde, acum),
        p.valor >= 0 ? 2 : 1,
        '${p.valor >= 0 ? '+' : ''}${p.valor.toStringAsFixed(0)}',
      ));
    }
    filas.add(_BarraFlotanteCc('Total', 0, acum, 0, acum.toStringAsFixed(0)));
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<_BarraFlotanteCc, String>(
        id: 'Cascada',
        domainFn: (f, _) => f.etiqueta,
        measureFn: (f, _) => f.hasta - f.desde,
        measureOffsetFn: (f, _) => f.desde,
        colorFn: (f, _) => _color(f.color),
        labelAccessorFn: (f, _) => f.texto,
        data: filas,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Cascada',
      paraQue:
          'Barras flotantes encadenadas: cada una empieza donde termino la '
          'anterior, mostrando como sumas (verde) y restas (naranja) '
          'llevan de un inicio a un total.',
      cuando:
          'Para explicar como se llega a un resultado paso a paso: de '
          'ingreso bruto a utilidad neta, de saldo inicial a final.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        barRendererDecorator: charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.outside,
        ),
      ),
    );
  }
}
 
/// 22. Barras + marcador de promedio (linea objetivo).
/// Combina barras con BarTargetLineRenderer: una marca horizontal sobre
/// cada barra, que aqui indica el promedio de los tres productos.
class CcBarrasMarcador extends StatelessWidget {
  const CcBarrasMarcador({super.key});
  @override
  Widget build(BuildContext context) {
    final m = DatosMock.seriesMultiples;
    final barras = m[0].puntos;
    final promedio = <PuntoCategoria>[
      for (int i = 0; i < barras.length; i++)
        PuntoCategoria(
          barras[i].categoria,
          m.fold<double>(0, (s, se) => s + se.puntos[i].valor) / m.length,
        ),
    ];
    final series = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: m[0].nombre,
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: barras,
      ),
      charts.Series<PuntoCategoria, String>(
        id: 'Promedio del grupo',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => charts.MaterialPalette.black,
        data: promedio,
      )..setAttribute(charts.rendererIdKey, 'meta'),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras + marcador',
      paraQue:
          'Cada barra lleva encima una marca horizontal con un valor de '
          'referencia (aqui, el promedio de los tres productos): se ve de '
          'un vistazo quien queda por encima o por debajo.',
      cuando:
          'Para comparar cada periodo contra su propia meta o referencia, '
          'distinta en cada columna: cuota mensual, plan por trimestre.',
      grafica: charts.OrdinalComboChart(
        series,
        animate: true,
        defaultRenderer: charts.BarRendererConfig<String>(),
        customSeriesRenderers: [
          charts.BarTargetLineRendererConfig<String>(
            customRendererId: 'meta',
            strokeWidthPx: 4,
            overDrawPx: 6,
          ),
        ],
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}
 
/// 23. Velas japonesas.
/// community_charts no trae candlestick: se arma con dos renderers de
/// barras sobre el mismo dominio. El cuerpo (apertura-cierre) es una barra
/// flotante ancha y la mecha (bajo-alto) otra muy delgada.
class CcVelas extends StatelessWidget {
  const CcVelas({super.key});
  @override
  Widget build(BuildContext context) {
    final velas = DatosMock.velas.take(12).toList();
    final minimo = velas.map((v) => v.bajo).reduce((a, b) => a < b ? a : b);
    final maximo = velas.map((v) => v.alto).reduce((a, b) => a > b ? a : b);
    String dia(Vela v) => '${v.fecha.day}/${v.fecha.month}';
    bool sube(Vela v) => v.cierre >= v.apertura;
    final series = <charts.Series<dynamic, String>>[
      charts.Series<Vela, String>(
        id: 'Cuerpo',
        domainFn: (v, _) => dia(v),
        measureFn: (v, _) => (v.cierre - v.apertura).abs(),
        measureOffsetFn: (v, _) => math.min(v.apertura, v.cierre),
        colorFn: (v, _) => sube(v) ? _color(2) : _color(1),
        data: velas,
      ),
      charts.Series<Vela, String>(
        id: 'Mecha',
        domainFn: (v, _) => dia(v),
        measureFn: (v, _) => v.alto - v.bajo,
        measureOffsetFn: (v, _) => v.bajo,
        colorFn: (v, _) => sube(v) ? _color(2) : _color(1),
        data: velas,
      )..setAttribute(charts.rendererIdKey, 'mecha'),
    ];
    return LienzoDescrito(
      titulo: 'community · Velas',
      paraQue:
          'Cada vela resume un periodo: el cuerpo ancho va de apertura a '
          'cierre (verde si sube, naranja si baja) y la mecha fina llega '
          'hasta el maximo y el minimo.',
      cuando:
          'Para datos bursatiles o de mercado donde importan los cuatro '
          'valores del periodo y la direccion en que cerro.',
      grafica: charts.OrdinalComboChart(
        series,
        animate: true,
        defaultRenderer: charts.BarRendererConfig<String>(
          maxBarWidthPx: 14,
          minBarLengthPx: 2,
        ),
        customSeriesRenderers: [
          charts.BarRendererConfig<String>(
            customRendererId: 'mecha',
            maxBarWidthPx: 2,
          ),
        ],
        // El eje de medida solo incluye (offset + medida), es decir, los
        // maximos; se fija el rango a mano para que entren los minimos.
        primaryMeasureAxis: charts.NumericAxisSpec(
          viewport: charts.NumericExtents(minimo - 5, maximo + 5),
        ),
      ),
    );
  }
}
 
/// 24. Serie con banda de +/- 1 desviacion (ventana movil).
/// La banda es un area apilada: una serie base transparente (el limite
/// inferior) y encima otra con el ancho de la banda, coloreada.
class CcBandaDesviacion extends StatelessWidget {
  const CcBandaDesviacion({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    const ventana = 5;
    final base = <PuntoTemporal>[];
    final banda = <PuntoTemporal>[];
    for (int i = 0; i < datos.length; i++) {
      final desde = math.max(0, i - ventana + 1);
      final tramo = datos.sublist(desde, i + 1).map((p) => p.valor).toList();
      final mu = tramo.reduce((a, b) => a + b) / tramo.length;
      final sd = math.sqrt(
          tramo.fold<double>(0, (s, x) => s + (x - mu) * (x - mu)) /
              tramo.length);
      final inferior = math.max(0.0, mu - sd);
      base.add(PuntoTemporal(datos[i].fecha, inferior));
      banda.add(PuntoTemporal(datos[i].fecha, (mu + sd) - inferior));
    }
    final series = <charts.Series<dynamic, DateTime>>[
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Limite inferior',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => charts.Color.transparent,
        data: base,
      ),
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Banda',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0).lighter,
        data: banda,
      ),
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Valor',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: datos,
      )..setAttribute(charts.rendererIdKey, 'linea'),
    ];
    return LienzoDescrito(
      titulo: 'community · Banda de desviacion',
      paraQue:
          'La serie sobre una franja que cubre el promedio movil de 5 dias '
          'mas/menos una desviacion estandar: se ensancha cuando los datos '
          'son erraticos y se estrecha cuando son estables.',
      cuando:
          'Para ver la volatilidad ademas del nivel: detectar cuando una '
          'metrica se vuelve inestable o sale de su comportamiento normal.',
      grafica: charts.TimeSeriesChart(
        series,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          includeArea: true,
          stacked: true,
          areaOpacity: 0.3,
        ),
        customSeriesRenderers: [
          charts.LineRendererConfig(customRendererId: 'linea'),
        ],
      ),
    );
  }
}
 
/// 25. Serie con maximo y minimo anotados.
/// Dos lineas verticales sobre el eje de dominio (fechas), ubicadas en el
/// dia del valor mas alto y del mas bajo, con su etiqueta.
class CcMaxMinAnotados extends StatelessWidget {
  const CcMaxMinAnotados({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    var iMax = 0;
    var iMin = 0;
    for (int i = 1; i < datos.length; i++) {
      if (datos[i].valor > datos[iMax].valor) iMax = i;
      if (datos[i].valor < datos[iMin].valor) iMin = i;
    }
    final serie = <charts.Series<dynamic, DateTime>>[
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Indicador',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: datos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Maximo y minimo',
      paraQue:
          'Marca con una linea vertical y una etiqueta el dia del valor '
          'mas alto (verde) y del mas bajo (naranja) de la serie, calculados '
          'a partir de los propios datos.',
      cuando:
          'Para destacar los extremos de un historico sin obligar a '
          'buscarlos: picos de demanda, minimos de inventario, record de '
          'temperatura.',
      grafica: charts.TimeSeriesChart(
        serie,
        animate: true,
        behaviors: [
          charts.RangeAnnotation([
            charts.LineAnnotationSegment(
              datos[iMax].fecha,
              charts.RangeAnnotationAxisType.domain,
              endLabel: 'Max ${datos[iMax].valor.toStringAsFixed(0)}',
              color: _color(2),
              strokeWidthPx: 2,
            ),
            charts.LineAnnotationSegment(
              datos[iMin].fecha,
              charts.RangeAnnotationAxisType.domain,
              endLabel: 'Min ${datos[iMin].valor.toStringAsFixed(0)}',
              color: _color(1),
              strokeWidthPx: 2,
            ),
          ]),
        ],
      ),
    );
  }
}
 
/// 26. Lineas con leyenda de valores al tocar.
/// La leyenda muestra el valor de cada serie en el punto tocado (y el
/// ultimo valor mientras no haya seleccion).
class CcLeyendaMedidas extends StatelessWidget {
  const CcLeyendaMedidas({super.key});
  @override
  Widget build(BuildContext context) {
    final series = <charts.Series<dynamic, num>>[];
    for (int s = 0; s < DatosMock.seriesMultiples.length; s++) {
      final sn = DatosMock.seriesMultiples[s];
      series.add(charts.Series<PuntoCategoria, num>(
        id: sn.nombre,
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(s),
        data: sn.puntos,
      ));
    }
    return LienzoDescrito(
      titulo: 'community · Leyenda con valores',
      paraQue:
          'Al tocar o arrastrar sobre la grafica, la leyenda cambia y '
          'muestra el valor exacto de cada serie en ese punto.',
      cuando:
          'Cuando hay varias series y se quiere leer sus valores a la vez '
          'en un mismo instante, sin llenar la grafica de etiquetas.',
      grafica: charts.LineChart(
        series,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(includePoints: true),
        behaviors: [
          charts.SeriesLegend(
            position: charts.BehaviorPosition.top,
            showMeasures: true,
            legendDefaultMeasure: charts.LegendDefaultMeasure.lastValue,
            measureFormatter: (num? v) =>
                v == null ? '-' : v.toStringAsFixed(0),
          ),
          charts.LinePointHighlighter(),
          charts.SelectNearest(
            eventTrigger: charts.SelectionTrigger.tapAndDrag,
          ),
        ],
      ),
    );
  }
}
 
/// 27. Barras con panel de detalle externo.
/// Un SelectionModelConfig avisa al State de la barra tocada y este
/// actualiza una tarjeta fuera de la grafica.
class CcBarrasDetalle extends StatefulWidget {
  const CcBarrasDetalle({super.key});
  @override
  State<CcBarrasDetalle> createState() => _CcBarrasDetalleState();
}
 
class _CcBarrasDetalleState extends State<CcBarrasDetalle> {
  PuntoCategoria? _sel;
 
  void _alSeleccionar(charts.SelectionModel<String> modelo) {
    if (!modelo.hasDatumSelection) return;
    final d = modelo.selectedDatum.first.datum as PuntoCategoria;
    // Se difiere al siguiente frame: el callback puede dispararse mientras
    // el chart se esta construyendo.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _sel = d);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.ventasMensuales;
    final total = datos.fold<double>(0, (s, p) => s + p.valor);
    final esquema = Theme.of(context).colorScheme;
    final sel = _sel;
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Ventas',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, _) => identical(p, sel) ? _color(1) : _color(0),
        data: datos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras con detalle',
      paraQue:
          'Al tocar una barra, un panel fuera de la grafica muestra su '
          'valor y que porcentaje del total representa; la barra elegida '
          'cambia de color.',
      cuando:
          'Cuando el detalle de un elemento necesita mas espacio del que '
          'cabe en una etiqueta: fichas, tarjetas o paneles laterales.',
      grafica: Column(
        children: [
          Expanded(
            child: charts.BarChart(
              serie,
              animate: false,
              behaviors: [charts.SelectNearest()],
              selectionModels: [
                charts.SelectionModelConfig<String>(
                  changedListener: _alSeleccionar,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: esquema.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              sel == null
                  ? 'Toca una barra para ver su detalle'
                  : '${sel.categoria}: ${sel.valor.toStringAsFixed(0)} '
                      '(${(sel.valor / total * 100).toStringAsFixed(1)} % '
                      'del total de ${total.toStringAsFixed(0)})',
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 28. Linea con control deslizante (Slider).
/// Un Slider real: una linea vertical con asa que se arrastra por la
/// grafica y reporta el dominio donde queda.
class CcSliderLinea extends StatefulWidget {
  const CcSliderLinea({super.key});
  @override
  State<CcSliderLinea> createState() => _CcSliderLineaState();
}
 
class _CcSliderLineaState extends State<CcSliderLinea> {
  int _indice = 15;
 
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    final esquema = Theme.of(context).colorScheme;
    final i = _indice.clamp(0, datos.length - 1);
    final serie = <charts.Series<dynamic, num>>[
      charts.Series<PuntoTemporal, num>(
        id: 'Serie',
        domainFn: (p, idx) => idx ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(3),
        data: datos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Slider',
      paraQue:
          'Una linea vertical con asa que se arrastra a lo largo de la '
          'grafica; al soltarla en cualquier punto se lee el valor de la '
          'serie en ese dia.',
      cuando:
          'Para explorar una serie larga con el dedo y consultar el valor '
          'de un instante concreto, o para fijar un punto de corte.',
      grafica: Column(
        children: [
          Expanded(
            child: charts.LineChart(
              serie,
              animate: false,
              behaviors: [
                charts.Slider(
                  initialDomainValue: _indice,
                  snapToDatum: true,
                  onChangeCallback: (punto, dominio, rol, estado) {
                    if (dominio == null) return;
                    final nuevo = (dominio as num).round();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) setState(() => _indice = nuevo);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: esquema.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('Dia ${i + 1}: ${datos[i].valor.toStringAsFixed(1)}'),
          ),
        ],
      ),
    );
  }
}
 
/// 29. Dona con total al centro y seleccion.
/// El centro muestra el total y, al tocar una porcion, cambia a la
/// categoria elegida.
class CcDonaTotalCentro extends StatefulWidget {
  const CcDonaTotalCentro({super.key});
  @override
  State<CcDonaTotalCentro> createState() => _CcDonaTotalCentroState();
}
 
class _CcDonaTotalCentroState extends State<CcDonaTotalCentro> {
  PuntoCategoria? _sel;
 
  void _alSeleccionar(charts.SelectionModel<String> modelo) {
    if (!modelo.hasDatumSelection) return;
    final d = modelo.selectedDatum.first.datum as PuntoCategoria;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _sel = d);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cuotaMercado;
    final total = datos.fold<double>(0, (s, p) => s + p.valor);
    final sel = _sel;
    final serie = <charts.Series<PuntoCategoria, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Cuota',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, i) => _color(i ?? 0),
        data: datos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Dona con total al centro',
      paraQue:
          'Una dona que muestra el total en su centro; al tocar una '
          'porcion, el centro pasa a mostrar la categoria y su valor.',
      cuando:
          'En tableros compactos donde el hueco central se aprovecha como '
          'indicador: totales, porcentajes y detalle bajo demanda.',
      grafica: Stack(
        alignment: Alignment.center,
        children: [
          charts.PieChart<String>(
            serie,
            animate: false,
            defaultRenderer: charts.ArcRendererConfig<String>(arcWidth: 45),
            behaviors: [charts.SelectNearest()],
            selectionModels: [
              charts.SelectionModelConfig<String>(
                changedListener: _alSeleccionar,
              ),
            ],
          ),
          IgnorePointer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  sel == null ? 'Total' : sel.categoria,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  sel == null
                      ? '${total.toStringAsFixed(0)} %'
                      : '${sel.valor.toStringAsFixed(0)} %',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 
/// 30. Barras + linea con doble eje de medida.
/// Las barras (ventas) usan el eje izquierdo y la linea (variacion
/// porcentual mensual) usa un segundo eje de medida a la derecha.
class CcDobleEje extends StatelessWidget {
  const CcDobleEje({super.key});
  @override
  Widget build(BuildContext context) {
    final v = DatosMock.ventasMensuales;
    final variacion = <PuntoCategoria>[
      for (int i = 1; i < v.length; i++)
        PuntoCategoria(
          v[i].categoria,
          (v[i].valor - v[i - 1].valor) / v[i - 1].valor * 100,
        ),
    ];
    final series = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Ventas (izq.)',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: v,
      ),
      charts.Series<PuntoCategoria, String>(
        id: 'Variacion % (der.)',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(1),
        data: variacion,
      )
        ..setAttribute(charts.rendererIdKey, 'linea')
        ..setAttribute(
            charts.measureAxisIdKey, charts.Axis.secondaryMeasureAxisId),
    ];
    return LienzoDescrito(
      titulo: 'community · Doble eje',
      paraQue:
          'Dos series de unidades distintas en una misma grafica: las '
          'barras se leen en el eje izquierdo y la linea en un segundo eje '
          'a la derecha, con su propia escala.',
      cuando:
          'Cuando se relacionan una magnitud y su cambio relativo: ventas '
          'y crecimiento mensual, produccion y rendimiento.',
      grafica: charts.OrdinalComboChart(
        series,
        animate: true,
        defaultRenderer: charts.BarRendererConfig<String>(),
        customSeriesRenderers: [
          charts.LineRendererConfig(
            customRendererId: 'linea',
            includePoints: true,
          ),
        ],
        secondaryMeasureAxis: charts.NumericAxisSpec(
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec(
            (num? valor) => valor == null ? '' : '${valor.toInt()}%',
          ),
        ),
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}
 
/// 31. Gantt (barras flotantes horizontales) con linea de "hoy".
/// Cada tarea es una barra horizontal de inicio a fin; una linea vertical
/// marca la semana actual.
class CcGantt extends StatelessWidget {
  const CcGantt({super.key});
  @override
  Widget build(BuildContext context) {
    // Mismas tareas que el Gantt de fl_chart (semanas 0-12).
    const tareas = [
      _TareaCc('Analisis', 0, 3),
      _TareaCc('Diseno', 2, 6),
      _TareaCc('Desarrollo', 5, 10),
      _TareaCc('Pruebas', 8, 12),
      _TareaCc('Entrega', 11, 12),
    ];
    // Semana actual de ejemplo para la linea "hoy".
    const semanaActual = 6;
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<_TareaCc, String>(
        id: 'Cronograma',
        domainFn: (t, _) => t.nombre,
        measureFn: (t, _) => t.fin - t.inicio,
        measureOffsetFn: (t, _) => t.inicio,
        colorFn: (t, i) => _color(i ?? 0),
        labelAccessorFn: (t, _) => 'sem ${t.inicio}-${t.fin}',
        data: tareas,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Gantt',
      paraQue:
          'Cada barra horizontal va del inicio al fin de una tarea, '
          'mostrando su duracion y como se solapan; una linea vertical '
          'marca la semana actual.',
      cuando:
          'Para planificar y seguir proyectos: cronogramas, fases de '
          'trabajo, calendarios de tareas con solapamientos.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        vertical: false,
        // En barras horizontales la primera categoria queda abajo; se
        // invierte para que el cronograma se lea de arriba hacia abajo.
        flipVerticalAxis: true,
        primaryMeasureAxis: charts.NumericAxisSpec(
          viewport: charts.NumericExtents(0, 12),
        ),
        barRendererDecorator: charts.BarLabelDecorator<String>(),
        behaviors: [
          charts.RangeAnnotation([
            charts.LineAnnotationSegment(
              semanaActual,
              charts.RangeAnnotationAxisType.measure,
              endLabel: 'Hoy',
              color: charts.MaterialPalette.red.shadeDefault,
              strokeWidthPx: 2,
            ),
          ]),
        ],
      ),
    );
  }
}
 
/// 32. Mancuernas (dumbbell) — comparacion entre dos series.
/// Dos puntos por trimestre (producto A y B) unidos por un segmento; el
/// largo del segmento es la diferencia entre ambos.
class CcMancuernas extends StatelessWidget {
  const CcMancuernas({super.key});
  @override
  Widget build(BuildContext context) {
    final a = DatosMock.seriesMultiples[0].puntos;
    final b = DatosMock.seriesMultiples[1].puntos;
    final series = <charts.Series<dynamic, num>>[
      // Esta serie lleva los limites que dibuja el decorador: el segmento
      // va entre el menor y el mayor de los dos valores del periodo.
      charts.Series<PuntoCategoria, num>(
        id: 'Producto A',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        domainLowerBoundFn: (p, i) => i ?? 0,
        domainUpperBoundFn: (p, i) => i ?? 0,
        measureLowerBoundFn: (p, i) => math.min(a[i!].valor, b[i].valor),
        measureUpperBoundFn: (p, i) => math.max(a[i!].valor, b[i].valor),
        colorFn: (_, __) => _color(0),
        data: a,
      ),
      charts.Series<PuntoCategoria, num>(
        id: 'Producto B',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(1),
        data: b,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Mancuernas',
      paraQue:
          'Dos puntos por periodo unidos por un segmento: el largo del '
          'segmento es la diferencia entre las dos series y su posicion '
          'muestra cual va por encima.',
      cuando:
          'Para comparar dos mediciones del mismo elemento: antes y '
          'despues, real y plan, un producto frente a otro.',
      grafica: charts.ScatterPlotChart(
        series,
        animate: true,
        defaultRenderer: charts.PointRendererConfig<num>(
          radiusPx: 6,
          boundsLineRadiusPx: 3,
          pointRendererDecorators: [
            charts.ComparisonPointsDecorator<num>(
              symbolRenderer: charts.CylinderSymbolRenderer(),
            ),
          ],
        ),
        domainAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.StaticNumericTickProviderSpec(
            <charts.TickSpec<num>>[
              for (int i = 0; i < a.length; i++)
                charts.TickSpec<num>(i, label: a[i].categoria),
            ],
          ),
          viewport: charts.NumericExtents(-0.5, a.length - 0.5),
        ),
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}
 