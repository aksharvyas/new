import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:kremot/res/AppColors.dart';
import 'package:kremot/utils/Constants.dart';
import 'package:kremot/view/widgets/widget.dart';

import '../../../res/AppStyles.dart';
import '../Loading.dart';
import '../CustomDialog.dart';

class ContactListDialog extends StatefulWidget {
  double width;
  double height;
  Function onTap;

  ContactListDialog(this.width, this.height, this.onTap, {Key? key})
      : super(key: key);

  @override
  State<ContactListDialog> createState() => _ContactListDialogState();
}

class _ContactListDialogState extends State<ContactListDialog> {
  List<Contact>? _contacts;
  List<Contact> _searchContacts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return Center(
          child: CustomDialog(
        263.66,
        356.99,
        _contacts != null
            ? Stack(
                children: [
                  Container(
                    color: bgColor,
                    margin: EdgeInsets.symmetric(
                        horizontal: getX(widget.width, 15),
                        vertical: getY(widget.height, 15)),
                    child: Material(
                      color: bgColor,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: getX(widget.width, 10)),
                            height: getHeight(widget.height, 50),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0x80eceded), width: 1),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0.0, 3),
                                      blurRadius: 2,
                                      spreadRadius: 0)
                                ],
                                image: const DecorationImage(
                                  image: AssetImage(
                                      textFieldUnSelectedImage),
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: getX(widget.width, 10)),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search",
                                      hintStyle: hintTextStyle(context),
                                    ),
                                    keyboardType: TextInputType.text,
                                    controller: searchController,
                                    onChanged: onSearchTextChanged,
                                    style: hintTextStyle(context),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      searchController.clear();
                                      _searchContacts.clear();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 25,
                                    color: textColor,
                                  )),
                              SizedBox(
                                width: getWidth(widget.width, 5),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: getY(widget.height, 60),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(14.86390495300293)),
                      child: Container(
                        color: bgColor,
                        margin: EdgeInsets.only(top: getY(widget.height, 15)),
                        child: searchController.text.isNotEmpty && _searchContacts.isEmpty
                            ? Center(
                                child: Text(
                                'No Contacts found!',
                                style: TextStyle(
                                    fontSize: getAdaptiveTextSize(context, 15),
                                    decoration: TextDecoration.none,
                                    color: textColor),
                              ))
                            : _searchContacts.isNotEmpty
                                ? Material(
                                    color: bgColor,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: _searchContacts?.length ?? 0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Contact? c =
                                            _searchContacts?.elementAt(index);
                                        return ListTile(
                                          tileColor: bgColor,
                                          onTap: () {
                                            widget
                                                .onTap(_searchContacts![index]);
                                            Navigator.of(context).pop();
                                          },
                                          title: Text(c?.displayName ?? "",
                                              style: const TextStyle(
                                                  color: textColor)),
                                        );
                                      },
                                    ),
                                  )
                                : _contacts != null && _contacts!.isNotEmpty
                                    ? Material(
                                        color: bgColor,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: _contacts?.length ?? 0,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Contact? c =
                                                _contacts?.elementAt(index);
                                            return ListTile(
                                              tileColor:
                                                  bgColor,
                                              onTap: () {
                                                widget.onTap(_contacts![index]);
                                                Navigator.of(context).pop();
                                              },
                                              title: Text(c?.displayName ?? "",
                                                  style: const TextStyle(
                                                      color: textColor)),
                                            );
                                          },
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'No Contacts found!',
                                          style: TextStyle(
                                              fontSize: getAdaptiveTextSize(
                                                  context, 15),
                                              decoration: TextDecoration.none,
                                              color: textColor),
                                        ),
                                      ),
                      ),
                    ),
                  ),
                ],
              )
            : const Loading(),
      ));
    });
  }

  onSearchTextChanged(String text) {
    setState(() {
      _searchContacts.clear();

      _contacts?.forEach((contact) {
        if (contact.displayName != null) {
          if (contact.displayName!.toLowerCase().contains(text.toLowerCase())) {
            _searchContacts.add(contact);
          }
        }
      });
    });
    print("LENGTH: " + _searchContacts.length.toString());
    print("LENGTH1: " + _contacts!.length.toString());
  }

  Future<void> refreshContacts() async {
    // Load without thumbnails initially.
    var contacts = await ContactsService.getContacts(withThumbnails: false);

    setState(() {
      _contacts = contacts;
    });

    // // Lazy load thumbnails after rendering initial contacts.
    // for (final contact in contacts) {
    //   ContactsService.getAvatar(contact).then((avatar) {
    //     if (avatar == null) return; // Don't redraw if no change.
    //     setState(() => contact.avatar = avatar);
    //   });
    // }
  }
}
