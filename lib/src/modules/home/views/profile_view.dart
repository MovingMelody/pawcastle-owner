import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../viewmodels/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () => model.showExitDialog(),
        child: Scaffold(
          body: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/2.jpg"),
                    backgroundColor: Colors.transparent,
                    radius: 50,
                  ),
                  horizontalSpaceMedium,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIText.heading(
                        model.currentUser.name,
                      ),
                      UIText.paragraph(
                        model.currentUser.phone,
                        color: kTextSecondaryLightColor,
                      )
                    ],
                  )
                ],
              ),
              verticalSpaceMedium,
              ProfileListTile(
                icon: CupertinoIcons.question_circle,
                onTap: () => model.launchWhatsApp(),
                title: AppLocalizations.of(context)!.menuHelp,
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  const ProfileListTile(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.icon,
      this.trailing})
      : super(key: key);

  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: kCoreColor,
      ),
      onTap: onTap,
      title: UIText(title),
      contentPadding: EdgeInsets.zero,
      trailing: trailing,
    );
  }
}
