import 'dart:math';

// ============================================================
// FORMAS DE DATOS
// El taller usa datos simulados. Se organizan por FORMA, no por
// grafica: una misma forma alimenta muchos tipos de grafico. Cada
// forma se declara una sola vez aqui y la reutilizan todas las
// pantallas de las cuatro librerias.
// ============================================================

/// Categoria -> valor.
/// Barras, lineas, area, pastel, dona, radial, embudo, piramide.
class PuntoCategoria {
  final String categoria;
  final double valor;
  const PuntoCategoria(this.categoria, this.valor);
}

/// Serie temporal: fecha -> valor.
/// Linea, area, spark, step, fast line.
class PuntoTemporal {
  final DateTime fecha;
  final double valor;
  const PuntoTemporal(this.fecha, this.valor);
}

/// Punto en el plano, con tamano opcional para burbuja.
/// Dispersion y burbuja.
class PuntoXY {
  final double x;
  final double y;
  final double tamano;
  const PuntoXY(this.x, this.y, [this.tamano = 8]);
}

/// Serie con nombre, para graficos de varias series.
/// Barras agrupadas, apiladas, lineas multiples.
class SerieNombrada {
  final String nombre;
  final List<PuntoCategoria> puntos;
  const SerieNombrada(this.nombre, this.puntos);
}

/// Metrica de una entidad, para radar.
class EjeRadar {
  final String eje;
  final double valor;
  const EjeRadar(this.eje, this.valor);
}

/// Celda de una matriz (x, y, intensidad), para mapas de calor.
class CeldaCalor {
  final int x;
  final int y;
  final double intensidad;
  const CeldaCalor(this.x, this.y, this.intensidad);
}

/// Vela bursatil: fecha con apertura, alto, bajo y cierre.
/// Candlestick y OHLC (hilo).
class Vela {
  final DateTime fecha;
  final double apertura;
  final double alto;
  final double bajo;
  final double cierre;
  const Vela(this.fecha, this.apertura, this.alto, this.bajo, this.cierre);
}

/// Nodo de una jerarquia padre-hijos.
/// Tree, treemap, sunburst.
class NodoJerarquia {
  final String nombre;
  final double valor;
  final List<NodoJerarquia> hijos;
  const NodoJerarquia(this.nombre, this.valor, [this.hijos = const []]);
}

/// Enlace de un grafo o diagrama de flujo (sankey).
class Enlace {
  final String origen;
  final String destino;
  final double valor;
  const Enlace(this.origen, this.destino, this.valor);
}

// ============================================================
// FUENTE DE DATOS
// ============================================================

class DatosMock {
  DatosMock._();

  // Semilla fija: los datos aleatorios son reproducibles entre
  // ejecuciones, util para una demostracion consistente.
  static final _rnd = Random(42);

  // ---- 1. Categoria -> valor: ventas mensuales ----
  static const ventasMensuales = <PuntoCategoria>[
    PuntoCategoria('Ene', 32),
    PuntoCategoria('Feb', 45),
    PuntoCategoria('Mar', 28),
    PuntoCategoria('Abr', 61),
    PuntoCategoria('May', 54),
    PuntoCategoria('Jun', 73),
  ];

  // ---- 2. Categoria -> valor: reparto porcentual ----
  static const cuotaMercado = <PuntoCategoria>[
    PuntoCategoria('Android', 48),
    PuntoCategoria('iOS', 37),
    PuntoCategoria('Web', 10),
    PuntoCategoria('Otros', 5),
  ];

  // ---- 3. Serie temporal: 30 dias ----
  static final serieTemporal = List<PuntoTemporal>.generate(30, (i) {
    final base = 50 + i * 1.2;
    final ruido = _rnd.nextDouble() * 20 - 10;
    return PuntoTemporal(
      DateTime(2026, 8, 1).add(Duration(days: i)),
      (base + ruido).clamp(0, 100).toDouble(),
    );
  });

  // ---- 4. Puntos (x, y) con tamano ----
  static final dispersion = List<PuntoXY>.generate(40, (_) {
    final x = _rnd.nextDouble() * 100;
    final y =
        (x * 0.6 + (_rnd.nextDouble() * 40 - 20)).clamp(0, 100).toDouble();
    final t = 6 + _rnd.nextDouble() * 18;
    return PuntoXY(x, y, t);
  });

  // ---- 5. Varias series por trimestre ----
  static const seriesMultiples = <SerieNombrada>[
    SerieNombrada('Producto A', [
      PuntoCategoria('T1', 30),
      PuntoCategoria('T2', 45),
      PuntoCategoria('T3', 38),
      PuntoCategoria('T4', 52),
    ]),
    SerieNombrada('Producto B', [
      PuntoCategoria('T1', 20),
      PuntoCategoria('T2', 28),
      PuntoCategoria('T3', 41),
      PuntoCategoria('T4', 35),
    ]),
    SerieNombrada('Producto C', [
      PuntoCategoria('T1', 15),
      PuntoCategoria('T2', 22),
      PuntoCategoria('T3', 30),
      PuntoCategoria('T4', 48),
    ]),
  ];

  // ---- 6. Multi-variable de una entidad: radar ----
  static const perfilRadar = <EjeRadar>[
    EjeRadar('Velocidad', 80),
    EjeRadar('Fuerza', 65),
    EjeRadar('Defensa', 70),
    EjeRadar('Tecnica', 90),
    EjeRadar('Resistencia', 60),
  ];

  // Segundo perfil, para radar comparativo de dos entidades.
  static const perfilRadar2 = <EjeRadar>[
    EjeRadar('Velocidad', 60),
    EjeRadar('Fuerza', 85),
    EjeRadar('Defensa', 55),
    EjeRadar('Tecnica', 70),
    EjeRadar('Resistencia', 80),
  ];

  // ---- 7. Matriz (x, y, intensidad): 7 dias x 24 horas ----
  static final matrizCalor = <CeldaCalor>[
    for (int dia = 0; dia < 7; dia++)
      for (int hora = 0; hora < 24; hora++)
        CeldaCalor(hora, dia, _rnd.nextDouble() * 100),
  ];

  // ---- Distribucion (deriva de la serie temporal) ----
  static List<double> get distribucion =>
      serieTemporal.map((p) => p.valor).toList();

  // ---- 8. OHLC: 20 dias bursatiles coherentes ----
  static final velas = () {
    final lista = <Vela>[];
    double previo = 100;
    for (int i = 0; i < 20; i++) {
      final apertura = previo;
      final cambio = _rnd.nextDouble() * 12 - 6;
      final cierre = (apertura + cambio).clamp(60, 140).toDouble();
      final alto = max(apertura, cierre) + _rnd.nextDouble() * 5;
      final bajo = min(apertura, cierre) - _rnd.nextDouble() * 5;
      lista.add(Vela(
        DateTime(2026, 8, 1).add(Duration(days: i)),
        apertura,
        alto,
        bajo,
        cierre,
      ));
      previo = cierre;
    }
    return lista;
  }();

  // ---- 9. Valor unico con rango: medidores ----
  static const valorMedidor = 72.0;
  static const rangoMedidor = 100.0;

  // ---- 10. Valores con signo: cascada ----
  static const cascada = <PuntoCategoria>[
    PuntoCategoria('Ingresos', 120),
    PuntoCategoria('Costos', -45),
    PuntoCategoria('Impuestos', -18),
    PuntoCategoria('Otros', -12),
    PuntoCategoria('Extra', 25),
  ];

  // ---- 11. Jerarquia padre-hijos ----
  static const jerarquia = NodoJerarquia('Empresa', 0, [
    NodoJerarquia('Tecnologia', 0, [
      NodoJerarquia('Backend', 30),
      NodoJerarquia('Frontend', 25),
      NodoJerarquia('Datos', 20),
    ]),
    NodoJerarquia('Ventas', 0, [
      NodoJerarquia('Nacional', 40),
      NodoJerarquia('Exterior', 22),
    ]),
    NodoJerarquia('Soporte', 0, [
      NodoJerarquia('Nivel 1', 15),
      NodoJerarquia('Nivel 2', 10),
    ]),
  ]);

  // ---- 12. Nodos y enlaces: grafo y sankey ----
  static const nodos = <String>['A', 'B', 'C', 'D', 'E'];
  static const enlaces = <Enlace>[
    Enlace('A', 'B', 8),
    Enlace('A', 'C', 5),
    Enlace('B', 'D', 6),
    Enlace('C', 'D', 3),
    Enlace('C', 'E', 4),
    Enlace('D', 'E', 7),
  ];

  // ---- 13. Fecha-valor de un ano: calendario ----
  static final calendario = List.generate(365, (i) {
    final fecha = DateTime(2026, 1, 1).add(Duration(days: i));
    return MapEntry(fecha, _rnd.nextDouble() * 100);
  });
}
