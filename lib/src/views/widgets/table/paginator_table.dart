import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/table/page_btn.dart';
import 'package:flutter/material.dart';

class PaginatorTable extends StatelessWidget {
  final int start, end, total;
  final bool activePrev, activeNext;
  final VoidCallback? onPrev, onNext;

  const PaginatorTable({
    required this.start, required this.end, required this.total,
    required this.activePrev, required this.activeNext,
    this.onPrev, this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.symmetric(horizontal: 16.rw, vertical: 10.rh),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.gray)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(total == 0 ? 'Aucun résultat' : '$start – $end sur $total',
              style: TextStyle(fontSize: 12.rsp, color: AppColors.textMuted)),
           SizedBox(width: 8.rw),
          PageBtn(icon: Icons.chevron_left,  enabled: activePrev, onTap: onPrev),
           SizedBox(width: 4.rw),
          PageBtn(icon: Icons.chevron_right, enabled: activeNext, onTap: onNext),
        ],
      ),
    );
  }
}