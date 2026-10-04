import 'package:flutter/material.dart';

import '../graficas/community/avanzadas_community.dart';
import '../graficas/community/basicas_community.dart';
import '../graficas/fl_chart/avanzadas_flchart.dart';
import '../graficas/fl_chart/basicas_flchart.dart';
import '../graficas/graphic/avanzadas_graphic.dart';
import '../graficas/graphic/basicas_graphic.dart';
import '../graficas/syncfusion/avanzadas_syncfusion.dart';
import '../graficas/syncfusion/basicas_syncfusion.dart';

/// Descriptor de una grafica: su nombre y como construirla.
class ItemGrafica {
  final String nombre;
  final WidgetBuilder builder;
  const ItemGrafica(this.nombre, this.builder);
}

/// Una libreria con sus dos grupos de graficas.
class Libreria {
  final String nombre;
  final String descripcion;
  final List<ItemGrafica> basicas;
  final List<ItemGrafica> avanzadas;
  const Libreria({
    required this.nombre,
    required this.descripcion,
    required this.basicas,
    required this.avanzadas,
  });
}

/// Catalogo del taller. Para agregar una grafica basta crear su clase y
/// registrar un ItemGrafica aqui: el menu se actualiza solo.
final catalogo = <Libreria>[
  Libreria(
    nombre: 'community_charts',
    descripcion: 'Fork de Google Charts, nativo en Dart - 20 graficas',
    basicas: [
      ItemGrafica('Barras', (_) => const CcBarras()),
      ItemGrafica('Barras con etiquetas', (_) => const CcBarrasEtiquetas()),
      ItemGrafica('Lineas con puntos', (_) => const CcLineasPuntos()),
      ItemGrafica('Linea con area', (_) => const CcLineaArea()),
      ItemGrafica('Serie de tiempo', (_) => const CcSerieTiempo()),
      ItemGrafica('Dispersion', (_) => const CcDispersion()),
      ItemGrafica('Barras agrupadas', (_) => const CcBarrasAgrupadas()),
      ItemGrafica('Pastel', (_) => const CcPastel()),
      ItemGrafica('Dona', (_) => const CcDona()),
      ItemGrafica('Step line', (_) => const CcStepLine()),
      ItemGrafica('Linea + puntos + area', (_) => const CcLineaPuntoArea()),
      ItemGrafica('Apiladas + total', (_) => const CcApiladasTotal()),
      ItemGrafica('Tiempo + banda', (_) => const CcTiempoBanda()),
      ItemGrafica('Dispersion 4D', (_) => const CcDispersionTamColor()),
      ItemGrafica('Piramide tornado', (_) => const CcTornado()),
      ItemGrafica('Barras divergentes', (_) => const CcDivergentes()),
      ItemGrafica('Dona concentrica', (_) => const CcDonaConcentrica()),
      ItemGrafica('Barras + promedio movil', (_) => const CcBarrasPromedioMovil()),
      ItemGrafica('Burbujas en grilla', (_) => const CcBurbujasGrid()),
      ItemGrafica('Area apilada temporal', (_) => const CcAreaApiladaTiempo()),
      ItemGrafica('Barras por umbral', (_) => const CcBarrasUmbral()),
      ItemGrafica('Barras horizontales agrupadas', (_) => const CcBarrasHorizAgrupadas()),
      ItemGrafica('Apiladas al 100%', (_) => const CcApiladas100()),
      ItemGrafica('Agrupadas + apiladas', (_) => const CcAgrupadasApiladas()),
      ItemGrafica('Pastel con etiquetas externas', (_) => const CcPastelEtiquetasExternas()),
      ItemGrafica('Sparklines', (_) => const CcSparklines()),
      ItemGrafica('Dispersion con formas', (_) => const CcDispersionFormas()),
      ItemGrafica('Areas superpuestas', (_) => const CcAreasSuperpuestas()),
      ItemGrafica('Solido + punteado', (_) => const CcSolidoPunteado()),
      ItemGrafica('Barras redondeadas', (_) => const CcBarrasRedondeadas()),
      ItemGrafica('Histograma', (_) => const CcHistograma()),
    ],
    avanzadas: [
      ItemGrafica('Barras con seleccion', (_) => const CcBarrasSeleccion()),
      ItemGrafica('Combo linea + barra', (_) => const CcComboLineaBarra()),
      ItemGrafica('Combo dispersion + linea', (_) => const CcComboDispersionLinea()),
      ItemGrafica('Lineas con leyenda', (_) => const CcLineasLeyenda()),
      ItemGrafica('Barras con slider', (_) => const CcBarrasSlider()),
      ItemGrafica('Serie con banda', (_) => const CcBandaConfianza()),
      ItemGrafica('Zoom y paneo', (_) => const CcZoomPan()),
      ItemGrafica('Gauge de arco', (_) => const CcGaugeArco()),
      ItemGrafica('Barras horizontales', (_) => const CcBarrasHorizontales()),
      ItemGrafica('Linea con anotacion', (_) => const CcLineaAnotacion()),
      ItemGrafica('Combo barras + area', (_) => const CcComboBarrasArea()),
      ItemGrafica('Tiempo + promedio + banda', (_) => const CcTiempoPromedioBanda()),
      ItemGrafica('Agrupadas + seleccion + leyenda', (_) => const CcAgrupadasSeleccionLeyenda()),
      ItemGrafica('Dispersion + zoom', (_) => const CcDispersionZoom()),
      ItemGrafica('Apiladas + linea total', (_) => const CcApiladasLineaTotal()),
      ItemGrafica('Lineas + promedio + leyenda', (_) => const CcLineasPromedioLeyenda()),
      ItemGrafica('Gauge doble', (_) => const CcGaugeDoble()),
      ItemGrafica('Area + referencia', (_) => const CcAreaReferencia()),
      ItemGrafica('Dispersion por zonas', (_) => const CcDispersionZonas()),
      ItemGrafica('Combo de tres renderers', (_) => const CcComboTres()),
      ItemGrafica('Cascada', (_) => const CcCascada()),
      ItemGrafica('Barras + marcador', (_) => const CcBarrasMarcador()),
      ItemGrafica('Velas', (_) => const CcVelas()),
      ItemGrafica('Banda de desviacion', (_) => const CcBandaDesviacion()),
      ItemGrafica('Maximo y minimo', (_) => const CcMaxMinAnotados()),
      ItemGrafica('Leyenda con valores', (_) => const CcLeyendaMedidas()),
      ItemGrafica('Barras con detalle', (_) => const CcBarrasDetalle()),
      ItemGrafica('Slider', (_) => const CcSliderLinea()),
      ItemGrafica('Dona con total al centro', (_) => const CcDonaTotalCentro()),
      ItemGrafica('Doble eje', (_) => const CcDobleEje()),
      ItemGrafica('Gantt', (_) => const CcGantt()),
      ItemGrafica('Mancuernas', (_) => const CcMancuernas()),
    ],
  ),
  Libreria(
    nombre: 'fl_chart',
    descripcion: 'Nativa en Dart, muy personalizable · 20 graficas',
    basicas: [
      ItemGrafica('Barras', (_) => const FlBarras()),
      ItemGrafica('Lineas', (_) => const FlLineas()),
      ItemGrafica('Area', (_) => const FlArea()),
      ItemGrafica('Pastel', (_) => const FlPastel()),
      ItemGrafica('Dona', (_) => const FlDona()),
      ItemGrafica('Barras horizontales', (_) => const FlBarrasHorizontales()),
      ItemGrafica('Lineas multiples', (_) => const FlLineasMultiples()),
      ItemGrafica('Barras apiladas', (_) => const FlBarrasApiladas()),
      ItemGrafica('Dispersion', (_) => const FlDispersion()),
      ItemGrafica('Area con gradiente', (_) => const FlAreaGradiente()),
      ItemGrafica('Barras + tendencia', (_) => const FlBarrasTendencia()),
      ItemGrafica('Linea con banda', (_) => const FlLineaBanda()),
      ItemGrafica('Pastel anidado', (_) => const FlPastelAnidado()),
      ItemGrafica('Dispersion + promedios', (_) => const FlDispersionPromedio()),
      ItemGrafica('Area + hitos', (_) => const FlAreaHitos()),
      ItemGrafica('Apiladas + lineas', (_) => const FlApiladasLineas()),
      ItemGrafica('Doble eje', (_) => const FlLineaDobleEje()),
      ItemGrafica('Embudo de conversion', (_) => const FlEmbudo()),
      ItemGrafica('Pareto', (_) => const FlPareto()),
      ItemGrafica('Mapa de calor', (_) => const FlMapaCalor()),
      ItemGrafica('Linea punteada', (_) => const FlLineaPunteada()),
      ItemGrafica('Barras pill', (_) => const FlBarrasPill()),
      ItemGrafica('Pastel separado', (_) => const FlPastelSeparado()),
      ItemGrafica('Lineas con relleno', (_) => const FlLineasRelleno()),
      ItemGrafica('Barras positivas y negativas', (_) => const FlBarrasPosNeg()),
      ItemGrafica('Dispersion por tamano', (_) => const FlDispersionTamano()),
      ItemGrafica('Area escalonada', (_) => const FlAreaEscalonada()),
      ItemGrafica('Barras + meta', (_) => const FlBarrasMeta()),
      ItemGrafica('Dona de anillos finos', (_) => const FlDonaAnillosFinos()),
      ItemGrafica('Linea con umbral', (_) => const FlLineaUmbral()),
      ItemGrafica('Barras horizontales apiladas', (_) => const FlBarrasHorizApiladas()),
    ],
    avanzadas: [
      ItemGrafica('Radar', (_) => const FlRadar()),
      ItemGrafica('Linea curva con sombra', (_) => const FlLineaCurvaSombra()),
      ItemGrafica('Barras con fondo', (_) => const FlBarrasConFondo()),
      ItemGrafica('Pastel interactivo', (_) => const FlPastelInteractivo()),
      ItemGrafica('Burbuja', (_) => const FlBurbuja()),
      ItemGrafica('Linea con tooltip', (_) => const FlLineaTooltip()),
      ItemGrafica('Barras agrupadas', (_) => const FlBarrasAgrupadas()),
      ItemGrafica('Area apilada', (_) => const FlAreaApilada()),
      ItemGrafica('Lineas de referencia', (_) => const FlLineasReferencia()),
      ItemGrafica('Banda min-max', (_) => const FlBandaMinMax()),
      ItemGrafica('Burbujas + cuadrantes', (_) => const FlBurbujaCuadrantes()),
      ItemGrafica('Cascada', (_) => const FlCascada()),
      ItemGrafica('Barras + zona meta', (_) => const FlBarrasAreaFondo()),
      ItemGrafica('Radar + barras', (_) => const FlRadarBarras()),
      ItemGrafica('Termometro de progreso', (_) => const FlTermometro()),
      ItemGrafica('Dispersion + regresion', (_) => const FlRegresion()),
      ItemGrafica('Velas', (_) => const FlVelas()),
      ItemGrafica('Area de diferencia', (_) => const FlAreaDiferencia()),
      ItemGrafica('Agrupadas + objetivo', (_) => const FlAgrupadasObjetivo()),
      ItemGrafica('Gantt', (_) => const FlGantt()),
      ItemGrafica('Velas + volumen', (_) => const FlVelasVolumen()),
      ItemGrafica('Radar de tres perfiles', (_) => const FlRadarTresPerfiles()),
      ItemGrafica('Dispersion + elipse', (_) => const FlDispersionElipse()),
      ItemGrafica('Barras + banda de desviacion', (_) => const FlBarrasBandaSigma()),
      ItemGrafica('Area sobre/bajo umbral', (_) => const FlLineaAreaUmbral()),
      ItemGrafica('Pareto doble', (_) => const FlParetoDoble()),
      ItemGrafica('Gantt con progreso', (_) => const FlGanttProgreso()),
      ItemGrafica('Mapa de calor con leyenda', (_) => const FlMapaCalorLeyenda()),
      ItemGrafica('Embudo con tasas', (_) => const FlEmbudoTasas()),
      ItemGrafica('Burbujas + cuadrantes con nombre', (_) => const FlBurbujasCuadrantesNombre()),
      ItemGrafica('Linea multi-eje', (_) => const FlLineaMultiEje()),
      ItemGrafica('Cascada con conectores', (_) => const FlCascadaConectores()),
    ],
  ),
  Libreria(
    nombre: 'Syncfusion',
    descripcion: 'Comercial, +30 tipos, empresarial · 20 graficas',
    basicas: [
      ItemGrafica('Columnas', (_) => const SfColumnas()),
      ItemGrafica('Spline', (_) => const SfSpline()),
      ItemGrafica('Step area', (_) => const SfStepArea()),
      ItemGrafica('Apiladas 100%', (_) => const SfApiladas100()),
      ItemGrafica('Range column', (_) => const SfRangeColumn()),
      ItemGrafica('Spline area', (_) => const SfSplineArea()),
      ItemGrafica('Fast line', (_) => const SfFastLine()),
      ItemGrafica('Columnas horizontales', (_) => const SfColumnasDegradado()),
      ItemGrafica('Area con marcadores', (_) => const SfAreaMarcadores()),
      ItemGrafica('Linea con etiquetas', (_) => const SfLineaEtiquetas()),
      ItemGrafica('Columna + linea', (_) => const SfColumnaLinea()),
      ItemGrafica('Columnas apiladas', (_) => const SfApiladas()),
      ItemGrafica('Area + borde', (_) => const SfAreaBorde()),
      ItemGrafica('Columna + spline', (_) => const SfColumnaSpline()),
      ItemGrafica('Dos lineas', (_) => const SfDosLineas()),
      ItemGrafica('Columnas agrupadas', (_) => const SfAgrupadas()),
      ItemGrafica('Linea con banda', (_) => const SfLineaBanda()),
      ItemGrafica('Columnas + referencia', (_) => const SfColumnasPlotBand()),
      ItemGrafica('Dispersion', (_) => const SfScatter()),
      ItemGrafica('Burbuja', (_) => const SfBurbuja()),
      ItemGrafica('Step line', (_) => const SfStepLinea()),
       ItemGrafica('Lineas apiladas', (_) => const SfLineasApiladas()),
       ItemGrafica('Barras horizontales apiladas', (_) => const SfBarrasApiladasHoriz()),
       ItemGrafica('Area al 100%', (_) => const SfArea100()),
       ItemGrafica('Histograma', (_) => const SfHistograma()),
       ItemGrafica('Pastel con porcion separada', (_) => const SfPastelExplotado()),
       ItemGrafica('Dona con total al centro', (_) => const SfDonaTotalCentro()),
       ItemGrafica('Columnas con pista', (_) => const SfColumnasPista()),
       ItemGrafica('Columnas con degradado', (_) => const SfColumnasGradiente()),
       ItemGrafica('Dispersion por grupos', (_) => const SfDispersionGrupos()),
       ItemGrafica('Sparklines', (_) => const SfSparklines()),
    ],
    avanzadas: [
      ItemGrafica('Velas', (_) => const SfVelas()),
      ItemGrafica('OHLC (hilo)', (_) => const SfOhlc()),
      ItemGrafica('Piramide', (_) => const SfPiramide()),
      ItemGrafica('Embudo', (_) => const SfEmbudo()),
      ItemGrafica('Cascada', (_) => const SfCascada()),
      ItemGrafica('Medidor', (_) => const SfMedidor()),
      ItemGrafica('Spark', (_) => const SfSpark()),
      ItemGrafica('Range area', (_) => const SfRangeArea()),
      ItemGrafica('Box and whisker', (_) => const SfBoxplot()),
      ItemGrafica('Polar', (_) => const SfPolar()),
      ItemGrafica('Velas + media movil', (_) => const SfVelasMedia()),
      ItemGrafica('Embudo piramidal', (_) => const SfEmbudoPiramide()),
      ItemGrafica('Medidor lineal', (_) => const SfMedidorLineal()),
      ItemGrafica('Hilo (alto-bajo)', (_) => const SfHilo()),
      ItemGrafica('Dona semicircular', (_) => const SfDonaSemi()),
      ItemGrafica('Columnas con error', (_) => const SfColumnasError()),
      ItemGrafica('Multi-eje', (_) => const SfMultiEje()),
      ItemGrafica('Columnas con seleccion', (_) => const SfColumnasSeleccion()),
      ItemGrafica('Spline con zonas', (_) => const SfSplineZonas()),
      ItemGrafica('Apiladas + total', (_) => const SfApiladasTotal()),
      ItemGrafica('Tendencias', (_) => const SfTendencias()),
      ItemGrafica('Velas + Bollinger', (_) => const SfVelasBollinger()),
      ItemGrafica('Zoom y paneo', (_) => const SfZoomPan()),
      ItemGrafica('Trackball', (_) => const SfTrackball()),
      ItemGrafica('Anotaciones', (_) => const SfAnotaciones()),
      ItemGrafica('Eje logaritmico', (_) => const SfEjeLogaritmico()),
      ItemGrafica('Barras de error', (_) => const SfBarrasError()),
      ItemGrafica('Progreso circular', (_) => const SfProgresoCircular()),
      ItemGrafica('Medidores lineales', (_) => const SfMedidoresLineales()),
      ItemGrafica('Sparks barras y win/loss', (_) => const SfSparkBarWinLoss()),
      ItemGrafica('Datos faltantes', (_) => const SfDatosFaltantes()),
      ItemGrafica('Etiquetas multinivel', (_) => const SfMultinivel()),
 
    ],
  ),
  Libreria(
    nombre: 'graphic',
    descripcion: 'Gramatica de graficos, declarativa · 20 graficas',
    basicas: [
      ItemGrafica('Barras', (_) => const GrBarras()),
      ItemGrafica('Puntos', (_) => const GrPuntos()),
      ItemGrafica('Lineas', (_) => const GrLineas()),
      ItemGrafica('Area', (_) => const GrArea()),
      ItemGrafica('Pastel', (_) => const GrPastel()),
      ItemGrafica('Dona', (_) => const GrDona()),
      ItemGrafica('Barras agrupadas', (_) => const GrBarrasAgrupadas()),
      ItemGrafica('Lineas por grupo', (_) => const GrLineasGrupo()),
      ItemGrafica('Dispersion coloreada', (_) => const GrDispersionColor()),
      ItemGrafica('Barras horizontales', (_) => const GrBarrasHorizontales()),
      ItemGrafica('Puntos por forma', (_) => const GrPuntosForma()),
      ItemGrafica('Area + borde', (_) => const GrAreaBorde()),
      ItemGrafica('Histograma', (_) => const GrHistograma()),
      ItemGrafica('Burbujas', (_) => const GrBurbujas()),
      ItemGrafica('Barras con gradiente', (_) => const GrBarrasGradiente()),
      ItemGrafica('Radar', (_) => const GrRadar()),
      ItemGrafica('Barras + promedio', (_) => const GrBarrasPromedio()),
      ItemGrafica('Treemap', (_) => const GrTreemap()),
      ItemGrafica('Mapa de calor', (_) => const GrMapaCalor()),
      ItemGrafica('Linea escalonada', (_) => const GrLineaEscalonada()),
      ItemGrafica('Step real', (_) => const GrStepReal()),
      ItemGrafica('Barras al 100%', (_) => const GrBarras100()),
      ItemGrafica('Ranking horizontal', (_) => const GrRanking()),
      ItemGrafica('Lollipop', (_) => const GrLollipop()),
      ItemGrafica('Area con degradado', (_) => const GrAreaDegradado()),
      ItemGrafica('Dispersion + regresion', (_) => const GrDispersionRegresion()),
      ItemGrafica('Barras horizontales apiladas', (_) => const GrBarrasHorizApiladas()),
      ItemGrafica('Barras redondeadas', (_) => const GrBarrasRedondeadas()),
      ItemGrafica('Strip plot', (_) => const GrStripJitter()),
      ItemGrafica('Barras de rango', (_) => const GrBarrasRango()),
      ItemGrafica('Mapa de calor con valores', (_) => const GrMapaCalorValores()),
    ],
    avanzadas: [
      ItemGrafica('Rosa de Nightingale', (_) => const GrRosa()),
      ItemGrafica('Barras polares apiladas', (_) => const GrPolarApiladas()),
      ItemGrafica('Area apilada', (_) => const GrAreaApilada()),
      ItemGrafica('Barras apiladas', (_) => const GrBarrasApiladas()),
      ItemGrafica('Anillo', (_) => const GrAnillo()),
      ItemGrafica('Linea suavizada', (_) => const GrLineaSuave()),
      ItemGrafica('Linea + puntos', (_) => const GrLineaPuntos()),
      ItemGrafica('Burbuja', (_) => const GrBurbuja()),
      ItemGrafica('Barras con etiquetas', (_) => const GrBarrasEtiquetas()),
      ItemGrafica('Anillos por serie', (_) => const GrAnillosSeries()),
      ItemGrafica('Barras + tendencia', (_) => const GrBarrasTendencia()),
      ItemGrafica('Pastel con %', (_) => const GrPastelPorcentaje()),
      ItemGrafica('Area + puntos', (_) => const GrAreaPuntos()),
      ItemGrafica('Lineas + puntos por serie', (_) => const GrLineasPuntosSerie()),
      ItemGrafica('Dispersion tamano + forma', (_) => const GrDispersionTamForma()),
      ItemGrafica('Agrupadas + apiladas', (_) => const GrAgrupadasApiladas()),
      ItemGrafica('Pastel anidado', (_) => const GrPastelAnidado()),
      ItemGrafica('Banda min-max', (_) => const GrBandaMinMax()),
      ItemGrafica('Radar comparado', (_) => const GrRadarComparado()),
      ItemGrafica('Barras divergentes', (_) => const GrBarrasDivergentes()),
      ItemGrafica('Area al 100%', (_) => const GrArea100()),
      ItemGrafica('Cascada', (_) => const GrCascada()),
      ItemGrafica('Velas', (_) => const GrVelas()),
      ItemGrafica('Gantt', (_) => const GrGantt()),
      ItemGrafica('Barras con seleccion', (_) => const GrBarrasSeleccion()),
      ItemGrafica('Lineas con crosshair', (_) => const GrLineasCrosshair()),
      ItemGrafica('Dispersion con brush', (_) => const GrDispersionBrush()),
      ItemGrafica('Radar con area', (_) => const GrRadarArea()),
      ItemGrafica('Medidor', (_) => const GrMedidor()),
      ItemGrafica('Doble eje', (_) => const GrDobleEje()),
      ItemGrafica('Diagrama de caja', (_) => const GrBoxplot()),
      ItemGrafica('Anotaciones', (_) => const GrAnotaciones()),
    ],
  ),
];

/// Pantalla 1: lista de librerias.
class MenuLibrerias extends StatelessWidget {
  const MenuLibrerias({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taller de Graficas')),
      body: ListView.separated(
        itemCount: catalogo.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final lib = catalogo[i];
          final total = lib.basicas.length + lib.avanzadas.length;
          return ListTile(
            title: Text(lib.nombre),
            subtitle: Text(lib.descripcion),
            trailing: Text('$total'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MenuGrupos(libreria: lib)),
            ),
          );
        },
      ),
    );
  }
}

/// Pantalla 2: basicas o avanzadas.
class MenuGrupos extends StatelessWidget {
  final Libreria libreria;
  const MenuGrupos({super.key, required this.libreria});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(libreria.nombre)),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Graficas basicas'),
            trailing: Text('${libreria.basicas.length}'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ListaGraficas(
                  titulo: '${libreria.nombre} · Basicas',
                  items: libreria.basicas,
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Graficas avanzadas'),
            trailing: Text('${libreria.avanzadas.length}'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ListaGraficas(
                  titulo: '${libreria.nombre} · Avanzadas',
                  items: libreria.avanzadas,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pantalla 3: lista de graficas de un grupo.
class ListaGraficas extends StatelessWidget {
  final String titulo;
  final List<ItemGrafica> items;
  const ListaGraficas({super.key, required this.titulo, required this.items});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: items.isEmpty
          ? const Center(child: Text('Aun no hay graficas en este grupo'))
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) => ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(items[i].nombre),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: items[i].builder),
                ),
              ),
            ),
    );
  }
}
