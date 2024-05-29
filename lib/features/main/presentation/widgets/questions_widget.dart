import 'package:auto_animated/auto_animated.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../main.dart';
import '../../core/entity/questions_entity.dart';

class QuestionsWidget extends StatelessWidget {
  final List<QuestionsEntity> questions;
  const QuestionsWidget({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return questions.isEmpty ?const SizedBox() : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'oftenQuestion'.tr(),
              style: TextStyle(
                  color: AppStyle.dark,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600),
            ),

          ],
        ),
        SizedBox(height: 17.h),
        LiveList.options(
          options: optionsForListView,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 11.h),
          itemBuilder: (context, index, animations) {
            final question = questions[index];
            return _buildAnimatedItem(context, index, animations, question);
          },
          itemCount: questions.length,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildAnimatedItem(
      BuildContext context,
      int index,
      Animation<double> animation,
      QuestionsEntity question,
      ) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.1, 0),
          end: Offset.zero,
        ).animate(animation),
        // Paste you Widget
        child: _QuestionItemWidget(
          question: question,
        ),
      ),
    ).animate().shimmer(
      delay: const Duration(seconds: 1),
    );
  }
}

class _QuestionItemWidget extends StatefulWidget {
  final QuestionsEntity question;
  const _QuestionItemWidget({required this.question});

  @override
  State<_QuestionItemWidget> createState() => _QuestionItemWidgetState();
}

class _QuestionItemWidgetState extends State<_QuestionItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleOpen() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleOpen,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff001E21).withOpacity(0.2),
              blurRadius: 21,
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 21.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.question.name,
                    style: TextStyle(
                      color: const Color(0xff474747),
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(width: 40.w),
                RotationTransition(
                  turns: Tween<double>(
                    begin: 0.0,
                    end: _isOpen ? 0.25 : 0.25,
                  ).animate(CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  )),
                  child: const Icon(
                    Icons.chevron_right,
                    color: Color(0xff474747),
                  ),
                ),
              ],
            ),
            SizedBox(height: 21.h),
            SizeTransition(
              sizeFactor: _animationController.drive(
                CurveTween(curve: Curves.easeInOut),
              ),
              axisAlignment: -1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.question.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 21.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
