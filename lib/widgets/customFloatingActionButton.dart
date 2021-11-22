import 'package:flutter/material.dart';
 import 'package:animations/animations.dart';
import 'package:flutterapp2/pages/lostPetRegister.dart';

 class CustomFloatingActionButton extends StatelessWidget {
   const CustomFloatingActionButton({Key? key}) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return LostPetRegister();
      },
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56 / 2),
        ),
      ),
      closedColor: Theme.of(context).colorScheme.secondary,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          height: 56,
          width: 56,
          child: Center(
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        );
      },
    );
   }
 }