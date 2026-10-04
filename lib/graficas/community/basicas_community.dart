import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../core/lienzo_descrito.dart';
import '../../mock/datos_mock.dart';

// ============================================================
// community_charts — 20 GRAFICAS BASICAS
// Las 10 primeras son los tipos fundamentales. Las 10 siguientes son
// COMBINACIONES. Fork de Google Charts, nativo en Dart. Modelo por
// Series: domainFn (X), measureFn (Y), data. Las listas de series se
// tipan <dynamic, DOMINIO> porque los widgets lo exigen; PieChart
// necesita el tipo concreto <String>. Todas con su explicacion.
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
// PARTE 1 — LOS 10 TIPOS FUNDAMENTALES (ahora con descripcion)
// ============================================================

/// 1. Barras verticales.
class CcBarras extends StatelessWidget {
  const CcBarras({super.key});
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
      titulo: 'community · Barras',
      paraQue:
          'Compara cantidades entre categorias con la altura de cada barra. '
          'Usa el estilo Material de Google, limpio y animado.',
      cuando:
          'Para comparar valores de categorias independientes: ventas por '
          'mes, cantidades por grupo, conteos por tipo.',
      grafica: charts.BarChart(serie, animate: true),
    );
  }
}

/// 2. Barras con etiquetas de dato.
class CcBarrasEtiquetas extends StatelessWidget {
  const CcBarrasEtiquetas({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Ventas',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(1),
        labelAccessorFn: (p, _) => p.valor.toStringAsFixed(0),
        data: DatosMock.ventasMensuales,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras con etiquetas',
      paraQue:
          'Barras que muestran su valor numerico impreso dentro o encima, '
          'uniendo la comparacion visual con la cifra exacta.',
      cuando:
          'Cuando el valor preciso importa ademas de la comparacion: '
          'informes, tableros donde se consultan cifras concretas.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        barRendererDecorator: charts.BarLabelDecorator<String>(),
      ),
    );
  }
}

/// 3. Lineas con puntos.
class CcLineasPuntos extends StatelessWidget {
  const CcLineasPuntos({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, int>>[
      charts.Series<PuntoTemporal, int>(
        id: 'Serie',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: DatosMock.serieTemporal,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Lineas con puntos',
      paraQue:
          'Una linea de tendencia con un punto marcado en cada dato, uniendo '
          'la vista continua con la ubicacion exacta de cada medicion.',
      cuando:
          'Para series con pocos puntos donde cada medicion cuenta: '
          'resultados por periodo, lecturas espaciadas en el tiempo.',
      grafica: charts.LineChart(
        serie,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(includePoints: true),
      ),
    );
  }
}

/// 4. Lineas con relleno de area.
class CcLineaArea extends StatelessWidget {
  const CcLineaArea({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, int>>[
      charts.Series<PuntoTemporal, int>(
        id: 'Serie',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(2),
        areaColorFn: (_, __) => _color(2).lighter,
        data: DatosMock.serieTemporal,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Linea con area',
      paraQue:
          'Una linea con el espacio inferior relleno, para enfatizar el '
          'volumen bajo la curva ademas de la tendencia.',
      cuando:
          'Cuando ademas de la evolucion importa el volumen acumulado: '
          'consumo, trafico, cantidades a lo largo del tiempo.',
      grafica: charts.LineChart(
        serie,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(includeArea: true),
      ),
    );
  }
}

/// 5. Serie de tiempo.
class CcSerieTiempo extends StatelessWidget {
  const CcSerieTiempo({super.key});
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
    return LienzoDescrito(
      titulo: 'community · Serie de tiempo',
      paraQue:
          'Un grafico especializado en fechas reales en el eje X, que rotula '
          'los dias y meses de forma inteligente.',
      cuando:
          'Cuando el eje X son fechas concretas y se quiere que la libreria '
          'maneje la escala temporal: historicos, bitacoras, mediciones.',
      grafica: charts.TimeSeriesChart(serie, animate: true),
    );
  }
}

/// 6. Dispersion.
class CcDispersion extends StatelessWidget {
  const CcDispersion({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, num>>[
      charts.Series<PuntoXY, num>(
        id: 'Puntos',
        domainFn: (p, _) => p.x,
        measureFn: (p, _) => p.y,
        colorFn: (_, __) => _color(3),
        radiusPxFn: (p, _) => p.tamano / 2,
        data: DatosMock.dispersion,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Dispersion',
      paraQue:
          'Ubica puntos segun dos variables numericas, revelando la relacion '
          'o agrupamiento entre ellas.',
      cuando:
          'Para analizar correlacion entre dos medidas: dos indicadores '
          'relacionados, mediciones de dos sensores.',
      grafica: charts.ScatterPlotChart(serie, animate: true),
    );
  }
}

/// 7. Barras agrupadas por serie.
class CcBarrasAgrupadas extends StatelessWidget {
  const CcBarrasAgrupadas({super.key});
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
      titulo: 'community · Barras agrupadas',
      paraQue:
          'Varias barras juntas por categoria, para comparar varias series '
          'dentro de cada periodo.',
      cuando:
          'Cuando se comparan varios elementos en cada categoria: productos '
          'por trimestre, regiones por ano.',
      grafica: charts.BarChart(
        series,
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
      ),
    );
  }
}

/// 8. Pastel.
class CcPastel extends StatelessWidget {
  const CcPastel({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Cuota',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, i) => _color(i ?? 0),
        data: DatosMock.cuotaMercado,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Pastel',
      paraQue:
          'Divide un total en porciones para mostrar la proporcion de cada '
          'categoria sobre el conjunto.',
      cuando:
          'Cuando el mensaje es el reparto porcentual y hay pocas '
          'categorias.',
      grafica: charts.PieChart<String>(serie, animate: true),
    );
  }
}

/// 9. Dona.
class CcDona extends StatelessWidget {
  const CcDona({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<PuntoCategoria, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Cuota',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, i) => _color(i ?? 0),
        labelAccessorFn: (p, _) => '${p.valor.toStringAsFixed(0)}%',
        data: DatosMock.cuotaMercado,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Dona',
      paraQue:
          'Un pastel con hueco central y el porcentaje de cada porcion '
          'rotulado sobre el anillo.',
      cuando:
          'La misma lectura de proporcion que el pastel, con estilo mas '
          'moderno y espacio central libre.',
      grafica: charts.PieChart<String>(
        serie,
        animate: true,
        defaultRenderer: charts.ArcRendererConfig<String>(
          arcRatio: 0.5,
          arcRendererDecorators: [charts.ArcLabelDecorator<String>()],
        ),
      ),
    );
  }
}

/// 10. Lineas escalonadas (step line).
class CcStepLine extends StatelessWidget {
  const CcStepLine({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, num>>[
      charts.Series<PuntoCategoria, num>(
        id: 'Ventas',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(4),
        data: DatosMock.ventasMensuales,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Step line',
      paraQue:
          'Una linea que avanza en escalones en vez de diagonales, mostrando '
          'que el valor se mantiene constante hasta el siguiente cambio.',
      cuando:
          'Para valores que cambian en saltos discretos: tarifas por tramos, '
          'niveles de inventario, estados que se mantienen entre eventos.',
      grafica: charts.LineChart(
        serie,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          includePoints: true,
          roundEndCaps: false,
        ),
      ),
    );
  }
}

/// 11. Lineas + puntos + area (tres renderers en una serie).
class CcLineaPuntoArea extends StatelessWidget {
  const CcLineaPuntoArea({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, int>>[
      charts.Series<PuntoTemporal, int>(
        id: 'Serie',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: DatosMock.serieTemporal,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Linea + puntos + area',
      paraQue:
          'Combina tres capas en una sola serie: la linea (tendencia), los '
          'puntos (dato exacto) y el area (volumen), todo a la vez.',
      cuando:
          'Cuando una sola serie debe comunicar tendencia, valores puntuales '
          'y magnitud acumulada sin recurrir a tres graficas separadas.',
      grafica: charts.LineChart(
        serie,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          includePoints: true,
          includeArea: true,
          radiusPx: 4,
        ),
      ),
    );
  }
}

/// 12. Barras apiladas + total.
class CcApiladasTotal extends StatelessWidget {
  const CcApiladasTotal({super.key});
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
        // La ultima serie lleva etiqueta con el total de la columna.
        labelAccessorFn: s == DatosMock.seriesMultiples.length - 1
            ? (p, i) {
                final t = DatosMock.seriesMultiples
                    .fold<double>(0, (acc, se) => acc + se.puntos[i!].valor);
                return t.toStringAsFixed(0);
              }
            : null,
        data: sn.puntos,
      ));
    }
    return LienzoDescrito(
      titulo: 'community · Apiladas + total',
      paraQue:
          'Barras apiladas que ademas muestran el total de cada columna '
          'rotulado arriba, uniendo composicion y suma.',
      cuando:
          'Cuando interesan a la vez el aporte de cada parte y el total de '
          'cada periodo: ingresos por canal con el total mensual.',
      grafica: charts.BarChart(
        series,
        animate: true,
        barGroupingType: charts.BarGroupingType.stacked,
        barRendererDecorator: charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.outside,
        ),
      ),
    );
  }
}

/// 13. Serie de tiempo + banda de area.
class CcTiempoBanda extends StatelessWidget {
  const CcTiempoBanda({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, DateTime>>[
      charts.Series<PuntoTemporal, DateTime>(
        id: 'Indicador',
        domainFn: (p, _) => p.fecha,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        areaColorFn: (_, __) => _color(0).lighter,
        data: DatosMock.serieTemporal,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Tiempo + banda',
      paraQue:
          'Una serie temporal con area rellena y puntos marcados, combinando '
          'el manejo inteligente de fechas con la lectura de volumen.',
      cuando:
          'Para historicos donde importa tanto la fecha exacta como el '
          'volumen acumulado: evolucion de metricas con contexto temporal.',
      grafica: charts.TimeSeriesChart(
        serie,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          includeArea: true,
          includePoints: true,
          radiusPx: 3,
        ),
      ),
    );
  }
}

/// 14. Dispersion por tamano y color (4 datos por punto).
class CcDispersionTamColor extends StatelessWidget {
  const CcDispersionTamColor({super.key});
  @override
  Widget build(BuildContext context) {
    // Dos grupos segun la Y, cada uno con su color; el tamano es la 3a var.
    final altos =
        DatosMock.dispersion.where((p) => p.y > 50).toList();
    final bajos =
        DatosMock.dispersion.where((p) => p.y <= 50).toList();
    final series = <charts.Series<dynamic, num>>[
      charts.Series<PuntoXY, num>(
        id: 'Altos',
        domainFn: (p, _) => p.x,
        measureFn: (p, _) => p.y,
        colorFn: (_, __) => _color(0),
        radiusPxFn: (p, _) => p.tamano / 2,
        data: altos,
      ),
      charts.Series<PuntoXY, num>(
        id: 'Bajos',
        domainFn: (p, _) => p.x,
        measureFn: (p, _) => p.y,
        colorFn: (_, __) => _color(1),
        radiusPxFn: (p, _) => p.tamano / 2,
        data: bajos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Dispersion 4D',
      paraQue:
          'Cada punto codifica cuatro datos: posicion X, posicion Y, tamano '
          'de la burbuja y color del grupo al que pertenece.',
      cuando:
          'Para analisis multivariable: comparar elementos por dos ejes, su '
          'peso (tamano) y su categoria (color), todo en un plano.',
      grafica: charts.ScatterPlotChart(series, animate: true),
    );
  }
}

/// 15. Piramide tornado (dos grupos en direcciones opuestas).
class CcTornado extends StatelessWidget {
  const CcTornado({super.key});
  @override
  Widget build(BuildContext context) {
    // Una serie con valores negativos (izquierda) y otra positiva (derecha).
    final cats = DatosMock.seriesMultiples.first.puntos;
    final izq = DatosMock.seriesMultiples[0].puntos;
    final der = DatosMock.seriesMultiples[1].puntos;
    final series = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Grupo A',
        domainFn: (p, i) => cats[i!].categoria,
        measureFn: (p, i) => -izq[i!].valor, // negativo: va a la izquierda
        colorFn: (_, __) => _color(0),
        data: izq,
      ),
      charts.Series<PuntoCategoria, String>(
        id: 'Grupo B',
        domainFn: (p, i) => cats[i!].categoria,
        measureFn: (p, i) => der[i!].valor, // positivo: va a la derecha
        colorFn: (_, __) => _color(1),
        data: der,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Piramide tornado',
      paraQue:
          'Dos grupos de barras horizontales que crecen en direcciones '
          'opuestas desde un eje central, para compararlos categoria a '
          'categoria.',
      cuando:
          'Para comparar dos poblaciones o escenarios por categoria: '
          'piramide de poblacion por edad, hombres vs mujeres, antes vs '
          'despues.',
      grafica: charts.BarChart(
        series,
        animate: true,
        vertical: false,
        barGroupingType: charts.BarGroupingType.stacked,
      ),
    );
  }
}

/// 16. Barras divergentes (positivas y negativas por color).
class CcDivergentes extends StatelessWidget {
  const CcDivergentes({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.cascada; // trae valores con signo
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Variacion',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, _) =>
            p.valor >= 0 ? _color(2) : _color(1),
        data: datos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras divergentes',
      paraQue:
          'Barras que crecen hacia arriba o hacia abajo de cero segun el '
          'signo, con color distinto para positivos y negativos.',
      cuando:
          'Para variaciones respecto a una linea base: ganancias y perdidas, '
          'desviaciones sobre un promedio, cambios porcentuales.',
      grafica: charts.BarChart(serie, animate: true),
    );
  }
}

/// 17. Dona concentrica (dos anillos).
class CcDonaConcentrica extends StatelessWidget {
  const CcDonaConcentrica({super.key});
  @override
  Widget build(BuildContext context) {
    final detalle = DatosMock.cuotaMercado;
    // Agrupacion interior: moviles vs resto.
    final moviles = detalle
        .where((p) => p.categoria == 'Android' || p.categoria == 'iOS')
        .fold<double>(0, (s, p) => s + p.valor);
    final otros = detalle.fold<double>(0, (s, p) => s + p.valor) - moviles;
    final grupos = [
      PuntoCategoria('Movil', moviles),
      PuntoCategoria('Otros', otros),
    ];
    final serieExt = <charts.Series<PuntoCategoria, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Detalle',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, i) => _color(i ?? 0),
        data: detalle,
      ),
    ];
    final serieInt = <charts.Series<PuntoCategoria, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Grupos',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, i) => _color((i ?? 0) + 2),
        data: grupos,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Dona concentrica',
      paraQue:
          'Dos anillos: el exterior detalla cada categoria y el interior las '
          'agrupa, mostrando el total y su desglose en dos niveles.',
      cuando:
          'Cuando los datos tienen jerarquia de dos niveles: categorias y '
          'subcategorias, grupos y elementos.',
      grafica: Stack(
        alignment: Alignment.center,
        children: [
          charts.PieChart<String>(
            serieExt,
            animate: true,
            defaultRenderer:
                charts.ArcRendererConfig<String>(arcRatio: 0.35),
          ),
          SizedBox(
            width: 150,
            height: 150,
            child: charts.PieChart<String>(
              serieInt,
              animate: true,
              defaultRenderer:
                  charts.ArcRendererConfig<String>(arcRatio: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

/// 18. Barras con promedio movil.
class CcBarrasPromedioMovil extends StatelessWidget {
  const CcBarrasPromedioMovil({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    // Promedio movil de ventana 3.
    final movil = <PuntoTemporal>[];
    for (int i = 0; i < datos.length; i++) {
      final desde = (i - 2).clamp(0, datos.length - 1);
      final ventana = datos.sublist(desde, i + 1);
      final prom =
          ventana.map((p) => p.valor).reduce((a, b) => a + b) / ventana.length;
      movil.add(PuntoTemporal(datos[i].fecha, prom));
    }
    final series = <charts.Series<dynamic, num>>[
      charts.Series<PuntoTemporal, num>(
        id: 'Valor',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: datos,
      )..setAttribute(charts.rendererIdKey, 'barras'),
      charts.Series<PuntoTemporal, num>(
        id: 'Promedio movil',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(1),
        data: movil,
      )..setAttribute(charts.rendererIdKey, 'linea'),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras + promedio movil',
      paraQue:
          'Barras con el valor de cada periodo y una linea de promedio movil '
          'calculada encima, que suaviza el ruido y revela la tendencia.',
      cuando:
          'Para series con mucha fluctuacion donde la tendencia real se '
          'pierde: ventas diarias, metricas volatiles, datos con ruido.',
      grafica: charts.NumericComboChart(
        series,
        animate: true,
        defaultRenderer: charts.BarRendererConfig(),
        customSeriesRenderers: [
          charts.LineRendererConfig(customRendererId: 'linea'),
        ],
      ),
    );
  }
}

/// 19. Mapa de burbujas en cuadricula.
class CcBurbujasGrid extends StatelessWidget {
  const CcBurbujasGrid({super.key});
  @override
  Widget build(BuildContext context) {
    // Celdas de la matriz 7x8 como puntos en grilla; tamano = intensidad.
    final celdas =
        DatosMock.matrizCalor.where((c) => c.x < 8).toList();
    final serie = <charts.Series<dynamic, num>>[
      charts.Series<CeldaCalor, num>(
        id: 'Actividad',
        domainFn: (c, _) => c.x,
        measureFn: (c, _) => c.y,
        colorFn: (c, _) => _color(0),
        radiusPxFn: (c, _) => 3 + c.intensidad / 100 * 12,
        data: celdas,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Burbujas en grilla',
      paraQue:
          'Burbujas ubicadas en una cuadricula de dos dimensiones '
          'categoricas, donde el tamano codifica la intensidad del cruce.',
      cuando:
          'Para ver intensidad en dos dimensiones: actividad por dia y hora, '
          'frecuencia por fila y columna, mapas de calor con burbujas.',
      grafica: charts.ScatterPlotChart(serie, animate: true),
    );
  }
}

/// 20. Area apilada temporal.
class CcAreaApiladaTiempo extends StatelessWidget {
  const CcAreaApiladaTiempo({super.key});
  @override
  Widget build(BuildContext context) {
    // Tres series temporales derivadas, apiladas como area.
    final base = DatosMock.serieTemporal;
    final series = <charts.Series<dynamic, int>>[];
    for (int s = 0; s < 3; s++) {
      series.add(charts.Series<PuntoTemporal, int>(
        id: 'Serie ${s + 1}',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor / (s + 1.5),
        colorFn: (_, __) => _color(s),
        data: base,
      ));
    }
    return LienzoDescrito(
      titulo: 'community · Area apilada temporal',
      paraQue:
          'Varias areas apiladas a lo largo del tiempo, mostrando el total '
          'acumulado y como cada serie contribuye en cada momento.',
      cuando:
          'Cuando interesa el volumen total en el tiempo y su composicion: '
          'trafico por fuente, ventas por canal, recursos por tipo.',
      grafica: charts.LineChart(
        series,
        animate: true,
        defaultRenderer:
            charts.LineRendererConfig(includeArea: true, stacked: true),
      ),
    );
  }
}

/// 21. Barras con color por umbral + linea de umbral.
/// Combina barras con etiquetas, color condicional y una anotacion de
/// linea sobre el eje de medida.
class CcBarrasUmbral extends StatelessWidget {
  const CcBarrasUmbral({super.key});
  @override
  Widget build(BuildContext context) {
    const umbral = 50.0;
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Ventas',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, _) => p.valor >= umbral ? _color(2) : _color(1),
        labelAccessorFn: (p, _) => p.valor.toStringAsFixed(0),
        data: DatosMock.ventasMensuales,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras por umbral',
      paraQue:
          'Barras que se pintan de verde si alcanzan el umbral y de naranja '
          'si no, con su valor impreso y una linea que marca el umbral.',
      cuando:
          'Para evaluar cada periodo contra un minimo exigido: ventas '
          'frente a la cuota, produccion frente al plan.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        barRendererDecorator: charts.BarLabelDecorator<String>(
          labelPosition: charts.BarLabelPosition.outside,
        ),
        behaviors: [
          charts.RangeAnnotation([
            charts.LineAnnotationSegment(
              umbral,
              charts.RangeAnnotationAxisType.measure,
              endLabel: 'Umbral ${umbral.toInt()}',
              color: charts.MaterialPalette.gray.shadeDefault,
            ),
          ]),
        ],
      ),
    );
  }
}
 
/// 22. Barras horizontales agrupadas.
/// Combina barras horizontales con agrupacion por serie y leyenda.
class CcBarrasHorizAgrupadas extends StatelessWidget {
  const CcBarrasHorizAgrupadas({super.key});
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
      titulo: 'community · Barras horizontales agrupadas',
      paraQue:
          'Varias barras tumbadas por categoria, una por serie, con leyenda '
          'que identifica cada color.',
      cuando:
          'Cuando hay varias series y las etiquetas de categoria son largas '
          'o numerosas: productos por region, indicadores por sucursal.',
      grafica: charts.BarChart(
        series,
        animate: true,
        vertical: false,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}
 
/// 23. Barras apiladas al 100 %.
/// Usa PercentInjector: la libreria convierte cada columna a proporcion
/// del total del dominio y el eje pasa a mostrar porcentajes.
class CcApiladas100 extends StatelessWidget {
  const CcApiladas100({super.key});
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
      titulo: 'community · Apiladas al 100 %',
      paraQue:
          'Barras apiladas donde todas las columnas miden lo mismo (100 %) y '
          'cada segmento muestra su proporcion, sin importar el total.',
      cuando:
          'Cuando importa la composicion y no el volumen: como cambia el '
          'peso de cada producto entre periodos.',
      grafica: charts.BarChart(
        series,
        animate: true,
        barGroupingType: charts.BarGroupingType.stacked,
        primaryMeasureAxis: charts.PercentAxisSpec(),
        behaviors: [
          charts.PercentInjector<String>(
            totalType: charts.PercentInjectorTotalType.domain,
          ),
          charts.SeriesLegend(),
        ],
      ),
    );
  }
}
 
/// 24. Barras agrupadas + apiladas.
/// Combina los dos modos de agrupacion: A y B se apilan en una columna y
/// C va en otra, lado a lado dentro de cada trimestre.
class CcAgrupadasApiladas extends StatelessWidget {
  const CcAgrupadasApiladas({super.key});
  @override
  Widget build(BuildContext context) {
    final series = <charts.Series<dynamic, String>>[];
    for (int s = 0; s < DatosMock.seriesMultiples.length; s++) {
      final sn = DatosMock.seriesMultiples[s];
      series.add(charts.Series<PuntoCategoria, String>(
        id: sn.nombre,
        // Las series con la misma categoria se apilan entre si; las de
        // categorias distintas quedan una al lado de la otra.
        seriesCategory: s < 2 ? 'Columna 1' : 'Columna 2',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(s),
        data: sn.puntos,
      ));
    }
    return LienzoDescrito(
      titulo: 'community · Agrupadas + apiladas',
      paraQue:
          'Cada periodo tiene dos columnas: una apila los productos A y B y '
          'la otra muestra el C, combinando agrupacion y apilado.',
      cuando:
          'Cuando unos elementos se suman entre si y otros se comparan '
          'aparte: ingresos propios apilados frente a un competidor.',
      grafica: charts.BarChart(
        series,
        animate: true,
        barGroupingType: charts.BarGroupingType.groupedStacked,
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}
 
/// 25. Pastel con etiquetas externas.
/// Combina el pastel con etiquetas fuera de cada porcion y lineas guia.
class CcPastelEtiquetasExternas extends StatelessWidget {
  const CcPastelEtiquetasExternas({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<PuntoCategoria, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Cuota',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (p, i) => _color(i ?? 0),
        labelAccessorFn: (p, _) =>
            '${p.categoria}: ${p.valor.toStringAsFixed(0)}%',
        data: DatosMock.cuotaMercado,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Pastel con etiquetas externas',
      paraQue:
          'Un pastel que rotula cada porcion fuera del circulo, con una '
          'linea guia hasta ella, para que el texto nunca se amontone.',
      cuando:
          'Cuando hay porciones pequenas cuyo texto no cabe dentro: '
          'categorias de 5 % o menos junto a otras muy grandes.',
      grafica: Padding(
        padding: const EdgeInsets.all(28),
        child: charts.PieChart<String>(
          serie,
          animate: true,
          defaultRenderer: charts.ArcRendererConfig<String>(
            arcRendererDecorators: [
              charts.ArcLabelDecorator<String>(
                labelPosition: charts.ArcLabelPosition.outside,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 
/// 26. Sparklines en tarjetas.
/// Tres mini-lineas sin ejes ni margenes, una por tramo de la serie,
/// cada una con su valor inicial, final y variacion.
class CcSparklines extends StatelessWidget {
  const CcSparklines({super.key});
 
  Widget _tarjeta(BuildContext context, String titulo,
      List<PuntoTemporal> datos, int color) {
    final esquema = Theme.of(context).colorScheme;
    final primero = datos.first.valor;
    final ultimo = datos.last.valor;
    final delta = ultimo - primero;
    final serie = <charts.Series<dynamic, num>>[
      charts.Series<PuntoTemporal, num>(
        id: titulo,
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(color),
        areaColorFn: (_, __) => _color(color).lighter,
        data: datos,
      ),
    ];
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
              child: charts.LineChart(
                serie,
                animate: false,
                defaultRenderer: charts.LineRendererConfig(includeArea: true),
                // Sin ejes, ni lineas de cuadricula, ni margenes.
                domainAxis: charts.NumericAxisSpec(
                  renderSpec: charts.NoneRenderSpec(),
                ),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  renderSpec: charts.NoneRenderSpec(),
                  tickProviderSpec:
                      charts.BasicNumericTickProviderSpec(zeroBound: false),
                ),
                layoutConfig: charts.LayoutConfig(
                  leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                  topMarginSpec: charts.MarginSpec.fixedPixel(0),
                  rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                  bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
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
    final d = DatosMock.serieTemporal;
    return LienzoDescrito(
      titulo: 'community · Sparklines',
      paraQue:
          'Mini-graficas de linea sin ejes que resumen la tendencia de un '
          'tramo en muy poco espacio, junto a su valor final y variacion.',
      cuando:
          'En tableros y listas donde se comparan muchas series a la vez y '
          'solo importa la forma: KPIs, monitores, tarjetas de resumen.',
      grafica: Column(
        children: [
          Expanded(
              child: _tarjeta(context, 'Dias 1-10', d.sublist(0, 10), 0)),
          Expanded(
              child: _tarjeta(context, 'Dias 11-20', d.sublist(10, 20), 1)),
          Expanded(
              child: _tarjeta(context, 'Dias 21-30', d.sublist(20, 30), 2)),
        ],
      ),
    );
  }
}
 
/// 27. Dispersion con formas por grupo.
/// Los puntos se agrupan por tamano y cada grupo usa un simbolo distinto
/// (circulo, cuadrado, circulo hueco), ademas del color.
class CcDispersionFormas extends StatelessWidget {
  const CcDispersionFormas({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.dispersion;
    final chicos = datos.where((p) => p.tamano < 12).toList();
    final medios =
        datos.where((p) => p.tamano >= 12 && p.tamano < 18).toList();
    final grandes = datos.where((p) => p.tamano >= 18).toList();
 
    charts.Series<PuntoXY, num> serie(
        String id, List<PuntoXY> d, int color, String? simbolo) {
      final s = charts.Series<PuntoXY, num>(
        id: id,
        domainFn: (p, _) => p.x,
        measureFn: (p, _) => p.y,
        colorFn: (_, __) => _color(color),
        radiusPxFn: (p, _) => p.tamano / 2,
        data: d,
      );
      // Sin simbolo: usa el circulo por defecto del renderer.
      if (simbolo != null) {
        s.setAttribute(charts.pointSymbolRendererIdKey, simbolo);
      }
      return s;
    }
 
    final series = <charts.Series<dynamic, num>>[
      serie('Chicos', chicos, 0, null),
      serie('Medianos', medios, 1, 'cuadrado'),
      serie('Grandes', grandes, 2, 'hueco'),
    ];
    return LienzoDescrito(
      titulo: 'community · Dispersion con formas',
      paraQue:
          'Una nube de puntos donde cada grupo se distingue por su forma '
          '(circulo, cuadrado, circulo hueco) y por su color.',
      cuando:
          'Cuando la grafica puede verse en blanco y negro o la leen '
          'personas con daltonismo: la forma refuerza al color.',
      grafica: charts.ScatterPlotChart(
        series,
        animate: true,
        defaultRenderer: charts.PointRendererConfig<num>(
          customSymbolRenderers: {
            'cuadrado': charts.RectSymbolRenderer(),
            'hueco': charts.CircleSymbolRenderer(isSolid: false),
          },
        ),
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}
 
/// 28. Areas superpuestas (no apiladas).
/// Varias series con relleno translucido en el mismo plano: a diferencia
/// del area apilada, cada una parte del eje y se superpone a las demas.
class CcAreasSuperpuestas extends StatelessWidget {
  const CcAreasSuperpuestas({super.key});
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
      titulo: 'community · Areas superpuestas',
      paraQue:
          'Varias areas translucidas que arrancan todas desde el eje, de '
          'modo que se ve cual es mayor y donde se cruzan.',
      cuando:
          'Para comparar el volumen de pocas series entre si (no su suma): '
          'dos o tres productos o periodos sobre la misma escala.',
      grafica: charts.LineChart(
        series,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          includeArea: true,
          includePoints: true,
          areaOpacity: 0.25,
        ),
        behaviors: [charts.SeriesLegend()],
      ),
    );
  }
}
 
/// 29. Tramo solido + tramo punteado.
/// Dos series que se empalman: la primera en trazo continuo y la segunda
/// en trazo discontinuo (dashPatternFn).
class CcSolidoPunteado extends StatelessWidget {
  const CcSolidoPunteado({super.key});
  @override
  Widget build(BuildContext context) {
    final datos = DatosMock.serieTemporal;
    const corte = 21; // indice donde termina el tramo continuo
    final continuo = datos.sublist(0, corte + 1);
    final punteado = datos.sublist(corte); // comparte el punto de empalme
    final series = <charts.Series<dynamic, num>>[
      charts.Series<PuntoTemporal, num>(
        id: 'Continuo',
        domainFn: (p, i) => i ?? 0,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        data: continuo,
      ),
      charts.Series<PuntoTemporal, num>(
        id: 'Punteado',
        domainFn: (p, i) => (i ?? 0) + corte,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(0),
        dashPatternFn: (_, __) => [6, 4],
        data: punteado,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Solido + punteado',
      paraQue:
          'Una misma linea que cambia de trazo: continuo en el primer tramo '
          'y discontinuo en el segundo, unidos sin corte visible.',
      cuando:
          'Para distinguir datos medidos de datos estimados o proyectados: '
          'el trazo punteado avisa que ese tramo es menos firme.',
      grafica: charts.LineChart(
        series,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(includePoints: true),
      ),
    );
  }
}
 
/// 30. Barras redondeadas.
/// Columnas tipo capsula: esquinas muy redondeadas y ancho maximo.
class CcBarrasRedondeadas extends StatelessWidget {
  const CcBarrasRedondeadas({super.key});
  @override
  Widget build(BuildContext context) {
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Ventas',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(3),
        labelAccessorFn: (p, _) => p.valor.toStringAsFixed(0),
        data: DatosMock.ventasMensuales,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Barras redondeadas',
      paraQue:
          'Columnas de extremos muy redondeados, con ancho maximo fijo y su '
          'valor impreso, para un acabado suave en lugar de bloques rigidos.',
      cuando:
          'En apps de estilo moderno con pocas categorias, donde la '
          'estetica pesa tanto como la lectura.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        defaultRenderer: charts.BarRendererConfig<String>(
          cornerStrategy: const charts.ConstCornerStrategy(30),
          maxBarWidthPx: 36,
          barRendererDecorator: charts.BarLabelDecorator<String>(),
        ),
      ),
    );
  }
}
 
/// 31. Histograma.
/// Agrupa los 30 valores de la serie en 6 intervalos iguales y cuenta
/// cuantos caen en cada uno.
class CcHistograma extends StatelessWidget {
  const CcHistograma({super.key});
  @override
  Widget build(BuildContext context) {
    final valores = DatosMock.distribucion;
    const intervalos = 6;
    final minimo = valores.reduce((a, b) => a < b ? a : b);
    final maximo = valores.reduce((a, b) => a > b ? a : b);
    final ancho = (maximo - minimo) / intervalos;
    final conteo = List<int>.filled(intervalos, 0);
    for (final v in valores) {
      final i = ancho == 0 ? 0 : ((v - minimo) / ancho).floor();
      conteo[i.clamp(0, intervalos - 1)]++;
    }
    final barras = <PuntoCategoria>[
      for (int i = 0; i < intervalos; i++)
        PuntoCategoria(
          '${(minimo + i * ancho).toStringAsFixed(0)}-'
          '${(minimo + (i + 1) * ancho).toStringAsFixed(0)}',
          conteo[i].toDouble(),
        ),
    ];
    final serie = <charts.Series<dynamic, String>>[
      charts.Series<PuntoCategoria, String>(
        id: 'Frecuencia',
        domainFn: (p, _) => p.categoria,
        measureFn: (p, _) => p.valor,
        colorFn: (_, __) => _color(4),
        labelAccessorFn: (p, _) => p.valor.toStringAsFixed(0),
        data: barras,
      ),
    ];
    return LienzoDescrito(
      titulo: 'community · Histograma',
      paraQue:
          'Muestra como se distribuyen los valores: el rango total se '
          'divide en intervalos iguales y cada barra cuenta cuantos datos '
          'caen en el.',
      cuando:
          'Para conocer la forma de unos datos antes de resumirlos: si se '
          'concentran, si son simetricos o si hay valores extremos.',
      grafica: charts.BarChart(
        serie,
        animate: true,
        barRendererDecorator: charts.BarLabelDecorator<String>(),
      ),
    );
  }
}