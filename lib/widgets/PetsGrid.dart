import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import 'package:flutterapp2/models/pet.dart';
import 'package:flutterapp2/pages/lostPetEdit.dart';
import 'package:flutterapp2/pages/petDetails.dart';
import 'package:flutterapp2/widgets/petCard.dart';


class PetsGrid extends StatelessWidget {
  
  final Size size;
  final Future<dynamic>? function;
  final List<Pet> data;
  final BuildContext context;
  final bool isEdit;
  const PetsGrid({
    Key? key,
    required this.size,
    required this.function,
    required this.data,
    required this.context,
    this.isEdit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( left: 15, right: 15 ),
      height: size.height * 0.8,
      width: double.infinity,
      child: FutureBuilder(
      future: this.function,
      builder:(context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                child: GridView.builder(                                                  
                  itemCount: data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    
                    return _OpenContainerWrapper(
                      isEdit: this.isEdit,
                      pet: data[index],
                      closedBuilder: (BuildContext _, VoidCallback openContainer) {
                        return PetCard(
                          data: data[index], 
                          size: size,
                          function: openContainer,
                        );                               
                      },
                      onClosed: _showMarkedAsDoneSnackbar,
                    );
                    // return PetCard(data: data[index], size: size,);                               
                  }, 
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 0,
                    crossAxisCount: 2,
                  ),
                )
            );
          }
        }
      ),
    );
  }

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
  }

}


class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    // required this.transitionType,
    required this.onClosed,
    required this.pet,
    this.isEdit = false,
  });

  final CloseContainerBuilder closedBuilder;
  // final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;
  final Pet pet;
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      closedElevation: 0,
      openElevation: 0,
      openColor: Colors.transparent,
      closedColor: Colors.transparent,
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return this.isEdit ? LostPetEdit( littelPet: pet ) : PetDetailsPage( littlePet: pet);
      },
      onClosed: onClosed,
      transitionDuration: Duration(milliseconds: 400) ,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}