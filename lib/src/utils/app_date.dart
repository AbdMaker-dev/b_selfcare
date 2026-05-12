import 'package:intl/intl.dart';



class AppDate {
  AppDate._();

  // "2026-08-24T00:00:00.000000Z" → "24 août 2026"
  static String format(String? iso, {String fallback = '-'}) {
    final dt = _parse(iso);
    if (dt == null) return fallback;
    return DateFormat('dd MMM yyyy', 'fr').format(dt.toLocal());
  }

  // "2026-08-24T00:00:00.000000Z" → "24/08/2026"
  static String formatShort(String? iso, {String fallback = '-'}) {
    final dt = _parse(iso);
    if (dt == null) return fallback;
    return DateFormat('dd/MM/yyyy').format(dt.toLocal());
  }

  // "2026-08-24T00:00:00.000000Z" → "24 août 2026 à 00:00"
  static String formatWithTime(String? iso, {String fallback = '-'}) {
    final dt = _parse(iso);
    if (dt == null) return fallback;
    return DateFormat("dd MMM yyyy 'à' HH:mm", 'fr').format(dt.toLocal());
  }

  // Retourne true si la date est dépassée
  static bool isPast(String? iso) {
    final dt = _parse(iso);
    if (dt == null) return false;
    return dt.isBefore(DateTime.now().toUtc());
  }

  // Retourne true si la date est dans le futur
  static bool isFuture(String? iso) {
    final dt = _parse(iso);
    if (dt == null) return false;
    return dt.isAfter(DateTime.now().toUtc());
  }

  // "2026-05-02T14:13:47.000000Z" → "02/05 · 14h13"
  static String dashboardFmt(String? iso, {String fallback = ''}) {
    final dt = _parse(iso);
    if (dt == null) return fallback;
    final local = dt.toLocal();
    final date = DateFormat('dd/MM').format(local);
    final time = DateFormat("HH'h'mm").format(local);
    return '$date · $time';
  }

  // "2026-05-12" (date seule) → "12/05"
  static String dayMonth(String? date, {String fallback = ''}) {
    if (date == null || date.isEmpty) return fallback;
    final parts = date.split('-');
    return parts.length == 3 ? '${parts[2]}/${parts[1]}' : fallback;
  }

  static DateTime? _parse(String? iso) {
    if (iso == null || iso.isEmpty) return null;
    try {
      return DateTime.parse(iso).toUtc();
    } catch (_) {
      return null;
    }
  }
}

class AppMoney {
  AppMoney._();

  static final _formatter = NumberFormat.decimalPattern('fr');

  // 1500000 → "1 500 000 FCFA"  |  suffix: 'Fcfa' → "1 500 000 Fcfa"
  static String format(num? amount, {String suffix = 'FCFA', String fallback = '-'}) {
    if (amount == null) return fallback;
    return '${_formatter.format(amount)} $suffix';
  }

  // "1500000" (String) → "1 500 000 FCFA"
  static String formatString(String? amount, {String suffix = 'FCFA', String fallback = '-'}) {
    if (amount == null || amount.isEmpty) return fallback;
    final parsed = num.tryParse(amount);
    if (parsed == null) return fallback;
    return '${_formatter.format(parsed)} $suffix';
  }

  // 1500000 → "1 500 000 F CFA"  (variante longue)
  static String formatLong(num? amount, {String fallback = '-'}) {
    if (amount == null) return fallback;
    return '${_formatter.format(amount)} F CFA';
  }

  // 1500000.5 → "1 500 000,50 FCFA"  (avec centimes)
  static String formatWithDecimals(num? amount, {String fallback = '-'}) {
    if (amount == null) return fallback;
    final fmt = NumberFormat('#,##0.00', 'fr');
    return '${fmt.format(amount)} FCFA';
  }
}
