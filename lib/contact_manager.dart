import 'package:ensemble/framework/stub/contacts_manager.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactManagerImpl extends ContactManager {
  @override
  void getPhoneContacts(
      ContactSuccessCallback onSuccess, ContactErrorCallback onError) async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      FlutterContacts.getContacts(
              withProperties: true,
              withPhoto: true,
              withThumbnail: true,
              withAccounts: true,
              withGroups: true)
          .then((contacts) {
        final mappedContacts =
            contacts.map((contact) => contact.toJson()).toList();
        onSuccess(mappedContacts);
      }).catchError((error) {
        onError('Failed to fetch contacts: $error');
      });
    } else {
      onError('Failed to fetch contacts');
    }
  }
}
