import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';
import '../../../configs/constants/color.dart';
import '../../../configs/constants/keys.dart';

import 'rounded_icon_button.dart';
import 'top_rounded_container.dart';

class AuthCustomBackground extends StatelessWidget {
  const AuthCustomBackground({
    Key? key,
    required this.inputFormWidgets,
    this.navigateCallback,
    this.title,
    this.authFeatureTitle,
    this.footerWidgets,
    this.titleGuide,
    this.formKey,
  }) : super(key: key);

  final List<Widget> inputFormWidgets;
  final List<Widget>? footerWidgets;
  final Widget? titleGuide;
  final String? title, authFeatureTitle;
  final VoidCallback? navigateCallback;
  final GlobalKey<FormBuilderState>? formKey;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    final firstContainerTopMargin = size.height * 0.0123;
    final secondContainerTopMargin = firstContainerTopMargin + 10;
    return SafeArea(
      child: GestureDetector(
        onTap: node.unfocus,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Positioned.fill(
              top: firstContainerTopMargin,
              child: Center(
                child: TopRoundedContainer(
                  color: Colors.grey[400],
                  width: size.width - 20,
                ),
              ),
            ),
            Positioned.fill(
              top: secondContainerTopMargin,
              child: const TopRoundedContainer(
                color: Colors.white,
              ),
            ),
            if (formKey != null)
              Positioned.fill(
                top: secondContainerTopMargin,
                bottom: secondContainerTopMargin,
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.15,
                      // vertical: size.height * 0.05,
                    ),
                    child: AnimationLimiter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(
                              milliseconds:
                                  kFlutterStaggeredAnimationsDuration),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            if (title != null)
                              Container(
                                height: size.height * 0.15,
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    title!,
                                    style: TextStyle(
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold,
                                      color: kTextColor.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ),
                            if (titleGuide != null) titleGuide!,
                            // SizedBox(height: size.height * 0.03),
                            FormBuilder(
                              key: formKey,
                              onChanged: () {},
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    // padding: EdgeInsets.zero,
                                    itemBuilder: (_, index) =>
                                        inputFormWidgets[index],
                                    separatorBuilder: (_, __) => const Divider(
                                      height: 20,
                                      color: Colors.transparent,
                                    ),
                                    itemCount: inputFormWidgets.length,
                                  ),
                                  // ...inputFormWidgets,
                                  if (authFeatureTitle != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 40,
                                        bottom: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            authFeatureTitle!,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  kTextColor.withOpacity(0.8),
                                            ),
                                          ),
                                          RoundedIconButton(
                                            icon: const Icon(
                                              LineIcons.angleRight,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            fillColor: kPrimaryColor,
                                            width: 60,
                                            onPressed: () {
                                              node.unfocus();

                                              if (formKey!.currentState
                                                      ?.saveAndValidate() ??
                                                  false) {
                                                if (navigateCallback != null) {
                                                  navigateCallback!();
                                                }
                                              }
                                            },
                                            elevation: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (footerWidgets != null) ...footerWidgets!,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              Positioned.fill(
                top: secondContainerTopMargin,
                bottom: secondContainerTopMargin,
                child: LayoutBuilder(
                  builder: (_, constraints) => ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: inputFormWidgets,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(StringProperty('authFeatureTitle', authFeatureTitle));
    properties.add(ObjectFlagProperty<VoidCallback>.has(
        'navigateCallback', navigateCallback));
    properties.add(
        DiagnosticsProperty<GlobalKey<FormBuilderState>?>('formKey', formKey));
  }
}
